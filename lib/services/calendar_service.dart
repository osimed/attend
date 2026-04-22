import 'dart:typed_data';

import 'package:attend/core/extensions.dart';
import 'package:attend/database/database.dart';
import 'package:flutter/material.dart' show DateUtils;
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
      pdf.addPage(
        pw.MultiPage(
          pageFormat: .a4,
          orientation: .landscape,
          margin: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          maxPages: 100,
          build: (pw.Context context) {
            return [
              pw.Table(
                border: pw.TableBorder.all(width: 0.5),
                children: [
                  _buildPageTitle(rows.first, month, half),
                  _buildColumnHeaders(month, half),
                  ...rows.map((row) => _buildEmployeeRow(row, month, half)),
                ],
              ),
            ];
          },
        ),
      );
    }
    return pdf.save();
  }

  pw.TableRow _buildPageTitle(
    CalendarRow row,
    DateTime month,
    (int, int) half,
  ) {
    final team = row.employee.team.fullname;
    final halfStr = half.$1 == 1 ? '1ere' : '2eme';
    final monthStr = monthName(month);
    final year = month.year.toString();
    return pw.TableRow(
      repeat: true,
      children: [
        pw.TableCell(child: pw.SizedBox(width: 36)),
        pw.TableCell(child: pw.SizedBox(width: 50)),
        pw.TableCell(
          columnSpan: 2 * (half.$2 - half.$1 + 1),
          child: pw.Padding(
            padding: const pw.EdgeInsets.all(3),
            child: pw.Text(
              'Pointage Equipe $team $halfStr quinzaine $monthStr $year SITE-MARRAKECH',
              textAlign: .center,
              style: const pw.TextStyle(fontSize: 8),
            ),
          ),
        ),
      ],
    );
  }

  pw.TableRow _buildColumnHeaders(DateTime month, (int, int) half) {
    const textStyle = pw.TextStyle(fontSize: 8, fontWeight: .bold);
    return pw.TableRow(
      repeat: true,
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(3),
          child: pw.Text('sup', style: textStyle, textAlign: .center),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(3),
          child: pw.Text('nom', style: textStyle, textAlign: .center),
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
              row.employee.id.toString(),
              style: const pw.TextStyle(fontSize: 7),
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
                  style: const pw.TextStyle(fontSize: 7),
                  textAlign: .start,
                  maxLines: 1,
                ),
                pw.Text(
                  fname.toUpperCase(),
                  style: const pw.TextStyle(fontSize: 7),
                  textAlign: .start,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
        for (int day = half.$1; day <= half.$2; day++)
          ...dayCells(row.attendances[day], month.copyWith(day: day)),
      ],
    );
  }

  List<pw.Widget> dayCells(Attendance? attendance, DateTime date) {
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
