import 'package:dio/dio.dart';
import 'package:flutter_sparring/core/models/message_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/models/base_response_model.dart';
import '../../../../core/models/paginated_response_model.dart';
import '../models/transaction_model.dart';
import '../models/transaction_request_model.dart';
import '../models/update_proof_payment_request_model.dart';
import '../models/update_status_request_model.dart';

part 'transaction_remote_datasource.g.dart';

@lazySingleton
@RestApi()
abstract class TransactionRemoteDataSource {
  @factoryMethod
  factory TransactionRemoteDataSource(Dio dio) = _TransactionRemoteDataSource;

  @GET(ApiConstants.allTransactionsEndpoint)
  Future<BaseResponseModel<PaginatedResponseModel<TransactionModel>>> getAllTransactions({
    @Query('is_paginate') bool isPaginate = false,
    @Query('per_page') int perPage = 5,
    @Query('page') int page = 1,
    @Query('search') String? search,
  });

  @GET(ApiConstants.myTransactionsEndpoint)
  Future<BaseResponseModel<PaginatedResponseModel<TransactionModel>>> getMyTransactions({
    @Query('is_paginate') bool isPaginate = false,
    @Query('per_page') int perPage = 5,
    @Query('page') int page = 1,
    @Query('search') String? search,
  });

  @GET(ApiConstants.transactionByIdEndpoint)
  Future<BaseResponseModel<TransactionModel>> getTransactionById(
    @Path('id') int id,
  );

  @POST(ApiConstants.createTransactionEndpoint)
  Future<BaseResponseModel<TransactionModel>> createTransaction(
    @Body() TransactionRequestModel request,
  );

  @POST(ApiConstants.updateTransactionProofPaymentEndpoint)
  Future<MessageResponseModel> updateProofPayment(
    @Path('id') int id,
    @Body() UpdateProofPaymentRequestModel request,
  );

  @POST(ApiConstants.updateTransactionStatusEndpoint)
  Future<MessageResponseModel> updateStatus(
    @Path('id') int id,
    @Body() UpdateStatusRequestModel request,
  );

  @POST(ApiConstants.cancelTransactionEndpoint)
  Future<BaseResponseModel<TransactionModel>> cancelTransaction(
    @Path('id') int id,
    @Body() UpdateStatusRequestModel request,
  );
}
