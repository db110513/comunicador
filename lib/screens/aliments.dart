import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Aliments extends StatelessWidget {
  Aliments({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {
      'id': 6244,
      'text': 'VERDURA',
      'navega': Verdura(),
    },
    {
      'localImage': 'assets/meusPictogrames/carnPeix.png',
      'text': 'CARN I PEIX',
      'navega': Carn(),
    },
    {
      'id': 8652,
      'text': 'PÀ I PASTA',
      'navega': PaPasta(),
    },
    {
      'localImage': 'assets/meusPictogrames/dolc.png',
      'text': 'DOLÇ',
      'navega': Dolc(),
    },
    {
      'id': 4653,
      'text': 'FRUITA',
      'navega': Fruita(),
    },
    {'localImage': 'assets/meusPictogrames/postre.png', 'text': 'POSTRE'},
    {
      'id': 4575,
      'text': 'BEGUDA',
      'navega': Beguda(),
    },
    {'id': 4626, 'text': 'ESMORZAR'},
    {'localImage': 'assets/meusPictogrames/dinar.png', 'text': 'DINAR'},
    {'id': 4695, 'text': 'BERENAR'},
    {'id': 4592, 'text': 'SOPAR'},
    {},
    {'id': 5509, 'text': 'MAIONESA'},
    {'id': 17008, 'text': 'SALSA TOMÀQUET'},
    {'id': 2362, 'text': 'CULLERA'},
    {'id': 4931, 'text': 'GANIVET'},
    {'id': 2588, 'text': 'FORQUILLA'},
    {'id': 2610, 'text': 'GOT'},
    {'id': 16857, 'text': 'PLAT'},
    {'id': 2569, 'text': 'TOVALLÓ'},
    {'id': 3270, 'text': 'EXPRIMIDOR'},
  ];

  Widget build(BuildContext context) {
    final fraseModel = context.watch<FraseModel>();
    final frasePictogrames = fraseModel.frase;

    const Color buttonBgColor = Colors.white;

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
                  crossAxisCount: 7,
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

                  if (catData.containsKey('navega')) {
                    return PictogramButton(
                      pictogram: currentPictogram,
                      buttonColor: buttonBgColor,
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => catData['navega']),
                        );
                      },
                    );
                  }

                  final bool noShowText = currentPictogram.text != 'POSTRE';

                  return PictogramButton(
                    pictogram: currentPictogram,
                    buttonColor: buttonBgColor,
                    showText: noShowText,
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
