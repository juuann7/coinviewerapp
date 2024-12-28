import 'dart:convert';
import 'package:coinviewer/models/app_config.dart';
import 'package:coinviewer/pages/HomePage.dart';
import 'package:coinviewer/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadConfig();
  registerHTTPService();
  await GetIt.instance.get<HTTPService>().get("/coins/bitcoin");
  runApp(const MyApp());
}

Future<void> loadConfig() async {
  String configContent = await rootBundle.loadString('assets/config/main.json');
  Map<String, dynamic> configData = jsonDecode(configContent);
  GetIt.instance.registerSingleton<AppConfig>(
    AppConfig(
      COIN_API_BASE_URL: configData["COIN_API_BASE_URL"],
    ),
  );
}

void registerHTTPService() {
  GetIt.instance.registerSingleton<HTTPService>(
    HTTPService(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coin Viewer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromRGBO(44, 39, 39, 1),
      ),
      home: HomePage(),
    );
  }
}
