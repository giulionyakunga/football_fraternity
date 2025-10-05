
import 'package:flutter/material.dart';
import 'package:football_fraternity/models/appointment.dart';
import 'package:football_fraternity/widgets/appointment_card.dart';
import 'package:football_fraternity/utils/app_colors.dart';

class AppointmentsListScreen extends StatelessWidget {
  AppointmentsListScreen({super.key});

  final List<Appointment> appointments = [
    Appointment(
      id: '1',
      title: 'Contract Review',
      description: 'Review new contract offer from KMC FC',
      date: DateTime(2023, 7, 15),
      time: '10:00 AM',
      status: 'Confirmed',
      legalOfficerId: '1',
      clientId: '1',
    ),
    Appointment(
      id: '2',
      title: 'Transfer Discussion',
      description: 'Discuss potential transfer to Yanga FC',
      date: DateTime(2023, 7, 20),
      time: '2:30 PM',
      status: 'Pending',
      legalOfficerId: '1',
      clientId: '1',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Appointments'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return AppointmentCard(appointment: appointments[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/appointments/form');
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}