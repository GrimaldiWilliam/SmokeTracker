import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CircularProgressGoal extends StatefulWidget {
  final List<Map<String, dynamic>> healthGoals; // List of health goals

  const CircularProgressGoal({
    super.key,
    required this.healthGoals,
  });

  @override
  _CircularProgressGoalState createState() => _CircularProgressGoalState();
}

class _CircularProgressGoalState extends State<CircularProgressGoal> {
  int durationSinceLastSmoked = 0; // Duration in minutes since last smoked
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    _loadLastSmoked();
  }

  Future<void> _loadLastSmoked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lastSmokedString = prefs.getString('lastSmoked').toString();

    DateTime lastSmoked = DateTime.parse(lastSmokedString);
    setState(() {
      durationSinceLastSmoked =
          DateTime.now().difference(lastSmoked).inMinutes;
      isLoading = false;
    });
    }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Find the next health goal
    final nextGoal = widget.healthGoals.firstWhere(
      (goal) => durationSinceLastSmoked < goal['time'],
      orElse: () => {
        'title': 'All goals achieved',
        'time': durationSinceLastSmoked,
        'description': 'You have achieved all the health goals. 🎉',
      },
    );

    final timeRemaining = nextGoal['time'] - durationSinceLastSmoked;
    final progress = durationSinceLastSmoked / nextGoal['time'];

    // Format time remaining as hours, minutes, days, etc.
    String formattedTimeRemaining = _formatTimeRemaining(timeRemaining);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            // Circular progress indicator
            SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                value: progress.clamp(0.0, 1.0),
                strokeWidth: 8.0,
                backgroundColor: Colors.grey[300],
                color: Colors.blue,
              ),
            ),
            // Text in the center
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedTimeRemaining,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  nextGoal['title'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          nextGoal['description'],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  // Helper function to format the remaining time
  String _formatTimeRemaining(int minutes) {
    if (minutes <= 0) return "Completed";

    final int days = minutes ~/ (60 * 24);
    final int hours = (minutes % (60 * 24)) ~/ 60;
    final int remainingMinutes = minutes % 60;

    if (days > 0 && hours > 0) {
      return "$days days, $hours hours";
    } else if (hours > 0) {
      return "$hours hours, $remainingMinutes mins";
    } else {
      return "$remainingMinutes mins";
    }
  }
}
