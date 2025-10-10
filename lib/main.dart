import 'package:flutter/material.dart';
import 'package:password_creator/calcul_password_service.dart';
import 'package:password_creator/custom_config_screen.dart';
import 'package:password_creator/waiting_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Creator',
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
        title: const Text('WELCOME'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 15,
            children: [
              Text(
                "Choisi ton type de mot de passe :",
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
                child: Text("Par défaut"),
              ),

              Text(
                '(10 caractères dont au moins 1 majuscule, 1 minuscule, 1 chiffre, 1 spécial)',
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
                child: Text("Personnalisé"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
