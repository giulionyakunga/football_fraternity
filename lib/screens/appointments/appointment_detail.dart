import 'package:flutter/material.dart';
import 'package:football_fraternity/models/appointment.dart';
import 'package:football_fraternity/utils/app_colors.dart';
import 'package:football_fraternity/utils/app_styles.dart';

class AppointmentDetailScreen extends StatelessWidget {
  final Appointment appointment;

  const AppointmentDetailScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appointment.title,
              style: AppStyles.heading1,
            ),
            const SizedBox(height: 10),
            Chip(
              label: Text(
                appointment.status,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: _getStatusColor(appointment.status),
            ),
            const SizedBox(height: 30),
            _buildDetailRow('Date', '${appointment.date.day}/${appointment.date.month}/${appointment.date.year}'),
            _buildDetailRow('Time', appointment.time),
            _buildDetailRow('With', 'Legal Officer ${appointment.legalOfficerId}'),
            const SizedBox(height: 30),
            Text(
              'Description',
              style: AppStyles.heading2,
            ),
            const SizedBox(height: 10),
            Text(appointment.description),
            const SizedBox(height: 30),
            if (appointment.status == 'Pending')
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Implement cancel appointment
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text('Cancel Appointment'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(value),
        ],
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