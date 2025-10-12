import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static final String baseUrl = dotenv.env['API_BASE_URL'] ??
      'https://fallback-api.example.com/api/v1';
  
  /// Endpoints
  // Auth
  static const String loginEndpoint = '/login';
  static const String registerEndpoint = '/register';
  static const String logoutEndpoint = '/logout';
  static const String refreshTokenEndpoint = '/refresh';
  static const String userProfileEndpoint = '/me';

  // File
  static const String uploadImageEndpoint = '/upload-image';
  static const String uploadFileEndpoint = '/upload-file';

  // Location
  static const String provincesEndpoint = '/location/provinces';
  static const String citiesEndpoint = '/location/cities';
  static const String citiesByProvinceIdEndpoint = '/location/cities/{provinceId}';

  // Sport Category
  static const String sportCategoriesEndpoint = '/sport-categories';
  static const String createSportCategoryEndpoint = '/sport-categories/create';
  static const String updateSportCategoryEndpoint = '/sport-categories/update/{id}';
  static const String deleteSportCategoryEndpoint = '/sport-categories/delete/{id}';

  // Sport Activity
  static const String sportActivitiesEndpoint = '/sport-activities';
  static const String sportActivityByIdEndpoint = '/sport-activities/{id}';
  static const String createSportActivityEndpoint = '/sport-activities/create';
  static const String updateSportActivityEndpoint = '/sport-activities/update/{id}';
  static const String deleteSportActivityEndpoint = '/sport-activities/delete/{id}';

  // Transaction
  static const String allTransactionsEndpoint = '/all-transaction';
  static const String transactionByIdEndpoint = '/transaction/{id}';
  static const String myTransactionsEndpoint = '/my-transaction';
  static const String createTransactionEndpoint = '/transaction/create';
  static const String updateTransactionProofPaymentEndpoint = '/transaction/update-proof-payment/{id}';
  static const String updateTransactionStatusEndpoint = '/transaction/update-status/{id}';
  static const String cancelTransactionEndpoint = '/transaction/cancel/{id}';

  // Payment Method
  static const String paymentMethodsEndpoint = '/payment-methods';

  // --------------------------------------------------------------------------

  // Headers
  static const String contentType = 'Content-Type';
  static const String authorization = 'Authorization';
  static const String applicationJson = 'application/json';
  static const String bearerToken = 'Bearer';

  // Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}