import 'dart:io';

import 'package:doctor/Data/model/lab_test_request_body.dart';
import 'package:doctor/Data/model/medicine_request_body.dart';
import 'package:doctor/Data/model/prescription_request_body.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';

import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrescriptionPdfService {
  /// Generates Prescription PDF
  static Future<File> generate({
    required PatientModel patient,
    required PrescriptionRequestBody prescription,
    required List<MedicineRequestBody> medicines,
    required List<LabTestRequestBody> labTests,
  }) async {
    final pdf = pw.Document();

    /// Fonts
    final regularFont = await PdfGoogleFonts.notoSansRegular();
    final boldFont = await PdfGoogleFonts.notoSansBold();

    /// Colors
    const headerBg = PdfColor.fromInt(0xFF4FA3A5);
    const lightBg = PdfColor.fromInt(0xFFEAF6F6);
    const divider = PdfColor.fromInt(0xFFCCE8E8);
    const darkText = PdfColor.fromInt(0xFF1A2E3C);
    const grayText = PdfColor.fromInt(0xFF6B7280);

    /// Text Styles
    pw.TextStyle body({bool bold = false, double size = 9}) {
      return pw.TextStyle(
        font: bold ? boldFont : regularFont,
        fontSize: size,
        color: darkText,
      );
    }

    pw.TextStyle gray({double size = 8.5}) {
      return pw.TextStyle(font: regularFont, fontSize: size, color: grayText);
    }

    /// Section Title
    pw.Widget sectionTitle(String title) {
      return pw.Container(
        margin: const pw.EdgeInsets.only(top: 10, bottom: 4),
        padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: const pw.BoxDecoration(color: lightBg),
        child: pw.Text(title, style: body(bold: true, size: 9.5)),
      );
    }

    /// Label Value Row
    pw.Widget labelValue(String label, String? value) {
      return pw.Padding(
        padding: const pw.EdgeInsets.symmetric(vertical: 2),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(width: 120, child: pw.Text('$label:', style: gray())),
            pw.Expanded(
              child: pw.Text(
                value != null && value.isNotEmpty ? value : '-',
                style: body(),
              ),
            ),
          ],
        ),
      );
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),

        build: (context) {
          return [
            /// HEADER
            pw.Container(
              padding: const pw.EdgeInsets.all(14),
              decoration: const pw.BoxDecoration(color: headerBg),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'PRESCRIPTION',
                        style: pw.TextStyle(
                          font: boldFont,
                          fontSize: 16,
                          color: PdfColors.white,
                        ),
                      ),

                      pw.SizedBox(height: 4),

                      pw.Text(
                        'Date: ${DateFormat('dd MMM yyyy').format(DateTime.now())}',
                        style: pw.TextStyle(
                          font: regularFont,
                          fontSize: 9,
                          color: PdfColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            pw.SizedBox(height: 10),

            /// PATIENT INFO
            pw.Container(
              padding: const pw.EdgeInsets.all(10),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(color: divider),
                borderRadius: pw.BorderRadius.circular(4),
              ),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "${patient.firstName} ${patient.lastName}",
                          style: body(bold: true, size: 11),
                        ),

                        pw.SizedBox(height: 3),

                        pw.Text(
                          [
                                patient.patientCode,
                                patient.gender,
                                "${patient.age} yrs",
                                patient.city,
                              ]
                              .where(
                                (e) => e != null && e.toString().isNotEmpty,
                              )
                              .join(' | '),
                          style: gray(),
                        ),
                      ],
                    ),
                  ),

                  pw.Text(patient.phone?.toString() ?? '', style: gray()),
                ],
              ),
            ),

            pw.SizedBox(height: 8),

            /// VITALS
            if (_anyVital(prescription)) ...[
              sectionTitle("VITALS"),

              pw.Wrap(
                spacing: 16,
                runSpacing: 4,
                children: [
                  if (prescription.height != null)
                    _vitalChip(
                      'Height',
                      '${prescription.height}',
                      regularFont,
                      boldFont,
                    ),

                  if (prescription.weight != null)
                    _vitalChip(
                      'Weight',
                      '${prescription.weight}',
                      regularFont,
                      boldFont,
                    ),

                  if (prescription.temperature != null)
                    _vitalChip(
                      'Temp',
                      '${prescription.temperature}',
                      regularFont,
                      boldFont,
                    ),

                  if (prescription.pulse != null)
                    _vitalChip(
                      'Pulse',
                      '${prescription.pulse}',
                      regularFont,
                      boldFont,
                    ),

                  if (prescription.bloodPressure != null)
                    _vitalChip(
                      'BP',
                      '${prescription.bloodPressure}',
                      regularFont,
                      boldFont,
                    ),

                  if (prescription.spo2 != null)
                    _vitalChip(
                      'SpO2',
                      '${prescription.spo2}',
                      regularFont,
                      boldFont,
                    ),
                ],
              ),
            ],

            /// CASE HISTORY
            sectionTitle("CASE HISTORY"),

            labelValue("Chief Complaint", prescription.chiefComplaint),

            labelValue("Diagnosis", prescription.diagnosis),

            labelValue("Findings", prescription.findings),

            labelValue("Allergy", prescription.allergy),

            labelValue("History", prescription.history),

            labelValue("Treatment Advice", prescription.treatmentAdvice),

            labelValue("Notes", prescription.notes),

            labelValue("Follow Up", prescription.followUpDate),

            pw.SizedBox(height: 10),

            /// MEDICINES
            if (medicines.isNotEmpty) ...[
              sectionTitle("MEDICINES"),

              pw.Table(
                border: pw.TableBorder.all(color: divider, width: 0.5),

                columnWidths: {
                  0: const pw.FlexColumnWidth(3),
                  1: const pw.FlexColumnWidth(2),
                  2: const pw.FlexColumnWidth(2),
                  3: const pw.FlexColumnWidth(2),
                },

                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: lightBg),

                    children: [
                      _tableHeader("Medicine", boldFont),
                      _tableHeader("Frequency", boldFont),
                      _tableHeader("Days", boldFont),
                      _tableHeader("Qty", boldFont),
                    ],
                  ),

                  ...medicines.map((m) {
                    return pw.TableRow(
                      children: [
                        _tableCell(m.name, regularFont),

                        _tableCell(m.frequency ?? '-', regularFont),

                        _tableCell(m.noOfDays ?? '-', regularFont),

                        _tableCell(m.totalQuantity ?? '-', regularFont),
                      ],
                    );
                  }),
                ],
              ),
            ],

            pw.SizedBox(height: 10),

            /// LAB TESTS
            if (labTests.isNotEmpty) ...[
              sectionTitle("LAB TESTS"),

              pw.Table(
                border: pw.TableBorder.all(color: divider, width: 0.5),

                children: [
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(color: lightBg),

                    children: [
                      _tableHeader("Test Name", boldFont),

                      _tableHeader("Comments", boldFont),
                    ],
                  ),

                  ...labTests.map((lab) {
                    return pw.TableRow(
                      children: [
                        _tableCell(lab.testName, regularFont),

                        _tableCell(lab.additionalComments ?? '-', regularFont),
                      ],
                    );
                  }),
                ],
              ),
            ],

            pw.SizedBox(height: 30),

            /// SIGNATURE
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Container(
                    width: 120,
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(top: pw.BorderSide(color: darkText)),
                    ),
                  ),

                  pw.SizedBox(height: 4),

                  pw.Text("Doctor Signature", style: body(bold: true)),
                ],
              ),
            ),
          ];
        },
      ),
    );

    /// SAVE FILE
    final dir = await getTemporaryDirectory();

    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());

    final file = File('${dir.path}/prescription_$timestamp.pdf');

    await file.writeAsBytes(await pdf.save());

    return file;
  }

  /// CHECK VITALS
  static bool _anyVital(PrescriptionRequestBody d) {
    return d.height != null ||
        d.weight != null ||
        d.pulse != null ||
        d.bloodPressure != null ||
        d.temperature != null ||
        d.spo2 != null;
  }

  /// VITAL CHIP
  static pw.Widget _vitalChip(
    String label,
    String value,
    pw.Font regular,
    pw.Font bold,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),

      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: const PdfColor.fromInt(0xFFCCE8E8)),

        borderRadius: pw.BorderRadius.circular(4),
      ),

      child: pw.Column(
        children: [
          pw.Text(
            value,
            style: pw.TextStyle(
              font: bold,
              fontSize: 9,
              color: const PdfColor.fromInt(0xFF4FA3A5),
            ),
          ),

          pw.Text(
            label,
            style: pw.TextStyle(
              font: regular,
              fontSize: 7.5,
              color: const PdfColor.fromInt(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }

  /// TABLE HEADER
  static pw.Widget _tableHeader(String text, pw.Font bold) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(5),

      child: pw.Text(
        text,
        style: pw.TextStyle(
          font: bold,
          fontSize: 8,
          color: const PdfColor.fromInt(0xFF1A2E3C),
        ),
      ),
    );
  }

  /// TABLE CELL
  static pw.Widget _tableCell(dynamic text, pw.Font regular) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(5),

      child: pw.Text(
        (text == null || text.toString().isEmpty) ? '-' : text.toString(),
        style: pw.TextStyle(
          font: regular,
          fontSize: 8,
          color: const PdfColor.fromInt(0xFF374151),
        ),
      ),
    );
  }
}
