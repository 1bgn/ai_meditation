import 'package:injectable/injectable.dart';

import '../../../../core/storage/app_preferences.dart';
import '../../domain/entities/meditation_recommendation.dart';

@lazySingleton
class HomeLocalDatasource {
  HomeLocalDatasource(this._preferences);

  final AppPreferences _preferences;

  List<MeditationRecommendation> getRecommendations() => const [
        MeditationRecommendation(
          title: 'Morning Clarity',
          subtitle: 'Start your day grounded',
          durationMinutes: 7,
        ),
        MeditationRecommendation(
          title: 'Deep Focus',
          subtitle: 'Reset attention',
          durationMinutes: 10,
        ),
        MeditationRecommendation(
          title: 'Sleep Wind-Down',
          subtitle: 'Ease into rest',
          durationMinutes: 12,
        ),
      ];

  String? getLastMeditationTitle() => _preferences.getLastMeditationTitle();
}
