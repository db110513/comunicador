import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class FaMal extends StatelessWidget {
  FaMal({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {'id': 28785, 'text': 'MAL D\'ESQUENA'},
    {'text': 'MAL DE PANXA', 'localImage': 'assets/meusPictogrames/malPanxa.png'},
    {'text': 'MAL D\'ORELLA', 'localImage': 'assets/meusPictogrames/malOrella.png'},
    {'id': 28761, 'text': 'MAL DE GOLA'},
    {'id': 28773, 'text': 'MAL DE BRAÇ'},
    {'id': 28753, 'text': 'MAL DE CAP'},
    {'id': 35809, 'text': 'MAL AL PEU'},
    {'id': 37532, 'text': 'MAL A LA MÀ'},
    {'text': 'MAL AL DIT', 'localImage': 'assets/meusPictogrames/malDit.png'},
    {'text': 'MAL AL FER PIPÍ', 'localImage': 'assets/meusPictogrames/malFerPipi.png'},
  ];

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