class ApiConst {
  static const String baseUrl = 'https://adixonclinicos.info/api';
  static const String registerEndpoint = '/auth/register';
  static const String loginEndpoint = '/auth/login';
  static const String forgotPasswordEndpoint = '/auth/forgot-password';
  static const String verifyOtpEndpoint = '/auth/verify-otp';
  static const String resetPasswordEndpoint = '/auth/reset-password';

  static const String me = '/auth/me';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh-token';
  static const String doctors = '/auth/doctors';

  // =========================
  // PATIENT APIs
  // =========================
  static const String patients = '/patients';
  static const String patientsEndpoint = '/patients';
  static const String patientSearch = '/patients/search';

  // =========================
  // APPOINTMENT APIs
  // =========================
  static const String appointments = '/appointments';
  static const String todayAppointments = '/appointments/today';
  static const String appointmentCalendar = '/appointments/calendar';

  // =========================
  // PRESCRIPTION APIs
  // =========================
  static const String prescriptions = '/prescriptions';

  // =========================
  // CERTIFICATE APIs
  // =========================
  static const String certificates = '/certificates';

  // =========================
  // INSTRUCTION APIs
  // =========================
  static const String instructions = '/instructions';

  // =========================
  // CONSENT APIs
  // =========================
  static const String consentEndpoint = "/consents";

  // =========================
  // TEMPLATE APIs
  // =========================
  static const String templatesEndpoint = '/templates';
  static const String templateSearch = '/templates/search';

  // =========================
  // REMINDER APIs
  // =========================
  static const String reminders = '/reminders';

  // =========================
  // INVOICE APIs
  // =========================
  static const String invoices = '/invoices';

  // =========================
  // RECORD APIs
  // =========================
  static const String records = '/records';
}
