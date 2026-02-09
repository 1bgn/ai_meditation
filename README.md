# AI Meditation

Мобильное приложение для персонализированных медитаций с использованием искусственного интеллекта.

## Описание

Приложение генерирует персонализированные медитации с помощью ИИ, подбирает аудиотреки, настраивает дыхательные упражнения и помогает пользователю расслабиться, улучшить фокус или сон.

## Документация

### [AI_SERVICES.md](AI_SERVICES.md)
Подробный список AI сервисов для реализации функциональности приложения:
- Генерация текста медитаций (LLM)
- Text-to-Speech для озвучки
- Генерация музыки и звуков
- Рекомендательные системы
- Биометрические данные
- Оценка каждого сервиса по критериям: цена, качество, простота интеграции

### [INTEGRATION_PLAN.md](INTEGRATION_PLAN.md)
Детальный план интеграции AI сервисов в Flutter приложение:
- Архитектура приложения
- Структура проекта
- Пошаговая интеграция каждого сервиса
- Примеры кода
- Чеклист реализации

## Рекомендуемый стек (MVP)

1. **OpenAI GPT-4 Turbo** - генерация текстов медитаций
2. **ElevenLabs** - озвучка медитаций
3. **Mubert API** - генерация фоновой музыки
4. **Firebase/Supabase** - хранение данных и аналитика
5. **HealthKit/Google Fit** - биометрические данные

## Быстрый старт

1. Изучите [AI_SERVICES.md](AI_SERVICES.md) для выбора подходящих сервисов
2. Следуйте инструкциям в [INTEGRATION_PLAN.md](INTEGRATION_PLAN.md) для интеграции
3. Настройте API ключи в переменных окружения
4. Начните с MVP функциональности

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
