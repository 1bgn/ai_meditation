import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/eleven_labs_request.dart';

part 'eleven_labs_remote_datasource.g.dart';

@RestApi()
abstract class ElevenLabsRemoteDatasource {
  factory ElevenLabsRemoteDatasource(
    Dio dio, {
    String baseUrl,
  }) = _ElevenLabsRemoteDatasource;

  @POST('/text-to-speech/{voiceId}')
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> generateSpeech(
    @Path('voiceId') String voiceId,
    @Body() ElevenLabsRequest body,
  );
}
