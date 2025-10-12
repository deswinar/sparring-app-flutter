import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/file_upload_entity.dart';
import '../repositories/file_upload_repository.dart';

class UploadFileParams {
  final File file;

  const UploadFileParams({required this.file});
}

@injectable
class UploadFileUseCase {
  final FileUploadRepository repository;

  const UploadFileUseCase(this.repository);

  Future<Either<Failure, FileUploadEntity>> call(UploadFileParams params) async {
    // Validation
    if (!params.file.existsSync()) {
      return Left(ValidationFailure(
        message: 'File does not exist',
        code: 'INVALID_FILE',
      ));
    }

    return await repository.uploadFile(params.file);
  }
}
