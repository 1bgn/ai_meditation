# План интеграции AI сервисов в Flutter приложение

## Архитектура приложения

```
┌─────────────────────────────────────────────────────────────┐
│                    Flutter Mobile App                        │
├─────────────────────────────────────────────────────────────┤
│  UI Layer (Screens, Widgets)                                 │
│  ├── Meditation Screen                                      │
│  ├── Breathing Exercise Screen                              │
│  ├── Sleep/Focus Mode Screen                                │
│  └── Profile/Settings Screen                                │
├─────────────────────────────────────────────────────────────┤
│  Business Logic Layer (Services, Providers)                 │
│  ├── MeditationService                                      │
│  │   ├── generateMeditation() → OpenAI API                  │
│  │   └── cacheMeditation()                                  │
│  ├── AudioService                                           │
│  │   ├── generateVoice() → ElevenLabs API                   │
│  │   ├── generateMusic() → Mubert API                       │
│  │   └── playAudio()                                        │
│  ├── RecommendationService                                  │
│  │   ├── getRecommendations() → Recombee API               │
│  │   └── trackUserBehavior()                               │
│  ├── BiometricService                                       │
│  │   ├── getHealthData() → HealthKit/Google Fit            │
│  │   └── analyzeBreathing() → TensorFlow Lite              │
│  └── EmotionService                                         │
│      └── analyzeEmotion() → Hume AI                         │
├─────────────────────────────────────────────────────────────┤
│  Data Layer                                                  │
│  ├── Local Storage (Hive/SharedPreferences)                 │
│  ├── Cache (Generated meditations, audio files)             │
│  └── Remote Storage (Firebase/Supabase)                     │
│      ├── User profiles                                      │
│      ├── Meditation history                                 │
│      └── Preferences                                        │
└─────────────────────────────────────────────────────────────┘
```

## Структура проекта

```
lib/
├── main.dart
├── models/
│   ├── meditation.dart
│   ├── user_preferences.dart
│   ├── biometric_data.dart
│   └── audio_track.dart
├── services/
│   ├── ai/
│   │   ├── openai_service.dart
│   │   ├── elevenlabs_service.dart
│   │   ├── mubert_service.dart
│   │   ├── recombee_service.dart
│   │   └── hume_service.dart
│   ├── health/
│   │   ├── health_service.dart
│   │   └── breathing_analyzer.dart
│   ├── storage/
│   │   ├── cache_service.dart
│   │   └── firebase_service.dart
│   └── meditation_service.dart
├── providers/
│   ├── meditation_provider.dart
│   ├── audio_provider.dart
│   └── user_provider.dart
├── screens/
│   ├── home_screen.dart
│   ├── meditation_screen.dart
│   ├── breathing_screen.dart
│   └── settings_screen.dart
└── utils/
    ├── api_config.dart
    └── constants.dart
```

## Этап 1: Настройка проекта и зависимостей

### 1.1 Обновление pubspec.yaml

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # HTTP клиент
  http: ^1.1.0
  dio: ^5.4.0
  
  # State management
  provider: ^6.1.1
  riverpod: ^2.4.9
  
  # Firebase
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6
  firebase_storage: ^11.5.6
  firebase_analytics: ^10.7.4
  
  # Health data
  health: ^10.1.0
  
  # Local storage
  shared_preferences: ^2.2.2
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  
  # Audio playback
  just_audio: ^0.9.36
  audio_service: ^0.18.11
  
  # Caching
  cached_network_image: ^3.3.1
  flutter_cache_manager: ^3.3.1
  
  # Environment variables
  flutter_dotenv: ^5.1.0
  
  # JSON serialization
  json_annotation: ^4.8.1
  
  # Utils
  intl: ^0.19.0
  uuid: ^4.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  build_runner: ^2.4.7
  json_serializable: ^6.7.1
  hive_generator: ^2.0.1
```

### 1.2 Создание конфигурации API

**lib/utils/api_config.dart**
```dart
class ApiConfig {
  // OpenAI
  static const String openAiApiKey = String.fromEnvironment('OPENAI_API_KEY');
  static const String openAiBaseUrl = 'https://api.openai.com/v1';
  
