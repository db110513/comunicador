import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/frase_model.dart';
import 'screens/home.dart';
import 'services/tts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TTSService().initTTS();
  runApp(
    ChangeNotifierProvider(
      create: (_) => FraseModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home()
      ),
    ),
  );
}