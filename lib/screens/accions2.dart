import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Accions2 extends StatelessWidget {
  Accions2({Key? key}) : super(key: key);

  List<Map<String, dynamic>> get pictogramesData => [
    {'text': 'ESPERAR', 'localImage': 'assets/meusPictogrames/esperar.png'},
    {'id': 2381, 'text': 'ESCOLTAR'},
    {'id': 8103, 'text': 'ENCENDRE LA LLUM'},
    {'id': 8027, 'text': 'APAGAR LA LLUM'},
    {'id': 5361, 'text': 'AFAITAR'},
    {'id': 2371, 'text': 'DUTXAR-ME'},
    {'id': 2369, 'text': 'DORMIR'},
    {'id': 22082, 'text': 'REGAR'},
    {'id': 2828, 'text': 'PLANTAR'},
    {'id': 8680, 'text': 'RECOLLIR'},
    {'text': 'ENGANXAR', 'localImage': 'assets/meusPictogrames/enganxar.png'},
    {'id': 29670, 'text': 'GUARNIR'},
    {'id': 9802, 'text': 'ENCENDRE'},
    {'id': 20093, 'text': 'APAGAR'},
    {'text': 'PINTAR', 'localImage': 'assets/meusPictogrames/pintar.png'},
    {'id': 8988, 'text': 'DESPERTAR'},
    {'text': 'AGAFAR', 'localImage': 'assets/meusPictogrames/agafar.png'},
    {'id': 34349, 'text': 'PEGAR'},
    {'id': 8986, 'text': 'COMPRAR'},
    {'id': 5480, 'text': 'FER PESSIGOLLES'},
    {'id': 9032, 'text': 'TRENCAR'},
    {'id': 6910, 'text': 'ARREGLAR'},
    {'id': 5496, 'text': 'RENTAR LA ROBA'},
    {'id': 5593, 'text': 'ESTENDRE LA ROBA'},
    {'id': 7124, 'text': 'M\'AGRADA'},
    {'id': 6155, 'text': 'NO M\'AGRADA'},
    {'text': 'ESCOLLIR', 'localImage': 'assets/meusPictogrames/escollir.png'},
  ];

  Widget build(BuildContext context) {
    final fraseModel = context.watch<FraseModel>();
    final frasePictogrames = fraseModel.frase;

    const Color colorPictos = Color(0xFFc8f5c8);

    return Scaffold(
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
                  crossAxisCount: 9,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
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
                    buttonColor: colorPictos,
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