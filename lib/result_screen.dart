import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_creator/calcul_password_service.dart';

class ResultScreen extends StatefulWidget {
  final String password;
  final int numMin;
  final int numMaj;
  final int numNum;
  final int numCharSpe;
  final int numTotal;
  const ResultScreen({
    super.key,
    required this.password,
    required this.numCharSpe,
    required this.numMaj,
    required this.numMin,
    required this.numNum,
    required this.numTotal,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _copied = false;
  late String _password;

  @override
  void initState() {
    super.initState();
    _password = widget.password;
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: _password));

    setState(() {
      _copied = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _copied = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
        title: const Text('Création'),
        leading: IconButton(
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          icon: Icon(Icons.home, color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Ton mot de passe :",
              style: TextStyle(color: Colors.lightGreenAccent, fontSize: 25),
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                _password,
                style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 4,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _copyToClipboard,
              icon: Icon(_copied ? Icons.check : Icons.copy),
              label: Text(_copied ? 'Copié !' : 'Copier'),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                final generator = CalculPasswordService();
                setState(() {
                  _password = generator.generatePassword(
                    widget.numMin,
                    widget.numMaj,
                    widget.numNum,
                    widget.numCharSpe,
                    widget.numTotal,
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Nouveau mot de passe généré !'),
                    duration: Duration(seconds: 1),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text("Regénérer"),
            ),
          ],
        ),
      ),
    );
  }
}
