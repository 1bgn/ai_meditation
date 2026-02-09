import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

import '../../domain/entities/meditation_recommendation.dart';
import '../../domain/usecases/get_last_meditation.dart';
import '../../domain/usecases/get_recommendations.dart';

@injectable
class HomeController {
  HomeController(
    this._getRecommendations,
    this._getLastMeditation,
  );

  final GetRecommendations _getRecommendations;
  final GetLastMeditation _getLastMeditation;

  final recommendations = signal<List<MeditationRecommendation>>([]);
  final lastMeditationTitle = signal<String?>(null);

  void load() {
    recommendations.value = _getRecommendations();
    lastMeditationTitle.value = _getLastMeditation();
  }
}
