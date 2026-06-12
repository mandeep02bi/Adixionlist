import 'package:doctor/Core/Bloc/Add_patient_bloc.dart';
import 'package:doctor/Core/networking/dio_factory.dart';
import 'package:doctor/Core/helper/token_storage_service.dart';
import 'package:doctor/Data/Api/prescription_api_service.dart';
import 'package:doctor/Data/repository/prescription_repository.dart';
import 'package:doctor/Presentation/AuthScreen/data/api/register_api_service.dart';
import 'package:doctor/Presentation/AuthScreen/data/repo/register_repo.dart';
import 'package:doctor/Presentation/AuthScreen/data/api/login_api_service.dart';
import 'package:doctor/Presentation/AuthScreen/data/repo/login_repo.dart';
import 'package:doctor/Presentation/AuthScreen/data/api/forgot_password_api_service.dart';
import 'package:doctor/Presentation/AuthScreen/data/repo/forgot_password_repo.dart';
import 'package:doctor/Presentation/AuthScreen/logic/forgot_password/forgot_password_cubit.dart';
import 'package:doctor/Presentation/AuthScreen/logic/login/login_cubit.dart';
import 'package:doctor/Presentation/AuthScreen/logic/register/register_cubit.dart';
import 'package:doctor/Presentation/Consent/data/api/consent_api_service.dart';
import 'package:doctor/Presentation/Consent/data/repository/consent_repo.dart';
import 'package:doctor/Presentation/Consent/cubit/consent_cubit.dart';
import 'package:doctor/Presentation/MyTemplate/Data/api/template_service.dart';
import 'package:doctor/Presentation/MyTemplate/Data/repository/template_repository.dart';

