class AppConstants {
  static const String appName = 'Football Fraternity';
  static const String companyName = 'Football Fraternity Co, Ltd.';
  static const String companyAddress = '123 Football Avenue, Nairobi, Kenya';
  static const String companyPhone = '+254 700 123 456';
  static const String companyEmail = 'info@footballfraternity.co.ke';
  static const String companyWebsite = 'www.footballfraternity.co.ke';

  // API Endpoints
  static const String baseUrl = 'https://api.footballfraternity.co.ke/v1';
  static const String loginEndpoint = '$baseUrl/auth/login';
  static const String registerEndpoint = '$baseUrl/auth/register';
  static const String footballersEndpoint = '$baseUrl/footballers';
  static const String contractsEndpoint = '$baseUrl/contracts';
  static const String casesEndpoint = '$baseUrl/cases';
  static const String appointmentsEndpoint = '$baseUrl/appointments';
  static const String documentsEndpoint = '$baseUrl/documents';
  static const String messagesEndpoint = '$baseUrl/messages';

  // SharedPreferences keys
  static const String authTokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userRoleKey = 'user_role';
  static const String rememberMeKey = 'remember_me';

  // Pagination
  static const int itemsPerPage = 10;
}