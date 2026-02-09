import 'package:injectable/injectable.dart';

import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_datasource.dart';

@LazySingleton(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this._local);

  final OnboardingLocalDatasource _local;

  @override
  bool isCompleted() => _local.isCompleted();

  @override
  Future<void> setCompleted() => _local.setCompleted();
}
