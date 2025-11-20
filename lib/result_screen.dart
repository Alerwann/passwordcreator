import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_robust_creator/calcul_password_service.dart';
import 'package:password_robust_creator/l10n/app_localizations.dart';
import 'package:password_robust_creator/waiting_screen.dart';

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
    try {
      await Clipboard.setData(ClipboardData(text: _password));

      setState(() {
        _copied = true;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Le mot de passe a été copié'),
            duration: Duration(milliseconds: 750),
            backgroundColor: Colors.lightGreen,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _copied = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Le mot de passe n'a pu être copié"),
            duration: Duration(milliseconds: 750),
            backgroundColor: const Color.fromARGB(255, 195, 74, 74),
          ),
        );
      }
    }

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _copied = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.black,
        title: Text(AppLocalizations.of(context)!.resultTitle),
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
              AppLocalizations.of(context)!.yourPassword,
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
              label: Text(
                _copied
                    ? AppLocalizations.of(context)!.copyButton
                    : AppLocalizations.of(context)!.copiedButton,
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                final generator = CalculPasswordService();

                _password = generator.generatePassword(
                  widget.numMin,
                  widget.numMaj,
                  widget.numNum,
                  widget.numCharSpe,
                  widget.numTotal,
                );

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WaitingScreen(
                      password: _password,
                      numMin: widget.numMin,
                      numMaj: widget.numMaj,
                      numNum: widget.numNum,
                      numCharSpe: widget.numCharSpe,
                      numTotal: widget.numTotal,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.refresh),
              label: Text(AppLocalizations.of(context)!.regenerateButton),
            ),
          ],
        ),
      ),
    );
  }
}
