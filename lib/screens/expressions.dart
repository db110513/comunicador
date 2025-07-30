import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Expressions extends StatelessWidget {
  Expressions({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {'id': 6009, 'text': 'HOLA'},
    {'id': 5896, 'text': 'ADÉU'},
    {'id': 11599, 'text': 'MOLT BÉ'},
    {'text': 'NO ENS ENTENEM', 'localImage': 'assets/meusPictogrames/noEntenem.png'},
    {'id': 28429, 'text': 'S\'HA ACABAT'},
    {'id': 6944, 'text': 'BON DIA'},
    {'id': 6942, 'text': 'BONA NIT'},
    {'text': 'COM ESTÀS', 'localImage': 'assets/meusPictogrames/comEstas.png'},
    {'id': 11625, 'text': 'HO SENTO'},
    {'text': 'GRÀCIES', 'localImage': 'assets/meusPictogrames/gracies.png'},
    {'text': 'SÍ', 'localImage': 'assets/meusPictogrames/si.png'},
    {'text': 'NO', 'localImage': 'assets/meusPictogrames/no.png'},
    {'id': 13630, 'text': 'ESTIC BÉ'},
    {'id': 3220, 'text': 'MÉS'},
    {'text': 'SI US PLAU', 'localImage': 'assets/meusPictogrames/siUsPlau.png'},
  ];

  final Set<String> senseTextVisible = {'SÍ', 'NO'};

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
