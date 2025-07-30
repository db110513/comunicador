import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Temps extends StatelessWidget {
  Temps({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {'id': 22633, 'text': 'ESTONA'},
    {
      'id': 7022,
      'text': 'DIA',
      'navega': Dia(),
    },
    {'text': 'ARA', 'localImage': 'assets/meusPictogrames/ara.png'},
    {},
    {'id': 2798, 'text': 'SOL'},
    {'id': 2883, 'text': 'NÚVOL'},
    {'id': 6926, 'text': 'AHIR'},
    {'id': 7131, 'text': 'AVUI'},
    {'id': 7152, 'text': 'DEMÀ'},
    {},
    {'id': 7259, 'text': 'VENT'},
    {'text': 'PLUJA', 'localImage': 'assets/meusPictogrames/pluja.png'},
    {'id': 3166, 'text': 'VACANCES'},
    {'id': 24633, 'text': 'ESPERA'},
    {'text': 'ÉS L\'HORA DE', 'localImage': 'assets/meusPictogrames/horaDe.png'},
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