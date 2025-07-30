import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Dia extends StatelessWidget {
  Dia({Key? key}) : super(key: key);

  static const List<String> diesSetmana = [
    'dilluns', 'dimarts', 'dimecres', 'dijous', 'divendres', 'dissabte', 'diumuenge'
  ];

  final List<Map<String, dynamic>> pictogramesData = [
    {},
    {},
    {'id': 7244, 'text': 'SETMANA'},
    {},
    {
      'id': 7161,
      'text': 'MES',
      'navega': Mes(),
    },
    {'localImage': 'assets/meusPictogrames/dilluns.png', 'text': 'dilluns'},
    {'localImage': 'assets/meusPictogrames/dimarts.png', 'text': 'dimarts'},
    {'localImage': 'assets/meusPictogrames/dimecres.png', 'text': 'dimecres'},
    {'localImage': 'assets/meusPictogrames/dijous.png', 'text': 'dijous'},
    {'localImage': 'assets/meusPictogrames/divendres.png', 'text': 'divendres'},
    {},
    {'localImage': 'assets/meusPictogrames/dissabte.png', 'text': 'dissabte'},
    {'localImage': 'assets/meusPictogrames/diumuenge.png', 'text': 'diumuenge'},
    {},
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
