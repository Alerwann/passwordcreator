import 'dart:math';

class CalculPasswordService {
  final String _charMin = "abcdefghijklmnopqrstuvwxyz";
  final String _charMaj = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  final String _charNum = "0123456789";
  final String _charSpe = "?.:;,+-*/@\"";

  String get charGlobal => _charMin + _charMaj + _charNum + _charSpe;

  void _randomChar(List<String> list, String charString, int numOfCaracter) {
    int lengthChar = charString.length;
    for (var j = 0; j < numOfCaracter; j++) {
      int index = Random().nextInt(lengthChar);
      list.add(charString[index]);
    }
  }

  void _shuffleList(List<String> list) {
    for (var i = list.length - 1; i > 0; i--) {
      int j = Random().nextInt(i + 1);
      String temp = list[i];
      list[i] = list[j];
      list[j] = temp;
    }
  }

  String generatePassword(
    int numMin,
    int numMaj,
    int numNum,
    int numSpe,
    int numTotal,
  ) {
    List<String> passwordList = [];

    _randomChar(passwordList, _charMin, numMin);
    _randomChar(passwordList, _charMaj, numMaj);
    _randomChar(passwordList, _charNum, numNum);
    _randomChar(passwordList, _charSpe, numSpe);

    int remaining = numTotal - (numMin + numMaj + numNum + numSpe);
    if (remaining > 0) {
      _randomChar(passwordList, charGlobal, remaining);
    }

    _shuffleList(passwordList);

    return passwordList.join('');
  }

  String generateDefaultPassword() {
    return generatePassword(1, 1, 1, 1, 10);
  }
}
