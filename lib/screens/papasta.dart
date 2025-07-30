import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class PaPasta extends StatelessWidget {
  PaPasta({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {'id': 3005, 'text': 'CANELONS'},
    {'id': 9051, 'text': 'LASANYA'},
    {'id': 2455, 'text': 'MACARRONS'},
    {'id': 2383, 'text': 'ESPAGUETIS'},
    {'text': 'TABULÉ', 'localImage': 'assets/meusPictogrames/tabule.png'},
    {'id': 27757, 'text': 'FIDEUÀ'},
    {'text': 'PÀ RATLLAT', 'localImage': 'assets/meusPictogrames/paRatllat.png'},
    {'id': 2865, 'text': 'ENTREPÀ', 'navega': Entrepa()},
    {'id': 2527, 'text': 'PIZZA'},
    {'text': 'ROLLITO', 'localImage': 'assets/meusPictogrames/rollito.png'},
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

                  if (catData.containsKey('navega')) {
                    return PictogramButton(
                      pictogram: currentPictogram,
                      buttonColor: buttonBgColor,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => catData['navega']),
                        );
                      },
                    );
                  }

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