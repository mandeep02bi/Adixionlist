import 'package:doctor/Core/di/dependancy_injection.dart';
import 'package:doctor/Presentation/Appointment/appointment_details_screen.dart';
import 'package:doctor/Presentation/Appointment/edit_appointment_screen.dart';
import 'package:doctor/Presentation/Appointment/logic/appointment_cubit.dart';
import 'package:doctor/Presentation/Appointment/logic/appointment_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class AppointmentListScreen extends StatelessWidget {
  const AppointmentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AppointmentCubit>()..getAppointments(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Appointments")),
        body: BlocBuilder<AppointmentCubit, AppointmentState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              listSuccess: (appointments) {
                return ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (_, index) {
                    final item = appointments[index];

                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        onTap: () async {
                          final result = await Get.to(
                            () => BlocProvider.value(
                              value: context.read<AppointmentCubit>(),
                              child: AppointmentDetailsScreen(
                                appointment: item,
                              ),
                            ),
                          );

                          if (result == true) {
                            context.read<AppointmentCubit>().getAppointments();
                          }
                        },
                        title: Text(item.patientName ?? "Unknown Patient"),
                        subtitle: Text(
                          "${item.appointmentDate} ${item.appointmentTime}",
                        ),
                        trailing: Text(item.status),
                      ),
                    );
                  },
                );
              },
              error: (msg) {
                print("APPOINTMENT ERROR => $msg");

                return Center(
                  child: Text("ERROR:\n$msg", textAlign: TextAlign.center),
                );
              },
              orElse: () => const SizedBox(),
            );
          },
        ),
      ),
    );
  }
}
