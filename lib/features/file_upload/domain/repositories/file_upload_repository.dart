import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_sparring/core/errors/failures.dart';
import '../entities/file_upload_entity.dart';

abstract class FileUploadRepository {
  Future<Either<Failure, FileUploadEntity>> uploadFile(File file);
  Future<Either<Failure, FileUploadEntity>> uploadImage(File file);
}
