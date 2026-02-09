import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_page_info.freezed.dart';

@freezed
class OnboardingPageInfo with _$OnboardingPageInfo {
  const factory OnboardingPageInfo({
    required String title,
    required String description,
    required String iconName,
  }) = _OnboardingPageInfo;
}
