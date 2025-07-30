import 'package:flutter/foundation.dart';
import 'package:comunicador/exports.dart';

class FraseModel extends ChangeNotifier {
  final List<Pictograma> _frase = [];

  List<Pictograma> get frase => List.unmodifiable(_frase);

  void addWord(Pictograma pictograma) {
    _frase.add(pictograma);
    notifyListeners();
  }

  void deleteLast() {
    if (_frase.isNotEmpty) {
      _frase.removeLast();
      notifyListeners();
    }
  }

  void clearAll() {
    _frase.clear();
    notifyListeners();
  }

  String get sentenceText {
    return _frase.map((p) => p.text).join(' ');
  }
}