// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/breathing/presentation/controllers/breathing_controller.dart'
    as _i692;
import '../../features/breathing/presentation/controllers/breathing_session_controller.dart'
    as _i947;
import '../../features/daily_routine/presentation/controllers/daily_routine_controller.dart'
    as _i951;
import '../../features/generation/data/datasources/eleven_labs_remote_datasource.dart'
    as _i758;
import '../../features/generation/data/datasources/generation_local_datasource.dart'
    as _i239;
import '../../features/generation/data/datasources/open_router_remote_datasource.dart'
    as _i752;
import '../../features/generation/data/repositories/generation_repository_impl.dart'
    as _i865;
import '../../features/generation/domain/repositories/generation_repository.dart'
    as _i327;
import '../../features/generation/domain/usecases/generate_meditation.dart'
    as _i899;
import '../../features/generation/domain/usecases/get_generation_options.dart'
    as _i15;
import '../../features/generation/domain/usecases/save_generation_options.dart'
    as _i934;
import '../../features/generation/presentation/controllers/generation_controller.dart'
    as _i145;
import '../../features/generation/presentation/controllers/meditation_player_controller.dart'
    as _i1060;
import '../../features/history/data/datasources/breathing_history_datasource.dart'
    as _i853;
import '../../features/history/data/datasources/history_local_datasource.dart'
    as _i665;
import '../../features/history/data/repositories/breathing_history_impl.dart'
    as _i706;
import '../../features/history/data/repositories/history_repository_impl.dart'
    as _i751;
import '../../features/history/domain/repositories/breathing_history_repository.dart'
    as _i61;
import '../../features/history/domain/repositories/history_repository.dart'
    as _i142;
import '../../features/history/domain/usecases/add_breathing_history_item.dart'
    as _i165;
import '../../features/history/domain/usecases/add_history_item.dart' as _i305;
import '../../features/history/domain/usecases/delete_history_item.dart'
    as _i391;
import '../../features/history/domain/usecases/get_breathing_history.dart'
    as _i307;
import '../../features/history/domain/usecases/get_history.dart' as _i886;
import '../../features/history/presentation/controllers/breathing_history_controller.dart'
    as _i508;
import '../../features/history/presentation/controllers/history_controller.dart'
    as _i712;
import '../../features/home/data/datasources/home_local_datasource.dart'
    as _i314;
import '../../features/home/data/repositories/home_repository_impl.dart'
    as _i76;
import '../../features/home/domain/repositories/home_repository.dart' as _i0;
import '../../features/home/domain/usecases/get_last_meditation.dart' as _i108;
import '../../features/home/domain/usecases/get_recommendations.dart' as _i655;
import '../../features/home/presentation/controllers/home_controller.dart'
    as _i414;
import '../../features/onboarding/data/datasources/onboarding_local_datasource.dart'
    as _i804;
import '../../features/onboarding/data/repositories/onboarding_repository_impl.dart'
    as _i452;
import '../../features/onboarding/domain/repositories/onboarding_repository.dart'
    as _i430;
import '../../features/onboarding/domain/usecases/check_onboarding_completed.dart'
    as _i525;
import '../../features/onboarding/domain/usecases/complete_onboarding.dart'
    as _i561;
import '../../features/onboarding/presentation/controllers/onboarding_controller.dart'
    as _i765;
import '../../features/paywall/data/apphud_monetization_service.dart' as _i103;
import '../../features/paywall/domain/monetization_service.dart' as _i971;
import '../../features/paywall/presentation/controllers/paywall_controller.dart'
    as _i173;
import '../../features/splash/presentation/controllers/splash_controller.dart'
    as _i758;
