import 'package:flutter/material.dart';
import 'package:football_fraternity/models/appointment.dart';
import 'package:football_fraternity/utils/app_colors.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Icon(Icons.calendar_today, color: Colors.white),
        ),
        title: Text(appointment.title),
        subtitle: Text(
            '${appointment.date.day}/${appointment.date.month}/${appointment.date.year} at ${appointment.time}'),
        trailing: Chip(
          label: Text(
            appointment.status,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: _getStatusColor(appointment.status),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/appointments/detail',
            arguments: appointment,
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}