import 'package:injectable/injectable.dart';

import '../entities/generation_options.dart';
import '../repositories/generation_repository.dart';

@injectable
class GenerateMeditation {
  const GenerateMeditation(this._repository);

  final GenerationRepository _repository;

  Future<void> call(GenerationOptions options) =>
      _repository.generate(options);
}