import 'package:doctor/Presentation/MyTemplate/cubit/template_cubit.dart';
import 'package:doctor/Presentation/Patient/data/api/patient_api_service.dart';
import 'package:doctor/Presentation/Patient/data/repo/patient_repo.dart';
import 'package:doctor/Presentation/Patient/logic/patient_cubit.dart';
import 'package:doctor/Presentation/Appointment/data/api/appointment_api_service.dart';
import 'package:doctor/Presentation/Appointment/data/repo/appointment_repo.dart';
import 'package:doctor/Presentation/Appointment/logic/appointment_cubit.dart';
import 'package:doctor/Presentation/Prescription/cubit/prescription_cubit.dart';
import 'package:doctor/Presentation/Reminder/data/api/reminder_api_service.dart';
import 'package:doctor/Presentation/Reminder/data/repo/reminder_repo.dart';
import 'package:doctor/Presentation/Reminder/logic/reminder_cubit.dart';
import 'package:doctor/Presentation/Invoice/data/api/invoice_api_service.dart';
import 'package:doctor/Presentation/Invoice/data/repo/invoice_repo.dart';
import 'package:doctor/Presentation/Invoice/logic/invoice_cubit.dart';
import 'package:doctor/Presentation/Certificate/data/api/certificate_api_service.dart';
import 'package:doctor/Presentation/Certificate/data/repo/certificate_repo.dart';
import 'package:doctor/Presentation/Certificate/logic/certificate_cubit.dart';
import 'package:doctor/Presentation/Records/data/api/records_api_service.dart';
import 'package:doctor/Presentation/Records/data/repo/records_repo.dart';
import 'package:doctor/Presentation/Records/logic/records_cubit.dart';
import 'package:doctor/Presentation/Instruction/data/api/instruction_api_service.dart';
import 'package:doctor/Presentation/Instruction/data/repo/instruction_repo.dart';
import 'package:doctor/Presentation/Instruction/logic/instruction_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
Future<void> setupGetIt() async {
  // Dio and Register Api Services
  Dio dio = DioFactory.getDio();
  DioFactory.addDioInterceptor();

  // Token Storage Service
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<TokenStorageService>(
    () => TokenStorageService(getIt()),
  );

  getIt.registerLazySingleton<RegisterApiService>(
    () => RegisterApiService(dio),
  );

  // Register Repository
  getIt.registerLazySingleton<RegisterRepo>(
    () => RegisterRepo(registerApiService: getIt()),
  );

  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(registerRepo: getIt()),
  );

  // --- Login Setup ---
  getIt.registerLazySingleton<LoginApiService>(() => LoginApiService(dio));

  getIt.registerLazySingleton<LoginRepo>(
    () => LoginRepo(loginApiService: getIt()),
  );

  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(loginRepo: getIt(), tokenStorageService: getIt()),
  );
  // --- Forgot Password Setup ---
  getIt.registerLazySingleton<ForgotPasswordApiService>(
    () => ForgotPasswordApiService(dio),
  );

  getIt.registerLazySingleton<ForgotPasswordRepo>(
    () => ForgotPasswordRepo(apiService: getIt()),
  );

  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(repo: getIt()),
  );

  // --- Patient Setup ---
  getIt.registerLazySingleton<PatientApiService>(() => PatientApiService(dio));
  getIt.registerLazySingleton<PatientRepo>(
    () => PatientRepo(patientApiService: getIt()),
  );
  getIt.registerFactory<AddPatientBloc>(
    () => AddPatientBloc(patientRepo: getIt()),
  );
  getIt.registerFactory<PatientListCubit>(
    () => PatientListCubit(patientRepo: getIt()),
  );

  // --- Invoice Setup ---
  getIt.registerLazySingleton<InvoiceApiService>(() => InvoiceApiService(dio));
  getIt.registerLazySingleton<InvoiceRepo>(
    () => InvoiceRepo(invoiceApiService: getIt()),
  );
  getIt.registerFactory<InvoiceCubit>(
    () => InvoiceCubit(invoiceRepo: getIt(), patientRepo: getIt()),
  );

  // --- Appointment Setup ---
  getIt.registerLazySingleton<AppointmentApiService>(
    () => AppointmentApiService(dio),
  );
  getIt.registerLazySingleton<AppointmentRepo>(
    () => AppointmentRepo(appointmentApiService: getIt()),
  );
  getIt.registerFactory<AppointmentCubit>(
    () => AppointmentCubit(appointmentRepo: getIt()),
  );

  // --- Reminder Setup ---
  getIt.registerLazySingleton<ReminderApiService>(
    () => ReminderApiService(dio),
  );
  getIt.registerLazySingleton<ReminderRepo>(
    () => ReminderRepo(reminderApiService: getIt()),
  );
  getIt.registerFactory<ReminderCubit>(
    () => ReminderCubit(reminderRepo: getIt()),
  );

  // --- Certificate Setup ---
  getIt.registerLazySingleton<CertificateApiService>(
    () => CertificateApiService(dio),
  );
  getIt.registerLazySingleton<CertificateRepo>(
    () => CertificateRepo(certificateApiService: getIt()),
  );
  getIt.registerFactory<CertificateCubit>(
    () => CertificateCubit(certificateRepo: getIt()),
  );

  // --- Records Setup ---
  getIt.registerLazySingleton<RecordsApiService>(() => RecordsApiService(dio));
  getIt.registerLazySingleton<RecordsRepo>(
    () => RecordsRepo(recordsApiService: getIt()),
  );
  getIt.registerFactory<RecordsCubit>(() => RecordsCubit(recordsRepo: getIt()));

  // --- Instruction Setup ---
  getIt.registerLazySingleton<InstructionApiService>(
    () => InstructionApiService(dio),
  );
  getIt.registerLazySingleton<InstructionRepo>(
    () => InstructionRepo(instructionApiService: getIt()),
  );
  getIt.registerFactory<InstructionCubit>(
    () => InstructionCubit(instructionRepo: getIt()),
  );

  /// --- Prescription Setup ---

  getIt.registerLazySingleton<PrescriptionApiService>(
    () => PrescriptionApiService(dio),
  );

  getIt.registerLazySingleton<PrescriptionRepo>(
    () => PrescriptionRepo(prescriptionApiService: getIt()),
  );

  getIt.registerFactory<PrescriptionCubit>(
    () => PrescriptionCubit(prescriptionRepo: getIt()),
  );

  /// TEMPLATE

  getIt.registerLazySingleton<TemplateApiService>(
    () => TemplateApiService(dio),
  );

  getIt.registerLazySingleton<TemplateRepo>(
    () => TemplateRepo(templateApiService: getIt()),
  );

  getIt.registerFactory<TemplateCubit>(
    () => TemplateCubit(templateRepo: getIt()),
  );

  /// CONSENT

  // getIt.registerLazySingleton<ConsentApiService>(() => ConsentApiService(dio));

  // getIt.registerLazySingleton<ConsentRepository>(
  //   () => ConsentRepository(consentApiService: getIt()),
  // );

  // getIt.registerFactory<ConsentCubit>(
  //   () => ConsentCubit(consentRepository: getIt()),
  // );
}
