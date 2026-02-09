import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'generation_remote_datasource.g.dart';

@RestApi()
abstract class GenerationRemoteDatasource {
  factory GenerationRemoteDatasource(
    Dio dio, {
    String baseUrl,
  }) = _GenerationRemoteDatasource;

  @POST('/meditations/generate')
  Future<void> generateMeditation(
    @Body() Map<String, dynamic> body,
  );
}
