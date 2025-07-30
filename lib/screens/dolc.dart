import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Dolc extends StatelessWidget {
  Dolc({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {'id': 6644, 'text': 'NATILLES'},
    {'id': 2618, 'text': 'IOGURT'},
    {'id': 3317, 'text': 'FLAM'},
    {'id': 2502, 'text': 'PASTÍS'},
    {'id': 9057, 'text': 'PASTÍS DE POMA'},
    {'text': 'PASTÍS DE FORMATGE', 'localImage': 'assets/meusPictogrames/pastForm.png'},
    {'text': 'CACAOLAT', 'localImage': 'assets/meusPictogrames/cacaolat.png'},
    {'id': 12311, 'text': 'COCA'},
    {'text': 'COC', 'localImage': 'assets/meusPictogrames/coc.png'},
    {'id': 11382, 'text': 'GELAT'},
    {'text': 'COMPOTA DE POMA', 'localImage': 'assets/meusPictogrames/compota.png'},
    {'text': 'ECLAIRS', 'localImage': 'assets/meusPictogrames/esclairs.png'},
    {'id': 4940, 'text': 'COLA-CAO'},
    {'id': 25568, 'text': 'GALETES'},
    {'id': 8623, 'text': 'MAGDALENA'},
    {'id': 36344, 'text': 'ARRÒS AMB LLET'},
    {'text': 'MATÓ', 'localImage': 'assets/meusPictogrames/mato.png'},
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