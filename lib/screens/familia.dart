import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Familia extends StatelessWidget {
  Familia({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {'text': 'TONI', 'localImage': 'assets/meusPictogrames/parking.png'},
    {'text': 'NÚRIA', 'localImage': 'assets/meusPictogrames/parking.png'},
    {'text': 'JOSEP MARIA', 'localImage': 'assets/meusPictogrames/parking.png'},
    {'text': 'PALOMA', 'localImage': 'assets/meusPictogrames/parking.png'},
    {'text': 'MIREIA', 'localImage': 'assets/meusPictogrames/parking.png'},
    {'text': 'JUAN', 'localImage': 'assets/meusPictogrames/parking.png'},
    {'text': 'PEPE', 'localImage': 'assets/meusPictogrames/parking.png'},
    {'text': 'ANA', 'localImage': 'assets/meusPictogrames/parking.png'},
    {},
    {'text': 'JACK', 'localImage': 'assets/meusPictogrames/parking.png'},
    {'text': 'MARIONA', 'localImage': 'assets/meusPictogrames/parking.png'},
    {'text': 'LAURA', 'localImage': 'assets/meusPictogrames/parking.png'},
    {'text': 'JOSEP', 'localImage': 'assets/meusPictogrames/parking.png'},
    {'text': 'AITANA', 'localImage': 'assets/meusPictogrames/parking.png'},
    {'text': 'PAU', 'localImage': 'assets/meusPictogrames/parking.png'},
    {'text': 'LARA', 'localImage': 'assets/meusPictogrames/parking.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final fraseModel = context.watch<FraseModel>();
    final frasePictogrames = fraseModel.frase;

    const Color buttonBgColor = Colors.white;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4E5),
      body: Column(
        children: [
          Frase(
            sentenceWords: frasePictogrames,
            onPopPressed: () => Navigator.pop(context),
            onHomePressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            onDeleteLast: () => fraseModel.deleteLast(),
            onClearAll: () => fraseModel.clearAll(),
            onPlaySentence: () async {
              await TTSService().speak(fraseModel.sentenceText);
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  childAspectRatio: 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: pictogramesData.length,
                itemBuilder: (context, index) {
                  final catData = pictogramesData[index];

                  if (catData.isEmpty || catData['text'] == null) {
                    return const SizedBox.shrink();
                  }

                  final Pictograma currentPictogram = Pictograma(
                    id: catData['id'],
                    text: catData['text']!,
                    localImage: catData['localImage'],
                  );

                  return PictogramButton(
                    pictogram: currentPictogram,
                    buttonColor: buttonBgColor,
                    onTap: () {
                      fraseModel.addWord(currentPictogram);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}