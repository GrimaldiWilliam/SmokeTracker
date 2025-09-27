import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../utils/locator.dart';
import '../utils/time_formatter.dart';
import '../utils/calculations.dart';
import 'config_screen.dart';
import 'about_screen.dart';
import 'backup_screen.dart';
import '/l10n/app_localizations.dart';
import '../components/navigation_bar.dart';
import 'dart:convert'; // Importa la libreria per la codifica/decodifica JSON
import 'dart:io';    // Importa la libreria per le operazioni sui file
import 'package:path_provider/path_provider.dart'; // Aggiungi questa dipendenza al tuo pubspec.yaml
import 'package:share_plus/share_plus.dart'; // Importa share_plus

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime lastSmoked = DateTime.now();
  bool isFirstTime = true;
  bool _friendsEnabled = true;

  int packetsPerWeek = 0;
  int cigarettesPerPacket = 0;

  double moneySaved = 0.0;
  int cigarettesAvoided = 0;

  int _cigarettesPerDayCount = 0;

  late Timer timer;

  late int cigarettesPerDay;

  String filename = 'smoking_data.json';
  String filePath = getIt.get<String>(instanceName: 'filePath');
  late Directory directory;

  @override
  void initState() {
    super.initState();
    _generateAndSaveUserId();
    _initializeData();
    _loadCigarettesPerDay();
    // Periodically update the UI every second
    timer = Timer.periodic(Duration(seconds: 1), (_) => _updateCalculations());
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<int> _getcigarettesPerDay() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('cigarettesPerDay') ?? 0;
  }

  Future<void> _loadCigarettesPerDay() async {
    if (DateTime.now().day != lastSmoked.day) {
      setState(() {
        _cigarettesPerDayCount = 0;
      });
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _cigarettesPerDayCount = prefs.getInt('cigarettesPerDay') ?? 0;
      });
    }
  }

  Future<void> _addcigarettes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentCount = prefs.getInt('cigarettesPerDay') ?? 0;
    int newCount = currentCount + 1;
    await prefs.setInt('cigarettesPerDay', newCount);
    setState(() { // Aggiorna la variabile di stato e ricostruisci l'UI
      _cigarettesPerDayCount = newCount;
      lastSmoked = DateTime.now();
    });
    await _saveToJson();
  }

  Future<void> _saveToJson() async {
    try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        DateTime? lastSmokedTime = lastSmoked;
        int currentcigarettesPerDay = _cigarettesPerDayCount;

        Map<String, dynamic> jsonData = {
          'Cigarettes Today': currentcigarettesPerDay,
          'Smoked': lastSmokedTime?.toIso8601String(),
        };

        String jsonString = jsonEncode(jsonData);

        final file = File(filePath);

        String lastLine = "";
        int lastIndex = 0;
        // Controlla se il file esiste e non è vuoto prima di leggerlo
        if (await file.exists() && await file.length() > 0) {
          List<String> lines = await file.readAsLines();
          // Trova l'ultima riga non vuota partendo dalla fine
          for (int i = lines.length - 1; i >= 0; i--) {
            if (lines[i]
                .trim()
                .isNotEmpty) {
              lastLine = lines[i];
              lastIndex = i;
              break;
            }
          }

          int lastSmokedTimeFromJson = jsonDecode(lastLine)['Smoked'];
          //Vedi l'ultima riga del JSON
          //Se la data all'ultima riga è diversa da currentcigarettesPerDay
          if (lastSmokedTimeFromJson != lastSmokedTime.day) {
            await file.writeAsString(
                '$jsonString \n', mode: FileMode.append, flush: true);
          } else {
            // Altrimenti, la data è la STESSA: sostituisci l'ultima riga "effettiva"
            // Rimuovi tutte le righe dall'ultima riga effettiva in poi
            // (questo gestisce anche eventuali righe vuote dopo l'ultima riga JSON)
            lines.removeRange(lastIndex, lines.length);

            // Aggiungi la nuova riga JSON
            lines.add(jsonString);

            // Ricostruisci il contenuto del file
            String contentToRewrite = lines.join('\n') +
                (lines.isNotEmpty ? '\n' : '');
            await file.writeAsString(
                contentToRewrite, mode: FileMode.write, flush: true);
          }
          //altrimenti sostituisci l'ultima riga con jsondata

        }
      } catch (e) {
        print('Errore durante la preparazione/condivisione/download del JSON: $e');
        // Gestisci l'errore, ad esempio mostrando un messaggio all'utente
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Errore nel salvataggio dei dati.')),
        // );
      }
    }

