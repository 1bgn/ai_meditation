import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/dio_client.dart';
import '../../features/generation/data/datasources/'
    'generation_remote_datasource.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => DioClient.create();

  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  GenerationRemoteDatasource get generationRemoteDatasource =>
      GenerationRemoteDatasource(dio);
}
