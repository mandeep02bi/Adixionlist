class InvoiceModel {
  final String name;
  final String patientId;
    final String title;

  final String item;
  final int age;
  final int amount;
  final bool isPaid;
   final int total;
  final String date;

  InvoiceModel({
    required this.name,
    required this.patientId,
    required this.age,
    required this.amount,
    required this.isPaid,
    this.item = "",
    this.total = 0,
    this.date = "",
    this.title = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'patient_id': patientId,
      'name': name,
      'title': title,
      'item': item,
      'amount': amount,
      'total': total,
      'age': age,
      'is_paid': isPaid ? 1 : 0,
      'date': date,
    };
  }

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      patientId: map['patient_id'] ?? '',
      name: map['name'] ?? '',
      title: map['title'] ?? '',
      item: map['item'] ?? '',
      amount: map['amount'] ?? 0,
      total: map['total'] ?? 0,
      age: map['age'] ?? 0,
      isPaid: (map['is_paid'] ?? 0) == 1,
      date: map['date'] ?? '',
    );
  }
}