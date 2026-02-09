import 'package:injectable/injectable.dart';

import '../../domain/entities/meditation_recommendation.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._local);

  final HomeLocalDatasource _local;

  @override
  List<MeditationRecommendation> getRecommendations() =>
      _local.getRecommendations();

  @override
  String? getLastMeditationTitle() => _local.getLastMeditationTitle();
}