// Assicurati di chiamare _saveToJson() quando vuoi salvare i dati,
// ad esempio dopo aver premuto un pulsante o quando l'app viene messa in pausa.
// Nel tuo codice, la stai chiamando in _addcigarettes(), il che potrebbe essere appropriato
// se vuoi salvare lo stato completo ogni volta che si fuma una sigaretta.
// Potrebbe anche avere senso chiamarla in dispose() o quando l'app va in background.
  // Quando devi leggere i dati da NDJSON:

  Future<void> _shareJson() async {
    // 2. Condividi il file usando share_plus
    // Converti il percorso del file in XFile, che è il tipo atteso da shareXFiles
    final xFile = XFile(filePath, mimeType: 'application/json', name: filename);
    print(filePath);
    await Share.shareXFiles([XFile(filePath)],);
  }

  Future<void> _generateAndSaveUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
  }

  Future<void> _initializeData() async {
    await _loadConfigData();
    await _loadLastSmoked();
    await _loadCigarettesPerDay();
    _updateCalculations();
  }

  Future<void> _loadLastSmoked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedTime = prefs.getString('lastSmoked');
    bool hasStarted = prefs.getBool('hasStarted') ?? false;

    if (hasStarted) {
      setState(() {
        lastSmoked = DateTime.parse(storedTime!);
        isFirstTime = false;
      });
    }
  }

  Future<void> _loadConfigData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      packetsPerWeek = prefs.getInt('packetsPerWeek') ?? 0;
      cigarettesPerPacket = prefs.getInt('cigarettesPerPacket') ?? 0;
      _friendsEnabled = prefs.getBool('friendsEnabled') ?? true;
    });
  }

  Future<void> _updateCalculations() async {
    if (lastSmoked != null) {
      double saved = await Calculations.calculateMoneySaved(lastSmoked!);
      int avoided = await Calculations.calculateCigarettesAvoided(lastSmoked!,packetsPerWeek,cigarettesPerPacket,);


      setState(() {
        moneySaved = saved;
        cigarettesAvoided = avoided;
      });
    }
  }

  void _startCounter() {
    _addcigarettes();
    setState(() {
      lastSmoked = DateTime.now();
      isFirstTime = false;
    });
    _saveLastSmoked();
    _updateCalculations();
  }

  Future<void> _saveLastSmoked() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastSmoked', lastSmoked!.toIso8601String());
    await prefs.setBool('hasStarted', true);
  }

  @override
  Widget build(BuildContext context) {
    final duration = lastSmoked != null
        ? DateTime.now().difference(lastSmoked!) : Duration();

    final timeComponents = {
      'days': duration.inDays,
      'hours': duration.inHours % 24,
      'minutes': duration.inMinutes % 60
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Smoke Tracker'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'config') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ConfigScreen()),
                ).then((_) => _initializeData());
              } else if (value == 'backup') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BackupScreen(
                      onBackupPressed: () => _shareJson(),
                  )),
                );
              } else if (value == 'about') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutScreen()),
                );
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'config',
                child: Text('Config'),
              ),
              PopupMenuItem(
                value: 'backup',
                child: Text('Backup'),
              ),
              PopupMenuItem(
                value: 'about',
                child: Text('About'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Smoke Tracker',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              formatTime(timeComponents),
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.homeMoneySavedText(
                moneySaved.toStringAsFixed(2),
              ),
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(
              'Today smoked cigarette: $_cigarettesPerDayCount',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            if (isFirstTime)
              ElevatedButton(
                onPressed: _startCounter,
                child: Text(AppLocalizations.of(context)!.homeStartCounterText),
              )
            else
              ElevatedButton(
                onPressed: _startCounter,
                child: Text(AppLocalizations.of(context)!.homeRestartProgressText),
              ),
            SizedBox(height: 20),
            Text(
              'L\'ultima sigaretta è stata fumata \n $lastSmoked. \n Oggi hai fumato $_cigarettesPerDayCount sigarette',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavigationBar(currentIndex: 0),
    );
  }
}
