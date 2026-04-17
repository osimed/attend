import 'dart:typed_data';

import 'package:attend/core/extensions.dart';
import 'package:attend/database/database.dart';
import 'package:attend/services/attend_service.dart';
import 'package:flutter/material.dart' show DateUtils;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Map<int, pw.TableColumnWidth> _columns() => {
  0: const pw.FlexColumnWidth(0.06), // JOUR
  1: const pw.FlexColumnWidth(0.13), // DÉBUT
  2: const pw.FlexColumnWidth(0.13), // FIN
  3: const pw.FlexColumnWidth(0.13), // SUPP
  4: const pw.FlexColumnWidth(0.13), // RÉCUP
  5: const pw.FlexColumnWidth(0.13), // RESTANT
  6: const pw.FlexColumnWidth(0.14), // SIGNATURE
  7: const pw.FlexColumnWidth(0.15), // EXPLICATION
};

final _headerStyle = pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold);

const _cellStyle = pw.TextStyle(fontSize: 8);

final _boldCellStyle = pw.TextStyle(fontSize: 10, fontWeight: .bold);

final _collectedStyle = pw.TextStyle(fontSize: 17, fontWeight: .bold);

final _statusStyle = pw.TextStyle(fontSize: 10, font: pw.Font.courier());

final _weekTotalStyle = pw.TextStyle(fontSize: 8, fontWeight: .bold);

final _statusPadding = const pw.EdgeInsets.symmetric(
  horizontal: 5,
  vertical: 1,
);

final _totalStyle = pw.TextStyle(fontSize: 8, fontWeight: .bold);

class ExportService {
  final AttendService _attendService;

  ExportService(this._attendService);

  Future<Uint8List> genTeamPdf(List<CalendarRow> rows, DateTime month) async {
    final pdf = pw.Document();
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);

    final team = rows.first.employee.team;
    final prevAttns = await _attendService.getAttendancesUpToMonth(team, month);

