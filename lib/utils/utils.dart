// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'package:SmokeTracker/screens/home_screen.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:convert'; // Importa la libreria per la codifica/decodifica JSON
import 'dart:io';

import 'locator.dart';    // Importa la libreria per le operazioni sui file

/// Example event class.
class Event {
  final String title;
  int smokedCigarettesOnDay;
  String filename = 'smoking_data.json';

  Event(this.title, this.smokedCigarettesOnDay);

  @override
  String toString() => "$title $smokedCigarettesOnDay";

  void setCigarettes(int smoked){
    this.smokedCigarettesOnDay = smoked;
  }

  int getCigarettes(){
    return this.smokedCigarettesOnDay;
  }
}

Future<Map<DateTime, List<Event>>> getEvents() async {
  String filePath = getIt.get<String>(instanceName: 'filePath');
  final file = File(filePath);
  final events = <DateTime, List<Event>>{};

  if (!await file.exists()) {
    print('File not found: $filePath');
    return events;
  }

  final lines = await file.readAsLines();

  for (var line in lines) {
    if (line.trim().isEmpty) continue;

    try {
      final Map<String, dynamic> jsonData = jsonDecode(line);
      final String? timestampString = jsonData['Smoked'];
      final int? cigarettesCount = jsonData['Cigarettes Today'];

      if (timestampString != null && cigarettesCount != null) {
        final DateTime recordDate = DateTime.parse(timestampString);
        final day = DateTime.utc(recordDate.year, recordDate.month, recordDate.day);

        // We want the last (and highest) cigarette count for the day.
        if (events.containsKey(day)) {
          if (cigarettesCount > events[day]!.first.smokedCigarettesOnDay) {
            events[day]!.first.smokedCigarettesOnDay = cigarettesCount;
          }
        } else {
          events[day] = [Event('On this day you smoked ', cigarettesCount)];
        }
      }
    } catch (e) {
      print('Error parsing JSON line: "$line" - Error: $e');
    }
  }
  return events;
}

// Assumendo che i tuoi campi siano "Smoked" e "Cigarettes Today"
Future<int?> getSmokedCigarettesForDay(DateTime targetDay, String filePath) async {
  final file = File(filePath);

  if (!await file.exists()) {
    print('File non trovato: $filePath');
    return null;
  }

  int? lastCountForDay;

  await for (var line in file.openRead().transform(utf8.decoder).transform(LineSplitter())) {
    if (line.trim().isEmpty) continue;

    try {
      final Map<String, dynamic> jsonData = jsonDecode(line);
      final String? timestampString = jsonData['Smoked'];
      final int? cigarettesCount = jsonData['Cigarettes Today'];

      if (timestampString != null && cigarettesCount != null) {
        final DateTime recordDate = DateTime.parse(timestampString);

        if (isSameDay(recordDate, targetDay)) {
          lastCountForDay = cigarettesCount;
        }
      }
    } catch (e) {
      print('Errore nel parsing della riga JSON: "$line" - Errore: $e');
    }
  }

  return lastCountForDay;
}

// Come potresti chiamarla per ottenere il valore per kToday
// Nota: questa è una funzione asincrona, quindi dovrai usare `await`
Future<int> getSmokedForToday() async {
  String filePath = getIt.get<String>(instanceName: 'filePath');
  int? smoked = await getSmokedCigarettesForDay(kToday, filePath);
  return smoked ?? 0; // Ritorna 0 se non viene trovato nessun dato (null)
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);