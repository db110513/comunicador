import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Carn extends StatelessWidget {
  Carn({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {'id': 2316, 'text': 'CARN'},
    {'id': 3280, 'text': 'LLONGANISSA'},
    {'id': 3249, 'text': 'MANDONGUILLES'},
    {'id': 3020, 'text': 'CROQUETES'},
    {'id': 26122, 'text': 'HAMBURGUESA'},
    {'id': 34039, 'text': 'OUS'},
    {'id': 2428, 'text': 'OU FERRAT'},
    {'id': 7132, 'text': 'OU DUR'},
    {'id': 4966, 'text': 'TRUITA'},
    {'id': 4952, 'text': 'POLLASTRE'},
    {'id': 2520, 'text': 'PEIX'},
    {'id': 6653, 'text': 'BASTONETS DE PEIX'},
    {'id': 16759, 'text': 'LLAUNA DE TONYINA'},
    {'id': 5467, 'text': 'ESTOFAT'},
    {}
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
