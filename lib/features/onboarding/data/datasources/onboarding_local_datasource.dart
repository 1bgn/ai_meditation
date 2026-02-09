import 'package:injectable/injectable.dart';

import '../../../../core/storage/app_preferences.dart';

@lazySingleton
class OnboardingLocalDatasource {
  OnboardingLocalDatasource(this._preferences);

  final AppPreferences _preferences;

  bool isCompleted() => _preferences.getOnboardingCompleted();

  Future<void> setCompleted() => _preferences.setOnboardingCompleted(true);
}
