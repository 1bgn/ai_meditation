import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/di/injection_container.dart';
import '../../../../core/ui/action_slider.dart';
import '../../domain/entities/daily_routine_item.dart';
import '../controllers/daily_routine_controller.dart';

class DailyRoutinePage extends StatefulWidget {
  const DailyRoutinePage({super.key});

  @override
  State<DailyRoutinePage> createState() => _DailyRoutinePageState();
}

class _DailyRoutinePageState extends State<DailyRoutinePage> {
  late final DailyRoutineController _controller;

  static const _sectionTitles = [
    'Morning meditation',
    'Afternoon breathing',
    'Evening relaxation',
  ];

  static const _sectionImages = [
    'assets/images/morning_meditation.png',
    'assets/images/daily_routine.svg',
    'assets/images/evening_meditation.png',
  ];

  @override
  void initState() {
    super.initState();
    _controller = getIt<DailyRoutineController>();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('ROUTINE'),
        centerTitle: true,
        actions: const [
          Icon(Icons.favorite_border),
          SizedBox(width: 12),
          Icon(Icons.autorenew),
          SizedBox(width: 16),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF6F7FB),
              Color(0xFFFFFFFF),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Daily Rhythm',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'A short mindful ritual for morning, afternoon, and night.',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: _controller.routineItems.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 18),
                    itemBuilder: (context, index) {
                      final item = _controller.routineItems[index];
                      final image = _sectionImages[index];
                      final title = _sectionTitles[index];
                      if (index == 1) {
                        return _BreathingCard(
                          item: item,
                          imageAsset: image,
                          color: const Color.fromRGBO(119, 201, 126, 0.16),
                          durationLabel: '${item.durationMinutes} min',
                        );
                      }
                      return _MeditationCard(
                        item: item,
                        imageAsset: image,
                        title: title,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                ActionSlider(
                  onCompleted: () async {
                    await _controller.completeRoutine();
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Daily routine saved to history'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Mark as done',
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MeditationCard extends StatelessWidget {
  const _MeditationCard({
    required this.item,
    required this.imageAsset,
    required this.title,
  });

  final DailyRoutineItem item;
  final String imageAsset;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imageAsset,
              width: 88,
              height: 88,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      '${item.durationMinutes} min',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Text(
                  '${item.durationMinutes} min',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BreathingCard extends StatelessWidget {
  const _BreathingCard({
    required this.item,
    required this.imageAsset,
    required this.color,
    required this.durationLabel,
  });

  final DailyRoutineItem item;
  final String imageAsset;
  final Color color;
  final String durationLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageBackground = Container(
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: Color.lerp(color, Colors.white, 0.35) ?? color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            imageAsset,
            width: 44,
            height: 44,
            colorFilter:
                const ColorFilter.mode(Color(0xFF77C97E), BlendMode.srcIn),
          ),
          Positioned(
            bottom: 6,
            child: Text(
              durationLabel,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          )
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          imageBackground,
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Inhale 4 sec • Exhale 6 sec',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