  // ElevenLabs
  static const String elevenLabsApiKey = String.fromEnvironment('ELEVENLABS_API_KEY');
  static const String elevenLabsBaseUrl = 'https://api.elevenlabs.io/v1';
  
  // Mubert
  static const String mubertApiKey = String.fromEnvironment('MUBERT_API_KEY');
  static const String mubertBaseUrl = 'https://api-b2b.mubert.com/v2';
  
  // Recombee
  static const String recombeeDatabaseId = String.fromEnvironment('RECOMBEE_DB_ID');
  static const String recombeeSecretToken = String.fromEnvironment('RECOMBEE_SECRET');
  static const String recombeeBaseUrl = 'https://rapi.recombee.com';
  
  // Hume AI
  static const String humeApiKey = String.fromEnvironment('HUME_API_KEY');
  static const String humeBaseUrl = 'https://api.hume.ai';
}
```

### 1.3 Создание моделей данных

**lib/models/meditation.dart**
```dart
import 'package:json_annotation/json_annotation.dart';

part 'meditation.g.dart';

@JsonSerializable()
class Meditation {
  final String id;
  final String title;
  final String script;
  final String audioUrl;
  final String? backgroundMusicUrl;
  final Duration duration;
  final MeditationType type;
  final MeditationGoal goal;
  final DateTime createdAt;
  final Map<String, dynamic>? metadata;

  Meditation({
    required this.id,
    required this.title,
    required this.script,
    required this.audioUrl,
    this.backgroundMusicUrl,
    required this.duration,
    required this.type,
    required this.goal,
    required this.createdAt,
    this.metadata,
  });

  factory Meditation.fromJson(Map<String, dynamic> json) => 
      _$MeditationFromJson(json);
  Map<String, dynamic> toJson() => _$MeditationToJson(this);
}

enum MeditationType {
  guided,
  breathing,
  bodyScan,
  lovingKindness,
  sleep,
  focus,
}

enum MeditationGoal {
  relax,
  focus,
  sleep,
  stressRelief,
  anxietyRelief,
}
```

## Этап 2: Интеграция OpenAI для генерации медитаций

### 2.1 Создание OpenAI сервиса

**lib/services/ai/openai_service.dart**
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/api_config.dart';
import '../../models/meditation.dart';

class OpenAIService {
  final http.Client _client;
  
  OpenAIService({http.Client? client}) 
      : _client = client ?? http.Client();

  Future<String> generateMeditationScript({
    required MeditationGoal goal,
    required Duration duration,
    required MeditationType type,
    String? userContext,
    String? mood,
  }) async {
    final prompt = _buildPrompt(goal, duration, type, userContext, mood);
    
    final response = await _client.post(
      Uri.parse('${ApiConfig.openAiBaseUrl}/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${ApiConfig.openAiApiKey}',
      },
      body: jsonEncode({
        'model': 'gpt-4-turbo-preview',
        'messages': [
          {
            'role': 'system',
            'content': 'You are an expert meditation guide. Create personalized meditation scripts that help users achieve their goals.',
          },
          {
            'role': 'user',
            'content': prompt,
          },
        ],
        'temperature': 0.7,
        'max_tokens': 2000,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to generate meditation: ${response.body}');
    }
  }

  String _buildPrompt(
    MeditationGoal goal,
    Duration duration,
    MeditationType type,
    String? userContext,
    String? mood,
  ) {
    final durationMinutes = duration.inMinutes;
    final goalText = goal.toString().split('.').last;
    final typeText = type.toString().split('.').last;
    
    return '''
Create a ${durationMinutes}-minute ${typeText} meditation script for ${goalText}.

${userContext != null ? 'User context: $userContext' : ''}
${mood != null ? 'Current mood: $mood' : ''}

The script should:
- Be appropriate for the duration
- Include breathing guidance
- Use calming, peaceful language
- Include pauses for reflection (indicated by "...")
- Guide the user naturally through the meditation
- End with a gentle return to awareness

Format the script as plain text, ready to be read aloud.
''';
  }
}
```

