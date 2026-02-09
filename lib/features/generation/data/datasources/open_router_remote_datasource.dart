import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/open_router_request.dart';
import '../models/open_router_response.dart';

part 'open_router_remote_datasource.g.dart';

@RestApi()
abstract class OpenRouterRemoteDatasource {
  factory OpenRouterRemoteDatasource(
    Dio dio, {
    String baseUrl,
  }) = _OpenRouterRemoteDatasource;

  @POST('/chat/completions')
  Future<OpenRouterResponse> createChatCompletion(
    @Body() OpenRouterRequest body,
  );
}
