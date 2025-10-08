import 'package:SmokeTracker/components/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/health_goal_card.dart';
import '/l10n/app_localizations.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({super.key});

  @override
  _HealthScreenState createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {
  DateTime? lastSmoked;
  int durationSinceLastSmoked = 0;

  @override
  void initState() {
    super.initState();
    _loadLastSmoked();
  }

  Future<void> _loadLastSmoked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastSmokedString = prefs.getString('lastSmoked');

    setState(() {
      lastSmoked = DateTime.parse(lastSmokedString!);
      durationSinceLastSmoked =
          DateTime.now().difference(lastSmoked!).inMinutes;
    });
    }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> healthGoals = [
      {
        'title': AppLocalizations.of(context)!.health2DaysTitle,
        'description':
            AppLocalizations.of(context)!.health2DaysText,
        'time': 2 * 24 * 60, // 2 days in minutes
      },
      {
        'title': AppLocalizations.of(context)!.health3DaysTitle,
        'description':
            AppLocalizations.of(context)!.health3DaysText,
        'time': 3 * 24 * 60, // 3 days in minutes
      },
      {
        'title': AppLocalizations.of(context)!.health7DaysTitle,
        'description': AppLocalizations.of(context)!.health7DaysText,
        'time': 7 * 24 * 60, // 7 days in minutes
      },
      {
        'title': AppLocalizations.of(context)!.health2WeeksTitle,
        'description': AppLocalizations.of(context)!.health2WeeksText,
        'time': 2 * 7 * 24 * 60, // 2 weeks in minutes
      },
      {
        'title': AppLocalizations.of(context)!.health1MonthTitle,
        'description': AppLocalizations.of(context)!.health1MonthText,
        'time': 30 * 24 * 60, // 1 month in minutes
      },
      {
        'title': AppLocalizations.of(context)!.health2MonthsTitle,
        'description':
            AppLocalizations.of(context)!.health2MonthsText,
        'time': (2.5 * 30 * 24 * 60).toInt(), // 2.5 months in minutes
      },
      {
        'title': AppLocalizations.of(context)!.health3MonthsTitle,
        'description': AppLocalizations.of(context)!.health3MonthsText,
        'time': 3 * 30 * 24 * 60, // 3 months in minutes
      },
      {
        'title': AppLocalizations.of(context)!.health1YearTitle,
        'description':
            AppLocalizations.of(context)!.health1YearText,
        'time': 365 * 24 * 60, // 1 year in minutes
      },
      {
        'title': AppLocalizations.of(context)!.health5YearsTitle,
        'description': AppLocalizations.of(context)!.health5YearsText,
        'time': 5 * 365 * 24 * 60, // 5 years in minutes
      },
      {
        'title': AppLocalizations.of(context)!.health15YearsTitle,
        'description':
            AppLocalizations.of(context)!.health15YearsText,
        'time': 15 * 365 * 24 * 60, // 15 years in minutes
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Health Progress'),
            floating: true,
            snap: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: lastSmoked == null
                ? SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final goal = healthGoals[index];
                        final progress =
                            durationSinceLastSmoked / goal['time'];
                        final completed = progress >= 1.0;

                        return HealthGoalCard(
                          title: goal['title'],
                          description: goal['description'],
                          progress: progress,
                          completed: completed,
                          timeRemaining: goal['time'] - durationSinceLastSmoked,
                        );
                      },
                      childCount: healthGoals.length,
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavigationBar(currentIndex: 2),
    );
  }
}
