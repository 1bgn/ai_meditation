import 'package:injectable/injectable.dart';

import '../../domain/entities/generation_options.dart';
import '../../domain/repositories/generation_repository.dart';
import '../datasources/generation_local_datasource.dart';
import '../datasources/generation_remote_datasource.dart';

@LazySingleton(as: GenerationRepository)
class GenerationRepositoryImpl implements GenerationRepository {
  GenerationRepositoryImpl(this._local, this._remote);

  final GenerationLocalDatasource _local;
  final GenerationRemoteDatasource _remote;

  @override
  GenerationOptions? getOptions() => _local.getOptions();

  @override
  Future<void> saveOptions(GenerationOptions options) =>
      _local.saveOptions(options);

  @override
  Future<void> generate(GenerationOptions options) =>
      _remote.generateMeditation(options.toJson());
}
