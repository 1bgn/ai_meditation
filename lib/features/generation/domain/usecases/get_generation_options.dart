import 'package:injectable/injectable.dart';

import '../entities/generation_options.dart';
import '../repositories/generation_repository.dart';

@injectable
class GetGenerationOptions {
  const GetGenerationOptions(this._repository);

  final GenerationRepository _repository;

  GenerationOptions? call() => _repository.getOptions();
}
