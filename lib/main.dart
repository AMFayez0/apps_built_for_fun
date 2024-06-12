import 'package:app_built_for_fun/navigation/home_page.dart';
import 'package:app_built_for_fun/services/http_services.dart';
import 'package:app_built_for_fun/services/loacl_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await setupServices();
  runApp(const MyApp());
}

Future<void> setupServices() async {
  GetIt.instance.registerSingleton<HTTPService>(
    HTTPService(),
  );
  GetIt.instance.registerSingleton<LocalStorage>(
    LocalStorage(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'APP BUILT FOR FUN',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
          textTheme: GoogleFonts.quattrocentoSansTextTheme(),
        ),
        home: const HomePage(),
      ),
    );
  }
}
