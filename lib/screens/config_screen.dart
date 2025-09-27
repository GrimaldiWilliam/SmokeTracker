import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import '/l10n/app_localizations.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  _ConfigScreenState createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  bool _friendsEnabled = false;
  final _packetsPerWeekController = TextEditingController();
  final _cigarettesPerPacketController = TextEditingController();
  List<Map<String, dynamic>> _priceHistory = [];
  DateTime? _counterStartDate;

  @override
  void initState() {
    super.initState();
    _loadConfig();
  }

  Future<void> _loadConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _friendsEnabled = prefs.getBool('friendsEnabled') ?? false;
      _packetsPerWeekController.text = prefs.getInt('packetsPerWeek')?.toString() ?? '';
      _cigarettesPerPacketController.text = prefs.getInt('cigarettesPerPacket')?.toString() ?? '';
      String? priceHistoryJson = prefs.getString('priceHistory');
      _priceHistory = List<Map<String, dynamic>>.from(jsonDecode(priceHistoryJson!));
          String? startDate = prefs.getString('lastSmoked');
      _counterStartDate = DateTime.parse(startDate!);
    
      // Ensure the first price history date matches the counter start date
      if (_counterStartDate != null && _priceHistory.isNotEmpty) {
        _priceHistory[0]['date'] = _counterStartDate!.toIso8601String();
      }
    });
  }

  Future<void> _saveConfig() async {
    if (_packetsPerWeekController.text.isEmpty ||
        _cigarettesPerPacketController.text.isEmpty ||
        _priceHistory.any((entry) => entry['price'].toString().isEmpty || double.tryParse(entry['price'].toString()) == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.configSnackBarValidNumber)),
      );
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('friendsEnabled', _friendsEnabled);
    await prefs.setInt('packetsPerWeek', int.parse(_packetsPerWeekController.text));
    await prefs.setInt('cigarettesPerPacket', int.parse(_cigarettesPerPacketController.text));

    List<Map<String, dynamic>> validatedPriceHistory = _priceHistory.map((entry) {
      return {
        'price': double.tryParse(entry['price'].toString()) ?? 0.0,
        'date': entry['date'],
      };
    }).toList();

    await prefs.setString('priceHistory', jsonEncode(validatedPriceHistory));
    if (_counterStartDate != null) {
      await prefs.setString('lastSmoked', _counterStartDate!.toIso8601String());
    }

    Navigator.pop(context, true);
  }

  void _addPrice() {
    setState(() {
      _priceHistory.add({
        'price': '',
        'date': DateTime.now().toIso8601String(),
      });
    });
  }

  void _removePrice(int index) {
    setState(() {
      _priceHistory.removeAt(index);
    });
  }

  void _updatePrice(int index, String value) {
    _priceHistory[index]['price'] = value;
  }

  Future<void> _selectCounterStartDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _counterStartDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_counterStartDate ?? DateTime.now()),
      );

      if (pickedTime != null) {
        setState(() {
          _counterStartDate = DateTime(pickedDate.year, pickedDate.month, pickedDate.day, pickedTime.hour, pickedTime.minute);
          if (_priceHistory.isNotEmpty) {
            _priceHistory[0]['date'] = _counterStartDate!.toIso8601String();
          }
        });
      }
    }
  }

  void _confirmFriendsEnable(BuildContext context, bool value) {
    if (value) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(AppLocalizations.of(context)!.configDialogEnableFriendsTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.configDialogEnableFriendsDataText,
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(context)!.configDialogEnableFriendsSourceCodeText,
                textAlign: TextAlign.justify,
              ),
              GestureDetector(
                onTap: () => launchUrl(Uri.parse('https://codeberg.org/retiolus/ExHale/src/branch/main/api')),
                child: Text(
                  'https://codeberg.org/retiolus/ExHale/src/branch/main/api',
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _friendsEnabled = value;
                });
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.confirm),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        _friendsEnabled = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.configScreenTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text(AppLocalizations.of(context)!.configOptionEnableFriendsText),
              value: _friendsEnabled,
              onChanged: (value) => _confirmFriendsEnable(context, value),
            ),
            TextField(
              controller: _packetsPerWeekController,
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.configOptionPacketsPerWeekText),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _cigarettesPerPacketController,
              decoration: InputDecoration(labelText: AppLocalizations.of(context)!.configOptionCigarettesPerPacketText),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.configOptionCounterStartDateText, style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _counterStartDate != null
                        ? DateFormat.yMMMMd(Localizations.localeOf(context).toString())
                            .add_Hm()
                            .format(_counterStartDate!.toLocal())
                        : AppLocalizations.of(context)!.configOptionCounterStartDateSelectText,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectCounterStartDateTime(context),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.configOptionPriceHistoryText, style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: _priceHistory.length,
                itemBuilder: (context, index) {
                  final priceEntry = _priceHistory[index];
                  final controller = TextEditingController(text: priceEntry['price'].toString());
                  controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
                  return ListTile(
                    title: TextField(
                      decoration: InputDecoration(labelText: AppLocalizations.of(context)!.configOptionPriceHistoryPriceText),
                      keyboardType: TextInputType.number,
                      controller: controller,
                      onChanged: (value) => _updatePrice(index, value),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd(Localizations.localeOf(context).toString())
                        .add_Hm()
                        .format(DateTime.parse(priceEntry['date']).toLocal()),
                    ),
                    trailing: index == 0
                        ? null
                        : IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _removePrice(index),
                          ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addPrice,
              child: Text(AppLocalizations.of(context)!.configButtonAddPriceText),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveConfig,
              child: Text(AppLocalizations.of(context)!.save),
            ),
          ],
        ),
      ),
    );
  }
}