import '../storage/app_preferences.dart' as _i632;
import '../tts/tts_service.dart' as _i369;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.factory<_i947.BreathingSessionController>(
      () => _i947.BreathingSessionController(),
    );
    gh.lazySingleton<_i752.OpenRouterRemoteDatasource>(
      () => registerModule.openRouterRemoteDatasource,
    );
    gh.lazySingleton<_i758.ElevenLabsRemoteDatasource>(
      () => registerModule.elevenLabsRemoteDatasource,
    );
    gh.lazySingleton<_i692.BreathingController>(
      () => _i692.BreathingController(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.openRouterDio,
      instanceName: 'openRouterDio',
    );
    gh.lazySingleton<_i971.MonetizationService>(
      () => _i103.ApphudMonetizationService(),
    );
    gh.lazySingleton<_i361.Dio>(
      () => registerModule.elevenLabsDio,
      instanceName: 'elevenLabsDio',
    );
    gh.factory<_i173.PaywallController>(
      () => _i173.PaywallController(gh<_i971.MonetizationService>()),
    );
    gh.lazySingleton<_i632.AppPreferences>(
      () => _i632.AppPreferences(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i239.GenerationLocalDatasource>(
      () => _i239.GenerationLocalDatasource(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i369.TtsService>(
      () => _i369.TtsService(gh<_i758.ElevenLabsRemoteDatasource>()),
    );
    gh.lazySingleton<_i327.GenerationRepository>(
      () => _i865.GenerationRepositoryImpl(
        gh<_i239.GenerationLocalDatasource>(),
        gh<_i752.OpenRouterRemoteDatasource>(),
      ),
    );
    gh.factory<_i899.GenerateMeditation>(
      () => _i899.GenerateMeditation(gh<_i327.GenerationRepository>()),
    );
    gh.factory<_i15.GetGenerationOptions>(
      () => _i15.GetGenerationOptions(gh<_i327.GenerationRepository>()),
    );
    gh.factory<_i934.SaveGenerationOptions>(
      () => _i934.SaveGenerationOptions(gh<_i327.GenerationRepository>()),
    );
    gh.lazySingleton<_i1060.MeditationPlayerController>(
      () => _i1060.MeditationPlayerController(gh<_i369.TtsService>()),
    );
    gh.factory<_i314.HomeLocalDatasource>(
      () => _i314.HomeLocalDatasource(gh<_i632.AppPreferences>()),
    );
    gh.lazySingleton<_i853.BreathingHistoryLocalDatasource>(
      () => _i853.BreathingHistoryLocalDatasource(gh<_i632.AppPreferences>()),
    );
    gh.lazySingleton<_i665.HistoryLocalDatasource>(
      () => _i665.HistoryLocalDatasource(gh<_i632.AppPreferences>()),
    );
    gh.lazySingleton<_i804.OnboardingLocalDatasource>(
      () => _i804.OnboardingLocalDatasource(gh<_i632.AppPreferences>()),
    );
    gh.lazySingleton<_i430.OnboardingRepository>(
      () =>
          _i452.OnboardingRepositoryImpl(gh<_i804.OnboardingLocalDatasource>()),
    );
    gh.factory<_i525.CheckOnboardingCompleted>(
      () => _i525.CheckOnboardingCompleted(gh<_i430.OnboardingRepository>()),
    );
    gh.factory<_i561.CompleteOnboarding>(
      () => _i561.CompleteOnboarding(gh<_i430.OnboardingRepository>()),
    );
    gh.factory<_i758.SplashController>(
      () => _i758.SplashController(gh<_i525.CheckOnboardingCompleted>()),
    );
    gh.factory<_i765.OnboardingController>(
      () => _i765.OnboardingController(gh<_i561.CompleteOnboarding>()),
    );
    gh.factory<_i0.HomeRepository>(
      () => _i76.HomeRepositoryImpl(gh<_i314.HomeLocalDatasource>()),
    );
    gh.lazySingleton<_i61.BreathingHistoryRepository>(
      () => _i706.BreathingHistoryRepositoryImpl(
        gh<_i853.BreathingHistoryLocalDatasource>(),
      ),
    );
    gh.lazySingleton<_i142.HistoryRepository>(
      () => _i751.HistoryRepositoryImpl(gh<_i665.HistoryLocalDatasource>()),
    );
    gh.factory<_i108.GetLastMeditation>(
      () => _i108.GetLastMeditation(gh<_i0.HomeRepository>()),
    );
    gh.factory<_i655.GetRecommendations>(
      () => _i655.GetRecommendations(gh<_i0.HomeRepository>()),
    );
    gh.factory<_i165.AddBreathingHistoryItem>(
      () =>
          _i165.AddBreathingHistoryItem(gh<_i61.BreathingHistoryRepository>()),
    );
    gh.factory<_i307.GetBreathingHistory>(
      () => _i307.GetBreathingHistory(gh<_i61.BreathingHistoryRepository>()),
    );
    gh.factory<_i508.BreathingHistoryController>(
      () => _i508.BreathingHistoryController(
        gh<_i307.GetBreathingHistory>(),
        gh<_i165.AddBreathingHistoryItem>(),
      ),
    );
    gh.factory<_i305.AddHistoryItem>(
      () => _i305.AddHistoryItem(gh<_i142.HistoryRepository>()),
    );
    gh.factory<_i886.GetHistory>(
      () => _i886.GetHistory(gh<_i142.HistoryRepository>()),
    );
    gh.factory<_i391.DeleteHistoryItem>(
      () => _i391.DeleteHistoryItem(gh<_i142.HistoryRepository>()),
    );
    gh.factory<_i414.HomeController>(
      () => _i414.HomeController(
        gh<_i655.GetRecommendations>(),
        gh<_i108.GetLastMeditation>(),
      ),
    );
    gh.factory<_i951.DailyRoutineController>(
      () => _i951.DailyRoutineController(
        gh<_i305.AddHistoryItem>(),
        gh<_i632.AppPreferences>(),
      ),
    );
    gh.lazySingleton<_i145.GenerationController>(
      () => _i145.GenerationController(
        gh<_i15.GetGenerationOptions>(),
        gh<_i934.SaveGenerationOptions>(),
        gh<_i899.GenerateMeditation>(),
        gh<_i305.AddHistoryItem>(),
      ),
    );
    gh.lazySingleton<_i712.HistoryController>(
      () => _i712.HistoryController(
        gh<_i886.GetHistory>(),
        gh<_i391.DeleteHistoryItem>(),
        gh<_i305.AddHistoryItem>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
