import 'package:doctor/Presentation/Appointment/data/models/appointment_list_response.dart';
import 'package:doctor/Presentation/Appointment/edit_appointment_screen.dart';
import 'package:doctor/Presentation/Appointment/logic/appointment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final AppointmentItem appointment;

  const AppointmentDetailsScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Appointment Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.patientName ?? "Unknown Patient",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text("Date: ${appointment.appointmentDate}"),

                Text("Time: ${appointment.appointmentTime}"),

                Text("Doctor: ${appointment.doctorName}"),

                Text("Purpose: ${appointment.purpose ?? ''}"),

                Text("Status: ${appointment.status}"),

                const SizedBox(height: 30),

                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<AppointmentCubit>(),
                          child: EditAppointmentScreen(
                            appointment: appointment,
                          ),
                        ),
                      ),
                    );

                    if (result == true) {
                      Navigator.pop(context, true);
                    }
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Appointment"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
