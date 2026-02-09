import '../entities/generation_options.dart';

abstract class GenerationRepository {
  GenerationOptions? getOptions();
  Future<void> saveOptions(GenerationOptions options);
  Future<void> generate(GenerationOptions options);
}
