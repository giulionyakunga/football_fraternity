
import 'package:football_fraternity/screens/about_us.dart';
import 'package:football_fraternity/screens/appointments/appointment_detail.dart';
import 'package:football_fraternity/screens/appointments/appointment_form.dart';
import 'package:football_fraternity/screens/appointments/appointments_list.dart';
import 'package:football_fraternity/screens/auth/login.dart';
import 'package:football_fraternity/screens/auth/register.dart';
import 'package:football_fraternity/screens/cases/case_detail.dart';
import 'package:football_fraternity/screens/cases/cases_list.dart';
import 'package:football_fraternity/screens/contacts.dart';
import 'package:football_fraternity/screens/contracts/contract_detail.dart';
import 'package:football_fraternity/screens/contracts/contracts_list.dart';
import 'package:football_fraternity/screens/documents/document_detail.dart';
import 'package:football_fraternity/screens/documents/document_upload.dart';
import 'package:football_fraternity/screens/documents/documents_list.dart';
import 'package:football_fraternity/screens/footballers/footballer_details.dart';
import 'package:football_fraternity/screens/footballers/footballer_form.dart';
import 'package:football_fraternity/screens/footballers/footballers_list.dart';
import 'package:football_fraternity/screens/legal_services/consultancy_form.dart';
import 'package:football_fraternity/screens/legal_services/representation_form.dart';
import 'package:football_fraternity/screens/legal_services/footballer_management_form.dart';
import 'package:football_fraternity/screens/legal_services/services_list.dart';
import 'package:football_fraternity/screens/main_screen.dart';
import 'package:football_fraternity/screens/messages/messages_list.dart';
import 'package:football_fraternity/screens/profile.dart';
import 'package:football_fraternity/screens/services.dart';

class Routes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String aboutUs = '/about-us';
  static const String services = '/services';
  static const String contacts = '/contacts';
  static const String messages = '/messages';
  static const String profile = '/profile';
  static const String footballers = '/footballers';
  static const String footballerForm = '/footballers/form';
  static const String contracts = '/contracts';
  static const String contractDetail = '/contracts/detail';
  static const String cases = '/cases';
  static const String caseDetail = '/cases/detail';
  static const String appointments = '/appointments';
  static const String appointmentDetail = '/appointments/detail';
  static const String appointmentForm = '/appointments/form';
  static const String documents = '/documents';
  static const String documentDetail = '/documents/detail';
  static const String documentUpload = '/documents/upload';
  static const String legalServices = '/legal-services';
  static const String consultancyForm = '/legal-services/consultancy';
  static const String representationForm = '/legal-services/representation';
  static const String footballerManagementForm = '/legal-services/footballer_management_form';

  static final all = {
    home: (context) => const MainScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    aboutUs: (context) => const AboutUsScreen(),
    services: (context) => const ServicesScreen(),
    contacts: (context) => const ContactsScreen(),
    messages: (context) => MessagesListScreen(),
    profile: (context) => const ProfileScreen(),
    footballers: (context) => const FootballersListScreen(),
    footballerForm: (context) => const FootballerFormScreen(),
    contracts: (context) => ContractsListScreen(),
    contractDetail: (context) => ContractDetailScreen(),
    cases: (context) => CasesListScreen(),
    // caseDetail: (context) => const CaseDetailScreen(),
    appointments: (context) => AppointmentsListScreen(),
    // appointmentDetail: (context) => const AppointmentDetailScreen(),
    appointmentForm: (context) => const AppointmentFormScreen(),
    documents: (context) => const DocumentsListScreen(),
    // documentDetail: (context) => const DocumentDetailScreen(),
    documentUpload: (context) => const DocumentUploadScreen(),
    legalServices: (context) => const LegalServicesListScreen(),
    consultancyForm: (context) => const ConsultancyFormScreen(),
    representationForm: (context) => const RepresentationFormScreen(),
    footballerManagementForm: (context) => const FootballerManagementFormScreen(),
  };
}
