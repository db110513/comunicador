import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Llocs2 extends StatelessWidget {
  Llocs2({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {'id': 3099, 'text': 'ESTACIÓ DE TREN'},
    {'id': 2472, 'text': 'METRO'},
    {'id': 2260, 'text': 'ASCENSOR'},
    {'text': 'CENTRE COMERCIAL', 'localImage': 'assets/meusPictogrames/centreComercial.png'},
    {'id': 2826, 'text': 'PLATJA'},
    {'id': 4646, 'text': 'FAR'},
    {'id': 16975, 'text': 'TALLER'},
    {'text': 'PARC SAMÀ', 'localImage': 'assets/meusPictogrames/parcSama.png'},
    {'id': 5087, 'text': 'PISTA D\'ESQUÍ'},
    {'id': 8972, 'text': 'TÚNEL'},
    {'text': 'SALOU', 'localImage': 'assets/meusPictogrames/salou.png'},
    {'text': 'PORT AVENTURA', 'localImage': 'assets/meusPictogrames/portAventura.png'},
    {'text': 'VIENA', 'localImage': 'assets/meusPictogrames/viena.png'},
    {'text': 'McDONALD\'S', 'localImage': 'assets/meusPictogrames/mac.png'},
    {'id': 6566, 'text': 'MUSEU'},
    {'id': 3337, 'text': 'GRANJA'},
    {'id': 11319, 'text': 'TEATRE'},
    {},
    {'text': 'PARKING', 'localImage': 'assets/meusPictogrames/parking.png'},
    {'id': 2299, 'text': 'CARRER'},
    {'id': 36291, 'text': 'ESTACIÓ AUTOBÚS'},
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