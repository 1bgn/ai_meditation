import 'package:injectable/injectable.dart';
import 'package:signals/signals.dart';

import '../../domain/entities/onboarding_page_info.dart';
import '../../domain/usecases/complete_onboarding.dart';

@injectable
class OnboardingController {
  OnboardingController(this._completeOnboarding);

  final CompleteOnboarding _completeOnboarding;

  final pageIndex = signal(0);
  final isLoading = signal(false);

  final pages = [
    const OnboardingPageInfo(
      title: 'Calm Your Mind',
      description: 'Short sessions for instant clarity and relaxation.',
      iconName: 'self_improvement',
    ),
    const OnboardingPageInfo(
      title: 'Personalized Goals',
      description: 'Pick a goal and we generate a meditation for you.',
      iconName: 'tune',
    ),
    const OnboardingPageInfo(
      title: 'Daily Routine',
      description: 'Build a gentle habit with daily routines.',
      iconName: 'calendar_today',
    ),
    const OnboardingPageInfo(
      title: 'Breathe Better',
      description: 'Guided breathing for focus and stress relief.',
      iconName: 'air',
    ),
  ];

  void onPageChanged(int index) => pageIndex.value = index;

  Future<void> complete() async {
    isLoading.value = true;
    await _completeOnboarding();
    isLoading.value = false;
  }
}
