import 'package:freezed_annotation/freezed_annotation.dart';

part 'breathing_options.freezed.dart';

@freezed
abstract class BreathingOptions with _$BreathingOptions {
  const factory BreathingOptions({
    required String? mood,
    required int? durationMinutes,
  }) = _BreathingOptions;
}
