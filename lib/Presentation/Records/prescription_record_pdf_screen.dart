import 'dart:io';

import 'package:doctor/Core/services/prescription_pdf_service.dart';
import 'package:doctor/Data/model/lab_test_request_body.dart';
import 'package:doctor/Data/model/medicine_request_body.dart';
import 'package:doctor/Data/model/prescription_request_body.dart';
import 'package:doctor/Presentation/Patient/data/models/patient_model.dart';
import 'package:doctor/Presentation/Records/data/models/records_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';

/// Opens and displays a prescription PDF from the Records tab.
/// Generates the same PDF layout as when a prescription is created,
/// using the data available in [RecordPrescription].

class PrescriptionRecordPdfScreen extends StatefulWidget {
  final RecordPrescription prescription;
  final PatientModel patient;

  const PrescriptionRecordPdfScreen({
    super.key,
    required this.prescription,
    required this.patient,
  });

  @override
  State<PrescriptionRecordPdfScreen> createState() =>
      _PrescriptionRecordPdfScreenState();
}

class _PrescriptionRecordPdfScreenState
    extends State<PrescriptionRecordPdfScreen> {
  bool _isGenerating = true;
  String? _errorMessage;
  File? _pdfFile;

  @override
  void initState() {
    super.initState();
    _generatePdf();
  }

  Future<void> _generatePdf() async {
    try {
      // Build PrescriptionRequestBody from RecordPrescription fields
      final prescriptionBody = PrescriptionRequestBody(
        patientCode: widget.patient.patientCode,
        diagnosis: widget.prescription.diagnosis,
        chiefComplaint: widget.prescription.chiefComplaint,
        prescriptionDate: widget.prescription.prescriptionDate,
      );

      final file = await PrescriptionPdfService.generate(
        patient: widget.patient,
        prescription: prescriptionBody,
        medicines: <MedicineRequestBody>[],
        labTests: <LabTestRequestBody>[],
      );

      if (!mounted) return;

      setState(() {
        _pdfFile = file;
        _isGenerating = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
        _isGenerating = false;
      });
    }
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '—';
    try {
      return DateFormat('dd MMM yyyy').format(DateTime.parse(dateStr));
    } catch (_) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF4FA3A5),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Prescription',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: _isGenerating
          ? const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor:
              AlwaysStoppedAnimation<Color>(Color(0xFF4FA3A5)),
            ),
            SizedBox(height: 16),
            Text(
              'Generating Prescription...',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      )
          : _errorMessage != null
          ? Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: Colors.red,
              ),
              SizedBox(height: 12.h),
              const Text(
                'Failed to generate PDF',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _isGenerating = true;
                    _errorMessage = null;
                  });
                  _generatePdf();
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4FA3A5),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
          : SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          SizedBox(height: 15,),
            //Patient Info
            _SectionCard(
              title: 'Patient Information',
              icon: Icons.person_outline_rounded,
              child: Column(
                children: [
                  _InfoRow(
                    label: 'Name',
                    value:
                    '${widget.patient.firstName} ${widget.patient.lastName}',
                  ),
                  _InfoRow(
                    label: 'Patient Code',
                    value: widget.patient.patientCode,
                  ),
                  _InfoRow(
                    label: 'Age',
                    value: widget.patient.age != null
                        ? '${widget.patient.age} yrs'
                        : null,
                  ),
                  _InfoRow(
                    label: 'Phone',
                    value: widget.patient.phone,
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // Case History
            _SectionCard(
              title: 'Case History',
              icon: Icons.medical_information_outlined,
              child: Column(
                children: [
                  _InfoRow(
                    label: 'Diagnosis',
                    value: widget.prescription.diagnosis,
                  ),
                  _InfoRow(
                    label: 'Chief Complaint',
                    value: widget.prescription.chiefComplaint,
                  ),
                  _InfoRow(
                    label: 'Doctor',
                    value: widget.prescription.doctorName != null
                        ? 'Dr. ${widget.prescription.doctorName}'
                        : null,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Open PDF Button
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton.icon(
                onPressed: () => OpenFilex.open(_pdfFile!.path),
                icon: const Icon(Icons.picture_as_pdf_rounded),
                label: const Text(
                  'Open Full Prescription PDF',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4FA3A5),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            //Share / Download
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: OutlinedButton.icon(
                onPressed: () => OpenFilex.open(_pdfFile!.path),
                icon: const Icon(Icons.share_outlined),
                label: const Text(
                  'Share Prescription',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF4FA3A5),
                  side: const BorderSide(color: Color(0xFF4FA3A5)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable widgets

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFCCE8E8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFFEAF6F6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Icon(icon, size: 16, color: const Color(0xFF4FA3A5)),
                const SizedBox(width: 6),
                Text(
                  title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A2E3C),
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const _InfoRow({required this.label, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF6B7280),
              ),
            ),
          ),
          Expanded(
            child: Text(
              (value != null && value!.isNotEmpty) ? value! : '—',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF1A2E3C),
              ),
            ),
          ),
        ],
      ),
    );
  }
}