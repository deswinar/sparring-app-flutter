import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_sparring/core/errors/failures.dart';
import 'package:flutter_sparring/core/errors/failure_mapper.dart';
import 'package:flutter_sparring/core/network/api_error_handler.dart';

import '../../domain/entities/file_upload_entity.dart';
import '../../domain/repositories/file_upload_repository.dart';
import '../datasources/file_upload_remote_datasource.dart';

@LazySingleton(as: FileUploadRepository)
class FileUploadRepositoryImpl implements FileUploadRepository {
  final FileUploadRemoteDataSource _remote;

  const FileUploadRepositoryImpl(this._remote);

  @override
  Future<Either<Failure, FileUploadEntity>> uploadFile(File file) async {
    try {
      final response = await _remote.uploadFile(file);
      return Right(FileUploadEntity(url: response.result));
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }

  @override
  Future<Either<Failure, FileUploadEntity>> uploadImage(File file) async {
    try {
      final response = await _remote.uploadImage(file);
      return Right(FileUploadEntity(url: response.result));
    } catch (e) {
      final exception = ApiErrorHandler.handle(e);
      return Left(FailureMapper.fromException(exception));
    }
  }
}
