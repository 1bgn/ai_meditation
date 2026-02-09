import 'package:injectable/injectable.dart';

import '../repositories/onboarding_repository.dart';

@injectable
class CheckOnboardingCompleted {
  const CheckOnboardingCompleted(this._repository);

  final OnboardingRepository _repository;

  bool call() => _repository.isCompleted();
}
