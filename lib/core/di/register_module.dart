import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart';

import '../network/api_keys.dart';
import '../network/dio_client.dart';
import '../../features/generation/data/datasources/'
    'eleven_labs_remote_datasource.dart';
import '../../features/generation/data/datasources/'
    'open_router_remote_datasource.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  @Named('openRouterDio')
  Dio get openRouterDio => DioClient.create(
        baseUrl: 'https://openrouter.ai/api/v1',
        headers: {
          'authorization': 'Bearer ${ApiKeys.openRouter}',
          'content-type': 'application/json',
        },
      );

  @lazySingleton
  @Named('elevenLabsDio')
  Dio get elevenLabsDio => DioClient.create(
        baseUrl: 'https://api.elevenlabs.io/v1',
        headers: {
          'xi-api-key': ApiKeys.elevenLabs,
          'content-type': 'application/json',
          'accept': 'audio/mpeg',
        },
      );

  @lazySingleton
  OpenRouterRemoteDatasource get openRouterRemoteDatasource =>
      OpenRouterRemoteDatasource(openRouterDio);

  @lazySingleton
  ElevenLabsRemoteDatasource get elevenLabsRemoteDatasource =>
      ElevenLabsRemoteDatasource(elevenLabsDio);

}
