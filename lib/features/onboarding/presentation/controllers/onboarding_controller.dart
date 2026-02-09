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
      title: 'Relax & Focus',
      description: 'with AI Meditation',
      imagePath: 'assets/images/onb_image1.png',
    ),
    const OnboardingPageInfo(
      title: 'AI Creates',
      description: 'Sessions for Your Mind',
      imagePath: 'assets/images/onb_image2.png',
    ),
    const OnboardingPageInfo(
      title: 'Listen & Follow',
      description: 'AI Guidance.',
      imagePath: 'assets/images/onb_image3.png',
    ),
    const OnboardingPageInfo(
      title: 'Track Your',
      description: 'Mindfulness & Progress',
      imagePath: 'assets/images/onb_image4.png',
    ),
  ];

  void onPageChanged(int index) => pageIndex.value = index;

  Future<void> complete() async {
    isLoading.value = true;
    await _completeOnboarding();
    isLoading.value = false;
  }
}