### 2.2 Создание сервиса медитаций

**lib/services/meditation_service.dart**
```dart
import 'package:hive/hive.dart';
import '../models/meditation.dart';
import 'ai/openai_service.dart';
import 'storage/cache_service.dart';

class MeditationService {
  final OpenAIService _openAIService;
  final CacheService _cacheService;
  final Box<Meditation> _meditationBox;

  MeditationService({
    required OpenAIService openAIService,
    required CacheService cacheService,
    required Box<Meditation> meditationBox,
  })  : _openAIService = openAIService,
        _cacheService = cacheService,
        _meditationBox = meditationBox;

  Future<Meditation> generateMeditation({
    required MeditationGoal goal,
    required Duration duration,
    required MeditationType type,
    String? userContext,
    String? mood,
    bool useCache = true,
  }) async {
    // Проверка кэша
    if (useCache) {
      final cached = _cacheService.getCachedMeditation(goal, duration, type);
      if (cached != null) return cached;
    }

    // Генерация нового скрипта
    final script = await _openAIService.generateMeditationScript(
      goal: goal,
      duration: duration,
      type: type,
      userContext: userContext,
      mood: mood,
    );

    final meditation = Meditation(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _generateTitle(goal, type),
      script: script,
      audioUrl: '', // Будет заполнено после генерации аудио
      duration: duration,
      type: type,
      goal: goal,
      createdAt: DateTime.now(),
    );

    // Сохранение в кэш
    await _meditationBox.put(meditation.id, meditation);
    _cacheService.cacheMeditation(meditation);

    return meditation;
  }

  String _generateTitle(MeditationGoal goal, MeditationType type) {
    final goalText = goal.toString().split('.').last;
    final typeText = type.toString().split('.').last;
    return '$typeText for $goalText';
  }
}
```

## Этап 3: Интеграция ElevenLabs для озвучки

### 3.1 Создание ElevenLabs сервиса

**lib/services/ai/elevenlabs_service.dart**
```dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../utils/api_config.dart';

class ElevenLabsService {
  final http.Client _client;
  final String _voiceId; // ID голоса из ElevenLabs
  
  ElevenLabsService({
    http.Client? client,
    String? voiceId,
  })  : _client = client ?? http.Client(),
        _voiceId = voiceId ?? 'default_voice_id';

  Future<String> generateSpeech({
    required String text,
    String? voiceId,
    double stability = 0.5,
    double similarityBoost = 0.75,
  }) async {
    final response = await _client.post(
      Uri.parse(
        '${ApiConfig.elevenLabsBaseUrl}/text-to-speech/${voiceId ?? _voiceId}',
      ),
      headers: {
        'Accept': 'audio/mpeg',
        'Content-Type': 'application/json',
        'xi-api-key': ApiConfig.elevenLabsApiKey,
      },
      body: jsonEncode({
        'text': text,
        'model_id': 'eleven_multilingual_v2',
        'voice_settings': {
          'stability': stability,
          'similarity_boost': similarityBoost,
        },
      }),
    );

    if (response.statusCode == 200) {
      // Сохранение аудио файла
      final audioPath = await _saveAudioFile(response.bodyBytes);
      return audioPath;
    } else {
      throw Exception('Failed to generate speech: ${response.body}');
    }
  }

  Future<String> _saveAudioFile(List<int> audioBytes) async {
    final directory = await _getAudioDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.mp3';
    final file = File('${directory.path}/$fileName');
    await file.writeAsBytes(audioBytes);
    return file.path;
  }

  Future<Directory> _getAudioDirectory() async {
    // Реализация получения директории для сохранения аудио
    // Используйте path_provider package
    throw UnimplementedError();
  }

  Future<List<Map<String, dynamic>>> getVoices() async {
    final response = await _client.get(
      Uri.parse('${ApiConfig.elevenLabsBaseUrl}/voices'),
      headers: {
        'xi-api-key': ApiConfig.elevenLabsApiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['voices']);
    } else {
      throw Exception('Failed to get voices: ${response.body}');
    }
  }
}
```

