import '../entities/meditation_recommendation.dart';

abstract class HomeRepository {
  List<MeditationRecommendation> getRecommendations();
  String? getLastMeditationTitle();
}
