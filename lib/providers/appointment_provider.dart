import 'package:flutter/foundation.dart';
import 'package:football_fraternity/models/appointment.dart';

class AppointmentProvider with ChangeNotifier {
  final List<Appointment> _appointments = [];

  List<Appointment> get appointments => [..._appointments];

  void addAppointment(Appointment appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }

  void updateAppointment(String id, Appointment newAppointment) {
    final index = _appointments.indexWhere((appt) => appt.id == id);
    if (index >= 0) {
      _appointments[index] = newAppointment;
      notifyListeners();
    }
  }

  void cancelAppointment(String id) {
    _appointments.removeWhere((appt) => appt.id == id);
    notifyListeners();
  }

  List<Appointment> getClientAppointments(String clientId) {
    return _appointments.where((appt) => appt.clientId == clientId).toList();
  }

  List<Appointment> getLegalOfficerAppointments(String legalOfficerId) {
    return _appointments
        .where((appt) => appt.legalOfficerId == legalOfficerId)
        .toList();
  }
}