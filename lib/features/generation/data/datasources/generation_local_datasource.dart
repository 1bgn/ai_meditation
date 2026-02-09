import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/generation_options.dart';

@lazySingleton
class GenerationLocalDatasource {
  GenerationLocalDatasource(this._prefs);

  final SharedPreferences _prefs;

  static const _keyOptions = 'generation_options';

  GenerationOptions? getOptions() {
    final raw = _prefs.getString(_keyOptions);
    if (raw == null || raw.isEmpty) {
      return null;
    }
    final json = jsonDecode(raw);
    if (json is Map<String, dynamic>) {
      return GenerationOptions.fromJson(json);
    }
    return null;
  }

  Future<void> saveOptions(GenerationOptions options) =>
      _prefs.setString(_keyOptions, jsonEncode(options.toJson()));
}
