import 'package:flutter/material.dart';
import 'package:password_robust_creator/calcul_password_service.dart';
import 'package:password_robust_creator/waiting_screen.dart';

import 'l10n/app_localizations.dart';

class CustomConfigScreen extends StatefulWidget {
  const CustomConfigScreen({super.key});

  @override
  State<CustomConfigScreen> createState() => _CustomConfigScreenState();
}

class _CustomConfigScreenState extends State<CustomConfigScreen> {
  int numTotal = 12;
  int numMaj = 2;
  int numCharSpe = 1;
  int numNum = 2;
  int numMin = 2;

  // Déclare les controllers ici
  late final TextEditingController _totalController;
  late final TextEditingController _charSpeController;
  late final TextEditingController _majController;
  late final TextEditingController _minController;
  late final TextEditingController _numController;

  @override
  void initState() {
    super.initState();
    // Initialise les controllers une seule fois
    _totalController = TextEditingController(text: numTotal.toString());
    _charSpeController = TextEditingController(text: numCharSpe.toString());
    _majController = TextEditingController(text: numMaj.toString());
    _minController = TextEditingController(text: numMin.toString());
    _numController = TextEditingController(text: numNum.toString());
  }

  @override
  void dispose() {
    // Libère la mémoire
    _totalController.dispose();
    _charSpeController.dispose();
    _majController.dispose();
    _minController.dispose();
    _numController.dispose();
    super.dispose();
  }

  void _generatePassword() {
    // Validation
    final total = numTotal;
    final sommeMinimums = numMaj + numMin + numNum + numCharSpe;

    if (total < sommeMinimums) {
      // Affiche une erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.errorTotalTooLow(total, sommeMinimums)
          
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (total < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.errorMinimumLength),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (total > 30) {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(AppLocalizations.of(context)!.errorMaxLength),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    // Instance locale ici
    final generator = CalculPasswordService();
    final password = generator.generatePassword(
      numMin,
      numMaj,
      numNum,
      numCharSpe,
      numTotal,
    );

    // Navigation vers Matrix
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WaitingScreen(
          password: password,
          numCharSpe: numCharSpe,
          numMaj: numMaj,
          numMin: numMin,
          numNum: numNum,
          numTotal: numTotal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
        title: Text(AppLocalizations.of(context)!.configurationTitle),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                AppLocalizations.of(context)!.minimumValuesLabel,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),

              // Champ : Nombre total
              _buildNumberField(
                label: AppLocalizations.of(context)!.totalCharactersLabel,
                controller: _totalController,
                onChanged: (value) => setState(() => numTotal = value),
              ),

              // Champ : Caractères spéciaux
              _buildNumberField(
                label: AppLocalizations.of(context)!.specialCharactersLabel,
                controller: _charSpeController,
                onChanged: (value) => setState(() => numCharSpe = value),
              ),

              // Champ : Majuscules
              _buildNumberField(
                label: AppLocalizations.of(context)!.uppercaseLabel,
                controller: _majController,
                onChanged: (value) => setState(() => numMaj = value),
              ),

              // Champ : Minuscules
              _buildNumberField(
                label: AppLocalizations.of(context)!.lowercaseLabel,
                controller: _minController,
                onChanged: (value) => setState(() => numMin = value),
              ),

              // Champ : Chiffres
              _buildNumberField(
                label: AppLocalizations.of(context)!.digitsLabel,
                controller: _numController,
                onChanged: (value) => setState(() => numNum = value),
              ),

              const SizedBox(height: 40),

              // Bouton Valider
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                ),
                onPressed: _generatePassword,
                child:  Text(
                  AppLocalizations.of(context)!.generateButton, style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNumberField({
    required String label,
    required TextEditingController controller,
    required Function(int) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(color: Colors.green, fontSize: 16),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.green[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),

              onChanged: (text) {
                final newValue = int.tryParse(text);
                if (newValue != null) {
                  onChanged(newValue);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
