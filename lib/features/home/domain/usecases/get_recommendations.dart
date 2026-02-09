import 'package:injectable/injectable.dart';

import '../entities/meditation_recommendation.dart';
import '../repositories/home_repository.dart';

@injectable
class GetRecommendations {
  const GetRecommendations(this._repository);

  final HomeRepository _repository;

  List<MeditationRecommendation> call() => _repository.getRecommendations();
}
