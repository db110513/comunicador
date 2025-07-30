import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class ObjectesQuotidians extends StatelessWidget {
  ObjectesQuotidians({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {'id': 7107, 'text': 'FOTO'},
    {'id': 5938, 'text': 'CAMPANA'},
    {'id': 37948, 'text': 'CAPSA'},
    {'id': 37103, 'text': 'RODA'},
    {'id': 2837, 'text': 'PINZELL'},
    {'id': 4870, 'text': 'PINTURA'},
    {'id': 2475, 'text': 'MOTXILLA'},
    {'id': 2931, 'text': 'MALETA'},
    {},
    {},
    {'id': 2845, 'text': 'DIARI'},
    {'id': 8153, 'text': 'CLAU'},
    {'id': 5898, 'text': 'AGENDA'},
    {'id': 2364, 'text': 'CONTE'},
    {'id': 6138, 'text': 'LLANTERNA'},
    {'id': 8466, 'text': 'PINÇA'},
    {'id': 2593, 'text': 'TOVALLOLA'},
    {
      'id': 7127,
      'text': 'EINES DE TREBALL',
      'navega': EinesTreball(),
    },
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
                  childAspectRatio: .8,
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