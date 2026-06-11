class MedicineModel {
  final int? id;
  final String medicineName;
  final String qty;
  final String frequency;
  final String routeForm;
  final String noOfDays;
  final String instruction;
  final String? type;
  final String? additionalComments;

  MedicineModel({
    this.id,
    required this.medicineName,
    required this.qty,
    required this.frequency,
    required this.routeForm,
    required this.noOfDays,
    required this.instruction,
    this.type,
    this.additionalComments,
  });

  // Getters for compatibility with API models
  String get name => medicineName;
  String get totalQuantity => qty;
  String get instructions => instruction;
  
  // Getter for lab tests (when type == 'lab', medicineName holds the test name)
  String get testName => medicineName;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medicine_name': medicineName, 
      'qty': qty,
      'frequency': frequency,
      'route_form': routeForm,
      'no_of_days': noOfDays,
      'instruction': instruction,
      'type': type,
      'additional_comments': additionalComments,
    };
  }

  factory MedicineModel.fromMap(Map<String, dynamic> map) {
    return MedicineModel(
      id: map['id'],
      medicineName: map['medicine_name'] ?? map['medicineName'] ?? '',
      qty: map['qty'] ?? '',
      frequency: map['frequency'] ?? '',
      routeForm: map['route_form'] ?? map['routeForm'] ?? '',
      noOfDays: map['no_of_days'] ?? map['noOfDays'] ?? '',
      instruction: map['instruction'] ?? '',
      type: map['type'] ?? 'medicine',
      additionalComments: map['additional_comments'] ?? map['additionalComments'],
    );
  }
}