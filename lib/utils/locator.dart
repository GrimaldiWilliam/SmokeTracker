import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

final getIt = GetIt.instance;

const String ndjsonFilePathInstanceName = 'ndjsonFilePath';

Future<void> setupLocator() async {
  // Registra il percorso del file come singleton
  // Questa operazione è asincrona, quindi deve essere attesa
  final directory = await getApplicationDocumentsDirectory();
  final filePath = '${directory.path}/smoking_data.json'; // Il tuo nome file
  getIt.registerSingleton<String>(filePath, instanceName: 'filePath');

  print('Locator setup complete. FilePath: $filePath');
}