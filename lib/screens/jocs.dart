import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Jocs extends StatelessWidget {
  Jocs({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {},
    {},
    {},
    {'id': 8119, 'text': 'EXPERIMENT'},
    {'text': 'THOMAS', 'localImage': 'assets/meusPictogrames/thomas.png'},
    {'text': 'LITTLE EINSTEIN', 'localImage': 'assets/meusPictogrames/lilEinstein.png'},
    {'id': 6981, 'text': 'COTXE'},
    {'id': 2263, 'text': 'AUTOBÚS'},
    {'id': 2603, 'text': 'TREN'},
    {'text': 'CLICK', 'localImage': 'assets/meusPictogrames/click.png'},
    {'id': 14544, 'text': 'CUBS'},
    {'id': 8508, 'text': 'LEGO'},
    {'id': 2277, 'text': 'BICICLETA'},
    {'id': 6956, 'text': 'CAMIÓ'},
    {'text': 'TRINEO', 'localImage': 'assets/meusPictogrames/trineo.png'},
    {'text': 'BOSSA DE PA', 'localImage': 'assets/meusPictogrames/bossaPa.png'},
    {'text': 'ENGRANATGE', 'localImage': 'assets/meusPictogrames/engranatge.png'},
    {'text': 'PUZZLE', 'localImage': 'assets/meusPictogrames/puzzle.png'},
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