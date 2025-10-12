import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/file_upload_entity.dart';
import '../repositories/file_upload_repository.dart';

class UploadImageParams {
  final File file;

  const UploadImageParams({required this.file});
}

@injectable
class UploadImageUseCase {
  final FileUploadRepository repository;

  const UploadImageUseCase(this.repository);

  Future<Either<Failure, FileUploadEntity>> call(UploadImageParams params) async {
    // Validation
    if (!params.file.existsSync()) {
      return Left(ValidationFailure(
        message: 'Image file does not exist',
        code: 'INVALID_IMAGE',
      ));
    }

    final fileExtension = params.file.path.split('.').last.toLowerCase();
    final validExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];

    if (!validExtensions.contains(fileExtension)) {
      return Left(ValidationFailure(
        message: 'Unsupported image format',
        code: 'INVALID_IMAGE_FORMAT',
      ));
    }

    return await repository.uploadImage(params.file);
  }
}
