import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_robust_creator/calcul_password_service.dart';
import 'package:password_robust_creator/custom_config_screen.dart';
import 'package:password_robust_creator/l10n/app_localizations.dart';
import 'package:password_robust_creator/waiting_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor:
          Colors.transparent, // Rendre la barre de statut transparente
      statusBarIconBrightness: Brightness.light, // Icônes de statut claires
      systemNavigationBarColor:
          Colors.transparent, // Rendre la barre de navigation transparente
      systemNavigationBarIconBrightness:
          Brightness.light, // Icônes de navigation claires
      systemNavigationBarDividerColor: Colors
          .transparent, // Rendre la ligne de séparation transparente (remplace l'API obsolète)
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Password Creator',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('fr')],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 20, 124, 4),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
        title: Text(AppLocalizations.of(context)!.welcome),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 15,
              children: [
                Text(
                  AppLocalizations.of(context)!.choosePasswordType,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: Colors.lightGreenAccent),
                ),
                SizedBox(height: 10),
        
                ElevatedButton(
                  onPressed: () {
                    final generator = CalculPasswordService();
        
                    final password = generator.generateDefaultPassword();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WaitingScreen(
                          password: password,
                          numCharSpe: 1,
                          numMaj: 1,
                          numMin: 1,
                          numNum: 1,
                          numTotal: 10,
                        ),
                      ),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.defaultButton),
                ),
        
                Text(
                  AppLocalizations.of(context)!.defaultDescription,
                  style: TextStyle(
                    color: Colors.green.shade700,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CustomConfigScreen(),
                      ),
                    );
                  },
                  child: Text(AppLocalizations.of(context)!.customButton),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
