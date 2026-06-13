import 'package:doctor/Presentation/Appointment/data/models/appointment_list_response.dart';
import 'package:doctor/Presentation/Appointment/data/models/appointment_request_body.dart';
import 'package:doctor/Presentation/Appointment/logic/appointment_cubit.dart';
import 'package:doctor/Presentation/Appointment/logic/appointment_state.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class EditAppointmentScreen extends StatefulWidget {
  final AppointmentItem appointment;

  const EditAppointmentScreen({super.key, required this.appointment});

  @override
  State<EditAppointmentScreen> createState() => _EditAppointmentScreenState();
}

class _EditAppointmentScreenState extends State<EditAppointmentScreen> {
  late TextEditingController purposeController;

  @override
  void initState() {
    super.initState();
    print("Edit Screen Opened");
    print("Appointment ID => ${widget.appointment.id}");

    purposeController = TextEditingController(
      text: widget.appointment.purpose ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppointmentCubit, AppointmentState<dynamic>>(
      listener: (context, state) {
        state.whenOrNull(
          updateSuccess: (message) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message)));

            Navigator.pop(context, true);
          },
          error: (error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error)));
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Edit Appointment")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: purposeController,
                decoration: const InputDecoration(labelText: "Purpose"),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  String formattedDate = DateTime.parse(
                    widget.appointment.appointmentDate,
                  ).toIso8601String().split('T').first;

                  String formattedTime =
                      widget.appointment.appointmentTime.length >= 5
                      ? widget.appointment.appointmentTime.substring(0, 5)
                      : widget.appointment.appointmentTime;

                  print("DATE => $formattedDate");
                  print("TIME => $formattedTime");

                  final body = AppointmentRequestBody(
                    patientCode: widget.appointment.patientCode ?? "",
                    doctorCode: widget.appointment.doctorCode ?? "",
                    appointmentDate: formattedDate,
                    appointmentTime: formattedTime,
                    purpose: purposeController.text,
                    notes: "Updated from mobile",
                  );

                  context.read<AppointmentCubit>().updateAppointment(
                    widget.appointment.id,
                    body,
                  );
                },
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
