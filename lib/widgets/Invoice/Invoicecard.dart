import 'package:flutter/material.dart';

class InvoiceCard extends StatelessWidget {
  final String name;
  final String patientId;
  final int age;
  final int amount;
  final bool isPaid;

  const InvoiceCard({
    super.key,
    required this.name,
    required this.patientId,
    required this.age,
    required this.amount,
    required this.isPaid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [

          /// 🔵 AVATAR
          Container(
            height: 45,
            width: 45,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2D9CDB), Color(0xFF6C63FF)],
              ),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                "AT",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),

          const SizedBox(width: 12),

          /// 👤 DETAILS
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "$patientId.Age $age Years",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          /// 💰 AMOUNT + STATUS
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "₹$amount",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),

              /// STATUS CHIP
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isPaid
                      ? Colors.green.withOpacity(0.15)
                      : Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  isPaid ? "Paid" : "Overdue",
                  style: TextStyle(
                    color: isPaid ? Colors.green : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}