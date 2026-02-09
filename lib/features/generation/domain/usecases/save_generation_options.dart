import 'package:injectable/injectable.dart';

import '../entities/generation_options.dart';
import '../repositories/generation_repository.dart';

@injectable
class SaveGenerationOptions {
  const SaveGenerationOptions(this._repository);

  final GenerationRepository _repository;

  Future<void> call(GenerationOptions options) =>
      _repository.saveOptions(options);
}
