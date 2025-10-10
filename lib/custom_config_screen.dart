import 'package:flutter/material.dart';
import 'package:password_creator/calcul_password_service.dart';
import 'package:password_creator/waiting_screen.dart';

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
  void _generatePassword() {
    // Validation
    final total = numTotal;
    final sommeMinimums = numMaj + numMin + numNum + numCharSpe;

    if (total < sommeMinimums) {
      // Affiche une erreur
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Le total ($total) doit être ≥ à la somme des minimums ($sommeMinimums)',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (total < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Le mot de passe doit contenir au moins 4 caractères'),
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
        title: const Text('Configuration'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Valeur minimum pour chaque type',
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            // Champ : Nombre total
            _buildNumberField(
              label: 'Nombre total de caractères',
              value: numTotal,
              onChanged: (value) => setState(() => numTotal = value),
            ),

            // Champ : Caractères spéciaux
            _buildNumberField(
              label: 'Nombre de caractères spéciaux',
              value: numCharSpe,
              onChanged: (value) => setState(() => numCharSpe = value),
            ),

            // Champ : Majuscules
            _buildNumberField(
              label: 'Nombre de majuscules',
              value: numMaj,
              onChanged: (value) => setState(() => numMaj = value),
            ),

            // Champ : Minuscules
            _buildNumberField(
              label: 'Nombre de minuscules',
              value: numMin,
              onChanged: (value) => setState(() => numMin = value),
            ),

            // Champ : Chiffres
            _buildNumberField(
              label: 'Nombre de chiffres',
              value: numNum,
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
              child: const Text('Générer', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNumberField({
    required String label,
    required int value,
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
              controller: TextEditingController(text: value.toString()),
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