## Этап 4: Интеграция Mubert для музыки

### 4.1 Создание Mubert сервиса

**lib/services/ai/mubert_service.dart**
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/api_config.dart';

class MubertService {
  final http.Client _client;

  MubertService({http.Client? client}) 
      : _client = client ?? http.Client();

  Future<String> generateMusic({
    required String mood,
    required Duration duration,
    String? genre,
  }) async {
    // Получение токена
    final token = await _getToken();
    
    // Генерация трека
    final trackUrl = await _generateTrack(
      token: token,
      mood: mood,
      duration: duration,
      genre: genre,
    );

    return trackUrl;
  }

  Future<String> _getToken() async {
    final response = await _client.post(
      Uri.parse('${ApiConfig.mubertBaseUrl}/GetServiceAccess'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'method': 'GetServiceAccess',
        'params': {
          'email': 'your-email@example.com', // Заменить на реальный email
          'license': ApiConfig.mubertApiKey,
          'token': ApiConfig.mubertApiKey,
        },
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['token'];
    } else {
      throw Exception('Failed to get Mubert token: ${response.body}');
    }
  }

  Future<String> _generateTrack({
    required String token,
    required String mood,
    required Duration duration,
    String? genre,
  }) async {
    final response = await _client.post(
      Uri.parse('${ApiConfig.mubertBaseUrl}/GenerateTrackStream'),
      headers: {
        'Content-Type': 'application/json',
        'Token': token,
      },
      body: jsonEncode({
        'method': 'GenerateTrackStream',
        'params': {
          'duration': duration.inSeconds,
          'intensity': 'medium',
          'mood': mood,
          'genre': genre ?? 'meditation',
        },
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data']['playlist'][0];
    } else {
      throw Exception('Failed to generate music: ${response.body}');
    }
  }
}
```

## Этап 5: Интеграция HealthKit/Google Fit

### 5.1 Создание Health сервиса

**lib/services/health/health_service.dart**
```dart
import 'package:health/health.dart';
import 'dart:io';
import '../../models/biometric_data.dart';

class HealthService {
  Health? _health;
  List<HealthDataType> _types = [
    HealthDataType.HEART_RATE,
    HealthDataType.RESPIRATORY_RATE,
    HealthDataType.SLEEP_IN_BED,
    HealthDataType.STEPS,
  ];

  Future<void> initialize() async {
    _health = Health();
    
    bool requested = await _health!.requestAuthorization(_types);
    if (!requested) {
      throw Exception('Health data access denied');
    }
  }

  Future<BiometricData> getCurrentBiometrics() async {
    if (_health == null) await initialize();

    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    // Получение данных о пульсе
    final heartRate = await _health!.getHealthDataFromTypes(
      [HealthDataType.HEART_RATE],
      yesterday,
      now,
    );

    // Получение данных о дыхании
    final respiratoryRate = await _health!.getHealthDataFromTypes(
      [HealthDataType.RESPIRATORY_RATE],
      yesterday,
      now,
    );

    return BiometricData(
      heartRate: _getLatestValue(heartRate),
      respiratoryRate: _getLatestValue(respiratoryRate),
      timestamp: now,
    );
  }

  double? _getLatestValue(List<HealthDataPoint> dataPoints) {
    if (dataPoints.isEmpty) return null;
    dataPoints.sort((a, b) => b.dateFrom.compareTo(a.dateFrom));
    return dataPoints.first.value.toDouble();
  }

  Stream<BiometricData> getBiometricStream() async* {
    while (true) {
      final data = await getCurrentBiometrics();
      yield data;
      await Future.delayed(const Duration(seconds: 10));
    }
  }
}
```

## Этап 6: Интеграция Recombee для рекомендаций

### 6.1 Создание Recombee сервиса

**lib/services/ai/recombee_service.dart**
```dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../utils/api_config.dart';
import '../../models/meditation.dart';

class RecombeeService {
  final http.Client _client;

  RecombeeService({http.Client? client}) 
      : _client = client ?? http.Client();

  Future<void> trackUserInteraction({
    required String userId,
    required String meditationId,
    required String interactionType, // 'view', 'complete', 'like', etc.
  }) async {
    final endpoint = interactionType == 'view' 
        ? 'AddDetailView' 
        : 'AddPurchase';

    await _client.post(
      Uri.parse(
        '${ApiConfig.recombeeBaseUrl}/${ApiConfig.recombeeDatabaseId}/$endpoint',
      ),
      headers: {
        'Content-Type': 'application/json',
        'X-Recombee-Secret-Token': ApiConfig.recombeeSecretToken,
      },
      body: jsonEncode({
        'userId': userId,
        'itemId': meditationId,
        'cascadeCreate': true,
      }),
    );
  }

  Future<List<String>> getRecommendations({
    required String userId,
    int count = 10,
  }) async {
    final response = await _client.get(
      Uri.parse(
        '${ApiConfig.recombeeBaseUrl}/${ApiConfig.recombeeDatabaseId}/recomms/users/$userId?count=$count',
      ),
      headers: {
        'X-Recombee-Secret-Token': ApiConfig.recombeeSecretToken,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(
        data.map((item) => item['id'] as String),
      );
    } else {
      throw Exception('Failed to get recommendations: ${response.body}');
    }
  }
}
```

## Этап 7: Создание Provider для state management

### 7.1 Meditation Provider

**lib/providers/meditation_provider.dart**
```dart
import 'package:flutter/foundation.dart';
import '../models/meditation.dart';
import '../services/meditation_service.dart';
import '../services/ai/elevenlabs_service.dart';
import '../services/ai/mubert_service.dart';

class MeditationProvider with ChangeNotifier {
  final MeditationService _meditationService;
  final ElevenLabsService _elevenLabsService;
  final MubertService _mubertService;

  Meditation? _currentMeditation;
  bool _isGenerating = false;
  String? _error;

  MeditationProvider({
    required MeditationService meditationService,
    required ElevenLabsService elevenLabsService,
    required MubertService mubertService,
  })  : _meditationService = meditationService,
        _elevenLabsService = elevenLabsService,
        _mubertService = mubertService;

  Meditation? get currentMeditation => _currentMeditation;
  bool get isGenerating => _isGenerating;
  String? get error => _error;

  Future<void> generateMeditation({
    required MeditationGoal goal,
    required Duration duration,
    required MeditationType type,
    String? userContext,
    String? mood,
  }) async {
    _isGenerating = true;
    _error = null;
    notifyListeners();

    try {
      // Генерация текста
      final meditation = await _meditationService.generateMeditation(
        goal: goal,
        duration: duration,
        type: type,
        userContext: userContext,
        mood: mood,
      );

      // Генерация озвучки
      final audioUrl = await _elevenLabsService.generateSpeech(
        text: meditation.script,
      );

      // Генерация музыки
      final musicUrl = await _mubertService.generateMusic(
        mood: _getMoodFromGoal(goal),
        duration: duration,
      );

      _currentMeditation = meditation.copyWith(
        audioUrl: audioUrl,
        backgroundMusicUrl: musicUrl,
      );

      _isGenerating = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isGenerating = false;
      notifyListeners();
    }
  }

  String _getMoodFromGoal(MeditationGoal goal) {
    switch (goal) {
      case MeditationGoal.relax:
        return 'calm';
      case MeditationGoal.sleep:
        return 'sleepy';
      case MeditationGoal.focus:
        return 'focused';
      default:
        return 'peaceful';
    }
  }
}
```

## Этап 8: Настройка Firebase

### 8.1 Инициализация Firebase

**lib/main.dart** (обновленный)
```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/meditation_provider.dart';
import 'services/meditation_service.dart';
// ... другие импорты

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Инициализация сервисов и провайдеров
        ChangeNotifierProvider(
          create: (_) => MeditationProvider(
            meditationService: MeditationService(...),
            elevenLabsService: ElevenLabsService(...),
            mubertService: MubertService(...),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'AI Meditation',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
```

## Этап 9: Создание экранов

### 9.1 Главный экран

**lib/screens/home_screen.dart**
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meditation_provider.dart';
import '../models/meditation.dart';
import 'meditation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Meditation'),
      ),
      body: Column(
        children: [
          // Выбор цели
          _buildGoalSelector(context),
          // Выбор типа медитации
          _buildTypeSelector(context),
          // Кнопка генерации
          ElevatedButton(
            onPressed: () => _generateMeditation(context),
            child: const Text('Generate Meditation'),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalSelector(BuildContext context) {
    // Реализация выбора цели
    return Container();
  }

  Widget _buildTypeSelector(BuildContext context) {
    // Реализация выбора типа
    return Container();
  }

  Future<void> _generateMeditation(BuildContext context) async {
    final provider = Provider.of<MeditationProvider>(context, listen: false);
    
    await provider.generateMeditation(
      goal: MeditationGoal.relax,
      duration: const Duration(minutes: 10),
      type: MeditationType.guided,
    );

    if (provider.currentMeditation != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MeditationScreen(
            meditation: provider.currentMeditation!,
          ),
        ),
      );
    }
  }
}
```

## Этап 10: Тестирование и оптимизация

### 10.1 Unit тесты

**test/services/openai_service_test.dart**
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:ai_meditation/services/ai/openai_service.dart';

void main() {
  group('OpenAIService', () {
    test('generates meditation script successfully', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          '{"choices": [{"message": {"content": "Test meditation script"}}]}',
          200,
        );
      });

      final service = OpenAIService(client: mockClient);
      
      final script = await service.generateMeditationScript(
        goal: MeditationGoal.relax,
        duration: const Duration(minutes: 10),
        type: MeditationType.guided,
      );

      expect(script, isNotEmpty);
    });
  });
}
```

### 10.2 Оптимизация производительности

1. **Кэширование**: Сохранение популярных медитаций
2. **Ленивая загрузка**: Генерация аудио только при необходимости
3. **Батчинг**: Группировка запросов к API
4. **Офлайн режим**: Использование кэшированных медитаций

## Чеклист интеграции

### Фаза 1 (MVP):
- [ ] Настройка проекта и зависимостей
- [ ] Создание моделей данных
- [ ] Интеграция OpenAI для генерации текстов
- [ ] Интеграция ElevenLabs для озвучки
- [ ] Базовый UI для генерации медитаций
- [ ] Локальное кэширование

### Фаза 2 (Персонализация):
- [ ] Интеграция Mubert для музыки
- [ ] Интеграция HealthKit/Google Fit
- [ ] Интеграция Recombee для рекомендаций
- [ ] Анализ биометрических данных
- [ ] Персонализация на основе данных пользователя

### Фаза 3 (Оптимизация):
- [ ] Интеграция Hume AI для анализа эмоций
- [ ] Оптимизация кэширования
- [ ] Мониторинг использования API
- [ ] A/B тестирование разных моделей
- [ ] Оптимизация затрат

## Безопасность

1. **API ключи**: Хранить в переменных окружения, не коммитить в репозиторий
2. **Шифрование**: Шифровать чувствительные данные пользователей
3. **Валидация**: Валидировать все входные данные
4. **Rate limiting**: Ограничить частоту запросов к API
5. **Обработка ошибок**: Корректная обработка всех ошибок API

## Мониторинг и аналитика

1. **Firebase Analytics**: Отслеживание использования функций
2. **Crashlytics**: Отслеживание ошибок
3. **Performance Monitoring**: Мониторинг производительности
4. **Custom events**: Отслеживание генерации медитаций, использования рекомендаций

## Дальнейшее развитие

1. **Социальные функции**: Обмен медитациями между пользователями
2. **Прогресс трекинг**: Отслеживание прогресса пользователя
3. **Геймификация**: Достижения и награды
4. **Подписки**: Премиум функции
5. **Экспорт**: Экспорт медитаций в различные форматы
