import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class AparellsMobles extends StatelessWidget {
  AparellsMobles({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {'id': 2611, 'text': 'FINESTRA'},
    {'id': 2518, 'text': 'PERSIANA'},
    {'id': 2357, 'text': 'CORTINES'},
    {'id': 37438, 'text': 'ALTAVEU'},
    {'id': 38255, 'text': 'CABLE'},
    {'id': 28099, 'text': 'IPAD'},
    {'id': 11376, 'text': 'CADIRA'},
    {'id': 11302, 'text': 'TAULA'},
    {'id': 2304, 'text': 'LLIT'},
    {},
    {'id': 31819, 'text': 'CARREGADOR'},
    {'id': 7190, 'text': 'ORDINADOR'},
    {'id': 3244, 'text': 'PORTA'},
    {'id': 2571, 'text': 'SOFÀ'},
    {'id': 24169, 'text': 'MECEDORA'},
    {'id': 6212, 'text': 'CADIRA DE RODES'},
    {'id': 6228, 'text': 'ESTENEDOR'},
    {'id': 8202, 'text': 'PROJECTOR'},
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
                  crossAxisCount: 6,
                  childAspectRatio: 0.8,
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
