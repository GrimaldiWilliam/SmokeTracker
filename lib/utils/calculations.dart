import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Calculations {
  /// Calculate money saved based on the price history and duration
  static Future<double> calculateMoneySaved(DateTime lastSmoked) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int packetsPerWeek = prefs.getInt('packetsPerWeek') ?? 0;
    int cigarettesPerPacket = prefs.getInt('cigarettesPerPacket') ?? 0;

    String? priceHistoryJson = prefs.getString('priceHistory');
    List<Map<String, dynamic>> priceHistory = List<Map<String, dynamic>>.from(jsonDecode(priceHistoryJson!));

    double totalSaved = 0.0;
    DateTime startDate = lastSmoked;

    for (int i = 0; i < priceHistory.length; i++) {
      double price = priceHistory[i]['price'];
      DateTime endDate = (i + 1 < priceHistory.length)
          ? DateTime.parse(priceHistory[i + 1]['date'])
          : DateTime.now();

      if (startDate.isBefore(endDate)) {
        double minutes = endDate.difference(startDate).inMinutes.toDouble();
        double cigarettesPerMinute =
            ((packetsPerWeek * cigarettesPerPacket) / 7.0) / 1440.0; // 1440 minutes in a day
        totalSaved += ((minutes * cigarettesPerMinute) / cigarettesPerPacket) * price;
        startDate = endDate;
      }
    }
    return totalSaved;
  }

  /// Calculate cigarettes avoided based on duration and smoking rate
  static Future<int> calculateCigarettesAvoided(
      DateTime lastSmoked, int packetsPerWeek, int cigarettesPerPacket) async {
    final duration = DateTime.now().difference(lastSmoked);
    double cigarettesPerMinute =
        ((packetsPerWeek * cigarettesPerPacket) / 7.0) / 1440.0; // Cigarettes per minute
    return (duration.inMinutes * cigarettesPerMinute).toInt();
  }
}
