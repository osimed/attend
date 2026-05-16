import 'dart:typed_data';

import 'package:attend/core/extensions.dart';
import 'package:attend/database/database.dart';
import 'package:flutter/material.dart' show DateUtils, Colors;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CalendarService {
  CalendarService();

  Future<Uint8List> genCalendarPdf(
    List<CalendarRow> rows,
    DateTime month,
  ) async {
    final pdf = pw.Document();

    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final monthMiddle = daysInMonth ~/ 2;
    final monthHalfs = [(1, monthMiddle), (monthMiddle + 1, daysInMonth)];
    for (final half in monthHalfs) {
      final filteredRows = rows.where((row) {
        var ld = row.employee.leaveDate;
        if (ld == null) return true;
        if (ld.year != month.year || ld.month != month.month) {
          return true;
        }
        if (ld.day > half.$2) return true;
        return ld.day >= half.$1 && ld.day <= half.$2;
      }).toList();

      for (final rowChunk in filteredRows.chunk(22)) {
        pdf.addPage(
          pw.Page(
            pageFormat: .a4,
            orientation: .landscape,
            margin: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            build: (pw.Context context) {
              return pw.Column(
                children: [
                  _buildPageTitle(rows.first, month, half),
                  pw.SizedBox(height: 3),
                  pw.Table(
                    border: pw.TableBorder.all(width: 0.5),
                    children: [
                      _buildColumnHeaders(month, half),
                      ...rowChunk.map(
                        (row) => _buildEmployeeRow(row, month, half),
                      ),
                    ],
                  ),
                  pw.Spacer(),
                  _buildPageFooter(),
                ],
              );
            },
          ),
        );
      }
    }
    return pdf.save();
  }

  pw.Widget _buildPageFooter() {
    const style = pw.TextStyle(fontSize: 11, fontWeight: pw.FontWeight.bold);
    return pw.SizedBox(
      height: 65,
      child: pw.Row(
        crossAxisAlignment: .start,
        children: [
          pw.Expanded(
            child: pw.GridView(
              direction: .horizontal,
              crossAxisCount: 4,
              children: Status.values
                  .where((s) => s.fullname.isNotEmpty)
                  .map(
                    (s) => pw.Container(
                      color: PdfColor.fromInt(s.color!.toARGB32()),
                      child: pw.Center(
                        child: pw.RichText(
                          text: pw.TextSpan(
                            text: '${s.name.toUpperCase()}: ',
                            style: style,
                            children: [
                              pw.TextSpan(
                                text: s.fullname,
                                style: style.copyWith(fontSize: 9),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          pw.VerticalDivider(),
          pw.Expanded(child: pw.Text('Chef signature', style: style)),
          pw.VerticalDivider(),
          pw.Expanded(
            child: pw.Text(
              "Directeur d'entrepôt et de logistique\nsignature",
              style: style,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPageTitle(CalendarRow row, DateTime month, (int, int) half) {
    final team = row.employee.team.fullname;
    final halfStr = half.$1 == 1 ? '1ere' : '2eme';
    final monthStr = monthName(month);
    final year = month.year.toString();
    return pw.Padding(
      padding: const pw.EdgeInsets.all(3),
      child: pw.Text(
        'Pointage Equipe $team $halfStr quinzaine $monthStr $year SITE-MARRAKECH',
        textAlign: .center,
        style: const pw.TextStyle(fontSize: 10),
      ),
    );
  }

  pw.TableRow _buildColumnHeaders(DateTime month, (int, int) half) {
    const textStyle = pw.TextStyle(fontSize: 8, fontWeight: .bold);
    return pw.TableRow(
      repeat: true,
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(3),
          child: pw.Text('SAP', style: textStyle, textAlign: .center),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(3),
          child: pw.Text('NOM', style: textStyle, textAlign: .center),
        ),
        for (int day = half.$1; day <= half.$2; day++)
          pw.TableCell(
            columnSpan: 2,
            child: pw.Padding(
              padding: const pw.EdgeInsets.all(3),
              child: pw.Text(
                '${dayName(month.copyWith(day: day))} $day',
                style: textStyle,
                textAlign: .center,
              ),
            ),
          ),
      ],
    );
  }

  pw.TableRow _buildEmployeeRow(
    CalendarRow row,
    DateTime month,
    (int, int) half,
  ) {
    const m = 10;
    String fname = row.employee.firstName;
    fname = fname.substring(0, fname.length > m ? m : null);
    String lname = row.employee.lastName;
    lname = lname.substring(0, lname.length > m ? m : null);
    return pw.TableRow(
      verticalAlignment: .full,
      children: [
        pw.SizedBox(
          width: 36,
          child: pw.Center(
            child: pw.Text(
              row.employee.sap.toString(),
              style: const pw.TextStyle(fontSize: 6),
            ),
          ),
        ),
        pw.SizedBox(
          width: 50,
          child: pw.Padding(
            padding: const pw.EdgeInsets.all(3),
            child: pw.Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                pw.Text(
                  lname.toUpperCase(),
                  style: const pw.TextStyle(fontSize: 5.5),
                  textAlign: .start,
                  maxLines: 1,
                ),
                pw.Text(
                  fname.toUpperCase(),
                  style: const pw.TextStyle(fontSize: 5.5),
                  textAlign: .start,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
        for (int day = half.$1; day <= half.$2; day++)
          ...dayCells(
            row,
            row.attendances[day],
            month.copyWith(day: day),
            half.$2,
          ),
      ],
    );
  }

  List<pw.Widget> dayCells(
    CalendarRow row,
    Attendance? attendance,
    DateTime date,
    int end,
  ) {
    final leaveDate = row.employee.leaveDate;
    final leaveReason = row.employee.leaveReason;
    int? leaveDay;
    if (leaveDate != null &&
        leaveDate.year == date.year &&
        leaveDate.month == date.month) {
      leaveDay = leaveDate.day;
    }
    final day = date.day;
    if (leaveDay != null && leaveDay == day) {
      final l = 2 * (end - day + 1);
      return [
        pw.TableCell(
          columnSpan: l,
          child: pw.Container(
            color: PdfColor.fromInt(Colors.lime.toARGB32()),
            child: pw.Center(
              child: pw.Text(
                leaveReason?.fullname ?? '',
                style: pw.TextStyle(fontSize: l <= 6 ? 7 : 10),
                textAlign: .center,
              ),
            ),
          ),
        ),
      ];
    }
    if (leaveDay != null && leaveDay < day) return [];

    final status = attendance?.status ?? .empty;
    final isSunday = date.weekday == DateTime.sunday;
    if (status == .empty && isSunday) {
      final dash = pw.Center(child: pw.SizedBox(width: 5, child: pw.Divider()));
      return [pw.Expanded(child: dash), pw.Expanded(child: dash)];
    }
    if (status != .empty && status != .p) {
      final statusName = status.name.toUpperCase();
      final statusColor = status.color?.toARGB32();
      final color = statusColor != null ? PdfColor.fromInt(statusColor) : null;
      final statusWidget = pw.Container(
        color: color,
        child: pw.Center(child: pw.Text(statusName)),
      );
      return [
        pw.Expanded(child: statusWidget),
        pw.Expanded(child: statusWidget),
      ];
    }
    final enter = attendance?.enter?.displayTime() ?? '';
    final leave = attendance?.leave?.displayTime() ?? '';
    const timeStyle = pw.TextStyle(fontSize: 8);
    return [
      pw.Expanded(
        child: pw.Center(child: pw.Text(enter, style: timeStyle)),
      ),
      pw.Expanded(
        child: pw.Center(child: pw.Text(leave, style: timeStyle)),
      ),
    ];
  }
}

String dayName(DateTime date) {
  const days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
  return days[date.weekday - 1];
}

String monthName(DateTime date) {
  const days = [
    'Janvier',
    'Février',
    'Mars',
    'Avril',
    'Mai',
    'Juin',
    'Juillet',
    'Août',
    'Septembre',
    'Novembre',
    'Décembre',
  ];
  return days[date.month - 1];
}
