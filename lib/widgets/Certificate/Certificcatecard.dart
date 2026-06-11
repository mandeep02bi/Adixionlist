import 'package:flutter/material.dart';

import '../../Presentation/Certificate/CertificatePdfScreen.dart';

class CertificateCard extends StatelessWidget {
  final String title;
  final String date;
  final String patientName;
  final String description;
  final String doctorName;

  const CertificateCard({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.doctorName,
    required this.patientName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3F6),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0, 1)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.blueGrey,
            child: const Text(
              "AT",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(width: 14),

          /// TEXT (Title & Date)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Color(0xFF333333),
                    fontFamily: "Rubik",
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  date,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Colors.grey,
                    fontFamily: "Rubik",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          /// 👁 ICON
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CertificatePdfScreen(
                    patientName: patientName ?? "",
                    title: title,
                    description: description,
                    doctorName: doctorName ?? "",
                  ),
                ),
              );
            },
            child: Image.asset("assets/Icons/Eye.png", height: 22, width: 22),
          ),
        ],
      ),
    );
  }
}
