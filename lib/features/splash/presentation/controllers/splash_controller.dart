import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

import '../../../onboarding/domain/usecases/check_onboarding_completed.dart';

@injectable
class SplashController {
  SplashController(this._checkOnboardingCompleted);

  final CheckOnboardingCompleted _checkOnboardingCompleted;

  final isLoading = signal(true);
  final error = signal<String?>(null);

  String resolveNextRoute() {
    try {
      final completed = _checkOnboardingCompleted() && false;
      return completed ? '/home' : '/onboarding';
    } catch (e) {
      error.value = e.toString();
      return '/onboarding';
    } finally {
      isLoading.value = false;
    }
  }
}
