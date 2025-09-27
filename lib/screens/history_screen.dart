import 'dart:convert';
import 'dart:io';
import 'package:exhale/components/navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '/utils/locator.dart';
import '/l10n/app_localizations.dart';
import 'home_screen.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HistoryScreen extends StatelessWidget {

  DateTime date = DateTime.now();
  int smoked = 0;
  String filePath = getIt.get<String>(instanceName: 'filePath');

  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;



  // Function to open URLs
  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  List<Map<String, int>> _items = [];

  Future<void> loadJsonSingleDay() async {
    final String response = await rootBundle.loadString(filePath);
    final data = jsonDecode(response);
    DateTime daytmp;
    for (var item in data) {
      daytmp = DateTime.parse(item["Smoked"]);
      if (daytmp.day != DateTime.now().day) {

      }
    }
    setState(() {
      _items = data["Cigarettes Today"];
      _items = data["Smoked"];
    });
  }


  Future<Map<DateTime, int>> getCigarettePerDay(day) async {
    List<Map<String, int>> allRecords = _items;
    Map<DateTime, int> cigarettesPerDay = {};

    if (allRecords.isEmpty) {
      return cigarettesPerDay;
    }

    for (var record in allRecords) {
      final smokedAtString = record['Smoked'];
      final cigarettesTodayCount = record['Cigarettes Today'];

      if (smokedAtString is String && cigarettesTodayCount is int) {
        try {
          DateTime smokedDateTime = DateTime.parse(smokedAtString.toString());

          // Se "Cigarettes Today" è il conteggio progressivo, vogliamo il massimo per quel giorno
          if (cigarettesPerDay.containsKey(smokedDateTime)) {
            if (cigarettesTodayCount > cigarettesPerDay[smokedDateTime]!) {
              cigarettesPerDay[smokedDateTime] = cigarettesTodayCount;
            }
          } else {
            cigarettesPerDay[smokedDateTime] = cigarettesTodayCount;
          }
        } catch (e) {
          print('Errore nel parsing della data o nel formato del record: $e - Record: $record');
        }} else {
        print('Record saltato a causa di tipo di dati inatteso: $record');
      }
    }
    return cigarettesPerDay;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'History',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'On $date you smoked $smoked cigarettes',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TableCalendar(
              firstDay: DateTime.utc(1970, 1, 1),
              lastDay: DateTime.utc(2050, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                // Use `selectedDayPredicate` to determine which day is currently selected.
                // If this returns true, then `day` will be marked as selected.

                // Using `isSameDay` is recommended to disregard
                // the time-part of compared DateTime objects.
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (!isSameDay(_selectedDay, selectedDay)) {
                  // Call `setState()` when updating the selected day
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay =
                        focusedDay; // update `_focusedDay` here as well
                  });
                }
                onFormatChanged:
                    (format) {
                  if (_calendarFormat != format) {
                    // Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                };
                onPageChanged:
                    (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                };
                eventLoader: (day) {
                  return getCigarettePerDay(day);
                };
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(currentIndex: 1),
    );
  }

  void setState(Null Function() param0) {}
}
