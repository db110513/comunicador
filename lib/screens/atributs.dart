import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Atributs extends StatelessWidget {
  Atributs({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {},
    {'text': 'FUNCIONA', 'localImage': 'assets/meusPictogrames/funciona.png'},
    {'text': 'NO FUNCIONA', 'localImage': 'assets/meusPictogrames/noFunciona.png'},
    {'id': 4660, 'text': 'GUAPO'},
    {'id': 25253, 'text': 'MULLAT'},
    {'id': 4750, 'text': 'BRUT'},
    {'id': 4680, 'text': 'NET'},
    {'id': 7157, 'text': 'SOROLL'},
    {'id': 4736, 'text': 'TRENCAT'},
    {'id': 8027, 'text': 'APAGADA'},
    {'id': 8103, 'text': 'ENCESA'},
    {'id': 6006, 'text': 'GIRAR'},
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
                  crossAxisCount: 4,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 18,
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