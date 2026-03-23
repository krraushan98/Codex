import 'package:flutter/material.dart';

void main() {
  runApp(const DailyActivityApp());
}

class DailyActivityApp extends StatelessWidget {
  const DailyActivityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Activity',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        useMaterial3: true,
      ),
      home: const ActivityDashboardPage(),
    );
  }
}

class ActivityDashboardPage extends StatefulWidget {
  const ActivityDashboardPage({super.key});

  @override
  State<ActivityDashboardPage> createState() => _ActivityDashboardPageState();
}

class _ActivityDashboardPageState extends State<ActivityDashboardPage> {
  int selectedDayIndex = 0;

  final List<DailyActivity> activity = const [
    DailyActivity(
      dayLabel: 'Today',
      dateLabel: 'Mar 23',
      screenTime: '4h 12m',
      steps: 8420,
      focusMinutes: 96,
      pickups: 54,
      categoryBreakdown: [
        ActivityCategory(name: 'Productivity', minutes: 110, color: Color(0xFF4F46E5)),
        ActivityCategory(name: 'Social', minutes: 72, color: Color(0xFFEC4899)),
        ActivityCategory(name: 'Health', minutes: 44, color: Color(0xFF10B981)),
        ActivityCategory(name: 'Entertainment', minutes: 26, color: Color(0xFFF59E0B)),
      ],
    ),
    DailyActivity(
      dayLabel: 'Yesterday',
      dateLabel: 'Mar 22',
      screenTime: '3h 48m',
      steps: 6905,
      focusMinutes: 82,
      pickups: 61,
      categoryBreakdown: [
        ActivityCategory(name: 'Productivity', minutes: 90, color: Color(0xFF4F46E5)),
        ActivityCategory(name: 'Social', minutes: 68, color: Color(0xFFEC4899)),
        ActivityCategory(name: 'Health', minutes: 38, color: Color(0xFF10B981)),
        ActivityCategory(name: 'Entertainment', minutes: 32, color: Color(0xFFF59E0B)),
      ],
    ),
    DailyActivity(
      dayLabel: 'Friday',
      dateLabel: 'Mar 21',
      screenTime: '5h 05m',
      steps: 10112,
      focusMinutes: 105,
      pickups: 49,
      categoryBreakdown: [
        ActivityCategory(name: 'Productivity', minutes: 124, color: Color(0xFF4F46E5)),
        ActivityCategory(name: 'Social', minutes: 86, color: Color(0xFFEC4899)),
        ActivityCategory(name: 'Health', minutes: 42, color: Color(0xFF10B981)),
        ActivityCategory(name: 'Entertainment', minutes: 53, color: Color(0xFFF59E0B)),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedActivity = activity[selectedDayIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Activity'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _HeaderCard(activity: selectedActivity),
            const SizedBox(height: 20),
            Text(
              'Choose a day',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 52,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: activity.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final day = activity[index];
                  final isSelected = index == selectedDayIndex;
                  return ChoiceChip(
                    label: Text('${day.dayLabel} · ${day.dateLabel}'),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        selectedDayIndex = index;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _MetricCard(
                  label: 'Screen time',
                  value: selectedActivity.screenTime,
                  icon: Icons.phone_iphone_rounded,
                ),
                _MetricCard(
                  label: 'Steps',
                  value: '${selectedActivity.steps}',
                  icon: Icons.directions_walk_rounded,
                ),
                _MetricCard(
                  label: 'Focus time',
                  value: '${selectedActivity.focusMinutes} min',
                  icon: Icons.psychology_rounded,
                ),
                _MetricCard(
                  label: 'Phone pickups',
                  value: '${selectedActivity.pickups}',
                  icon: Icons.touch_app_rounded,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Activity breakdown',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            ...selectedActivity.categoryBreakdown.map(
              (category) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _CategoryBar(category: category),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily summary',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'You stayed active with ${selectedActivity.steps} steps and '
                      '${selectedActivity.focusMinutes} minutes of focus time. '
                      'Your most-used category was '
                      '${selectedActivity.topCategory.name.toLowerCase()} today.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.activity});

  final DailyActivity activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF4338CA), Color(0xFF6366F1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activity.dayLabel,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Track your phone habits and movement in one place.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.92),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _HeaderStat(
                  label: 'Top activity',
                  value: activity.topCategory.name,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _HeaderStat(
                  label: 'Pickups',
                  value: '${activity.pickups}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderStat extends StatelessWidget {
  const _HeaderStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width - 56) / 2;

    return SizedBox(
      width: width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Icon(icon, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 14),
              Text(
                value,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(label),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryBar extends StatelessWidget {
  const _CategoryBar({required this.category});

  final ActivityCategory category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category.name,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text('${category.minutes} min'),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: category.minutes / 140,
            minHeight: 12,
            backgroundColor: category.color.withOpacity(0.15),
            valueColor: AlwaysStoppedAnimation<Color>(category.color),
          ),
        ),
      ],
    );
  }
}

class DailyActivity {
  const DailyActivity({
    required this.dayLabel,
    required this.dateLabel,
    required this.screenTime,
    required this.steps,
    required this.focusMinutes,
    required this.pickups,
    required this.categoryBreakdown,
  });

  final String dayLabel;
  final String dateLabel;
  final String screenTime;
  final int steps;
  final int focusMinutes;
  final int pickups;
  final List<ActivityCategory> categoryBreakdown;

  ActivityCategory get topCategory {
    return categoryBreakdown.reduce(
      (current, next) => current.minutes >= next.minutes ? current : next,
    );
  }
}

class ActivityCategory {
  const ActivityCategory({
    required this.name,
    required this.minutes,
    required this.color,
  });

  final String name;
  final double minutes;
  final Color color;
}
