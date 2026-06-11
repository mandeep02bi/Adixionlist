import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CertificatePdfScreen extends StatelessWidget {
  final String patientName;
  final String title;
  final String description;
  final String doctorName;

  const CertificatePdfScreen({
    super.key,
    required this.patientName,
    required this.title,
    required this.description,
    required this.doctorName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Certificate PDF")),
      body: PdfPreview(
        build: (format) async {
          final pdf = pw.Document();

          pdf.addPage(
            pw.Page(
              build: (context) {
                return pw.Column(
                  children: [
                    pw.Text(
                      title,
                      style: pw.TextStyle(fontSize: 28,),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Text("Patient: $patientName"),
                    pw.SizedBox(height: 10),
                    pw.Text(description),
                    pw.SizedBox(height: 20),
                    pw.Text("Doctor: $doctorName"),
                  ],
                );
              },
            ),
          );

          return pdf.save();
        },
      ),
    );
  }
}