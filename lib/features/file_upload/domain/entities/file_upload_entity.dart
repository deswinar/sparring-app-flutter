import 'package:equatable/equatable.dart';

class FileUploadEntity extends Equatable {
  final String url;

  const FileUploadEntity({required this.url});

  @override
  List<Object?> get props => [url];
}