    for (final row in rows) {
      final List<_DayData> days = [];

      Duration weekRecup = .zero;
      Duration weekSupp = .zero;

      double rDays = 0.0;
      double cDays = 0.0;

      final leaveDate = row.employee.leaveDate;
      int? leaveDay;
      if (leaveDate != null &&
          leaveDate.year == month.year &&
          leaveDate.month == month.month) {
        leaveDay = leaveDate.day;
      }

      for (int day = 1; day <= daysInMonth; day++) {
        final date = DateTime(month.year, month.month, day);
        Attendance? attendance = row.attendances[day];

        if (leaveDay != null && leaveDay <= day) {
          attendance = null;
        }

        final status = attendance?.status;
        final diff = _attendService.calcTimeDiff(attendance);

        List<Duration> weekSum = [];
        if (diff != null) {
          if (!diff.isNegative) {
            weekSupp += diff;
          } else {
            weekRecup += diff;
          }
        }
        final isSunday = date.weekday == DateTime.sunday;
        final isFilled = attendance?.status == .p;
        if (isSunday && !isFilled) {
          weekSum.addAll([weekRecup, weekSupp]);
          weekRecup = weekSupp = .zero;
        }

        if (status == .r) rDays += status!.dayValue(date);
        if (status == .c) cDays += status!.dayValue(date);

        days.add(
          _DayData(
            day: day,
            date: date,
            attendance: attendance,
            diff: diff,
            weekSum: weekSum,
            isLeaveDate: leaveDay == day,
          ),
        );
      }
      final initCollected = row.employee.collected;
      final prevCollected = _attendService.calcCollected(
        prevAttns[row.employee.id],
      );
      final collected = prevCollected + initCollected;

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: .stretch,
              children: [
                pw.Text(
                  collected.formatTime(),
                  style: _collectedStyle,
                  textAlign: .center,
                ),
                pw.SizedBox(height: 6),
                _buildPageHeader(row.employee, month),
                pw.SizedBox(height: 6),
                pw.Table(
                  border: pw.TableBorder.all(width: 0.5),
                  columnWidths: _columns(),
                  children: [
                    _buildColumnHeaders(),
                    ...days.map((d) => _buildDayRow(d)),
                    _buildTotalRow(days, weekSupp + weekRecup, collected),
                  ],
                ),
                pw.SizedBox(height: 16),
                _buildSignatureRow(rDays, cDays),
              ],
            );
          },
        ),
      );
    }
    return pdf.save();
  }

  pw.Widget _buildPageHeader(Employee employee, DateTime month) {
    final labelStyle = pw.TextStyle(
      fontSize: 7,
      fontWeight: pw.FontWeight.bold,
    );
    final valueStyle = pw.TextStyle(
      fontSize: 9,
      fontWeight: pw.FontWeight.bold,
    );

    pw.Widget field(String label, String value, {double flex = 1}) =>
        pw.Expanded(
          flex: (flex * 10).toInt(),
          child: pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            decoration: pw.BoxDecoration(border: pw.Border.all(width: 0.5)),
            child: pw.Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .center,
              children: [
                pw.Text(label, style: labelStyle),
                pw.Text(value, style: valueStyle),
              ],
            ),
          ),
        );

    return pw.SizedBox(
      height: 30,
      child: pw.Row(
        children: [
          field('SUP', employee.id.toString(), flex: 0.8),
          field(
            'NOM PRÉNOM',
            '${employee.lastName.toUpperCase()} ${employee.firstName.toUpperCase()}',
            flex: 2.2,
          ),
          field(
            'POSTE',
            '${employee.team.fullname} - ${employee.job}',
            flex: 2.8,
          ),
          field('MOIS', month.month.toString().padLeft(2, '0'), flex: 0.6),
          field('AN', month.year.toString(), flex: 0.6),
        ],
      ),
    );
  }

  pw.TableRow _buildColumnHeaders() {
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.grey300),
      children: [
        _headerCell('JOUR'),
        _headerCell('DÉBUT DE\nTRAVAIL'),
        _headerCell('FIN DE\nTRAVAIL'),
        _headerCell('HEURES\nSUPP'),
        _headerCell('HEURES\nRÉCUP'),
        _headerCell('HEURES\nRESTANTS'),
        _headerCell('SIGNATURE'),
        _headerCell('EXPLICATION'),
      ],
    );
  }

  pw.TableRow _buildDayRow(_DayData d) {
    if (d.isLeaveDate) {
      return pw.TableRow(
        children: [
          _dataCell(
            d.day.toString(),
            style: _boldCellStyle,
            align: pw.Alignment.center,
          ),
          for (int i = 0; i < 7; i++)
            _dataCell(
              'DEMISSION',
              style: _statusStyle,
              align: pw.Alignment.center,
            ),
        ],
      );
    }

    final isWeekTotal = d.weekSum.isNotEmpty;
    final bg = isWeekTotal ? PdfColors.grey200 : PdfColors.white;
    final status = d.attendance?.status;

    final String start;
    final String end;
    final String reason;

    bool isStatusDisplay = false;
    if (isWeekTotal) {
      start = 'DIM';
      end = 'DIM';
      reason = '';
    } else if (status == null || status == .empty) {
      start = '';
      end = '';
      reason = '';
    } else if (status == .p) {
      start = d.attendance!.enter?.displayTime() ?? '--:--';
      end = d.attendance!.leave?.displayTime() ?? '--:--';
      reason = '';
    } else {
      start = end = status.name.toUpperCase();
      reason = status.fullname;
      isStatusDisplay = true;
    }

    final suppStr = (d.diff != null && !d.diff!.isNegative)
        ? d.diff!.formatTime()
        : '';
    final recupStr = (d.diff != null && d.diff!.isNegative)
        ? d.diff!.formatTime()
        : '';

    Duration restant = .zero;
    if (isWeekTotal) {
      restant = d.weekSum.first + d.weekSum.last;
    }

    final statusColor = status?.color?.toARGB32();
    final color = statusColor != null ? PdfColor.fromInt(statusColor) : null;
    final isLunchBreak = (d.attendance?.lunchBreak ?? true);

    return pw.TableRow(
      decoration: pw.BoxDecoration(color: bg),
      children: [
        _dataCell(
          d.day.toString(),
          style: _boldCellStyle,
          align: pw.Alignment.center,
        ),
        _dataCell(
          start,
          align: .center,
          color: color,
          padding: isStatusDisplay ? _statusPadding : null,
          style: isStatusDisplay ? _statusStyle : null,
        ),
        _dataCell(
          end,
          align: .center,
          color: color,
          padding: isStatusDisplay ? _statusPadding : null,
          style: isStatusDisplay ? _statusStyle : null,
        ),
        _dataCell(
          isWeekTotal ? d.weekSum.last.formatTime() : suppStr,
          align: .center,
          style: isWeekTotal
              ? _weekTotalStyle
              : _cellStyle.copyWith(
                  decoration: !isLunchBreak ? .underline : null,
                ),
        ),
        _dataCell(
          isWeekTotal ? d.weekSum.first.formatTime() : recupStr,
          align: .center,
          style: isWeekTotal
              ? _weekTotalStyle
              : _cellStyle.copyWith(
                  decoration: !isLunchBreak ? .underline : null,
                ),
        ),
        _dataCell(
          isWeekTotal ? restant.formatTime() : '',
          align: .center,
          style: isWeekTotal
              ? _weekTotalStyle.copyWith(color: PdfColors.red600)
              : null,
        ),
        _dataCell(isWeekTotal ? 'DIM' : '', align: .center),
        _dataCell(reason),
      ],
    );
  }

  pw.TableRow _buildTotalRow(
    List<_DayData> days,
    Duration leftover,
    Duration collected,
  ) {
    Duration total = leftover;
    for (final day in days) {
      if (day.weekSum.isNotEmpty) {
        total += day.weekSum.first + day.weekSum.last;
      }
    }
    return pw.TableRow(
      decoration: const pw.BoxDecoration(color: PdfColors.grey300),
      children: [
        _dataCell('TOTAL', style: _totalStyle, align: .center, padding: .zero),
        _dataCell(''),
        _dataCell(''),
        _dataCell(''),
        _dataCell(''),
        _dataCell(total.formatTime(), style: _totalStyle, align: .center),
        _dataCell(collected.formatTime(), style: _totalStyle, align: .center),
        _dataCell(
          (total + collected).formatTime(),
          style: _totalStyle,
          align: .center,
        ),
      ],
    );
  }

  pw.Widget _buildSignatureRow(double rDays, double cDays) {
    final style = pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold);
    return pw.Row(
      children: [
        pw.Expanded(child: pw.Text('Chef signature', style: style)),
        pw.Expanded(
          child: pw.Text(
            "Directeur d'entrepôt et de logistique\nsignature",
            style: style,
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            mainAxisSize: .min,
            children: [
              pw.Text('${Status.r.fullname}: $rDays', style: style),
              pw.Text('${Status.c.fullname}: $cDays', style: style),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _headerCell(String text) => pw.SizedBox(
    height: 30,
    child: pw.Center(
      child: pw.Text(text, style: _headerStyle, textAlign: pw.TextAlign.center),
    ),
  );

  pw.Widget _dataCell(
    String text, {
    PdfColor? color,
    pw.TextStyle? style,
    pw.Alignment align = .centerLeft,
    pw.EdgeInsets? padding = const .symmetric(horizontal: 2),
  }) => pw.Container(
    height: 20,
    child: pw.Align(
      alignment: align,
      child: pw.Container(
        color: color,
        padding: padding,
        child: pw.Text(text, style: style ?? _cellStyle),
      ),
    ),
  );
}

class _DayData {
  final int day;
  final DateTime date;
  final Attendance? attendance;
  final Duration? diff;
  final List<Duration> weekSum;
  final bool isLeaveDate;

  _DayData({
    required this.day,
    required this.date,
    required this.attendance,
    required this.diff,
    required this.weekSum,
    required this.isLeaveDate,
  });
}
