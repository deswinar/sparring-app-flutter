import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/models/base_response_model.dart';
import '../models/payment_method_model.dart';

part 'payment_method_remote_datasource.g.dart';

@lazySingleton
@RestApi()
abstract class PaymentMethodRemoteDataSource {
  @factoryMethod
  factory PaymentMethodRemoteDataSource(Dio dio) = _PaymentMethodRemoteDataSource;

  @GET(ApiConstants.paymentMethodsEndpoint)
  Future<BaseResponseModel<List<PaymentMethodModel>>> getAllPaymentMethods();
}