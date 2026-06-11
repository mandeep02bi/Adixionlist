// // GENERATED - part of prescription_cubit.dart

// part of 'prescription_cubit.dart';

// abstract class PrescriptionState {
//   const PrescriptionState();
// }

// class PrescriptionInitial extends PrescriptionState {}

// class PrescriptionLoading extends PrescriptionState {}

// class PrescriptionProgress extends PrescriptionState {
//   final String message;
//   const PrescriptionProgress({required this.message});
// }

// class PrescriptionSuccess extends PrescriptionState {
//   final int prescriptionId;
//   final PrescriptionDetail detail;

//   const PrescriptionSuccess({
//     required this.prescriptionId,
//     required this.detail,
//   });
// }

// class PrescriptionError extends PrescriptionState {
//   final String message;
//   const PrescriptionError(this.message);
// }

abstract class PrescriptionState {}

class PrescriptionInitial extends PrescriptionState {}

class PrescriptionLoading extends PrescriptionState {}

class PrescriptionProgress extends PrescriptionState {
  final String message;

  PrescriptionProgress(this.message);
}

class PrescriptionSuccess extends PrescriptionState {
  final dynamic detail;

  PrescriptionSuccess(this.detail);
}

class PrescriptionError extends PrescriptionState {
  final String message;

  PrescriptionError(this.message);
}
