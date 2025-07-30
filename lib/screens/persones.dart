import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Persones extends StatelessWidget {
  Persones({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {'id': 2617, 'text': 'JO'},
    {'text': 'SANTI', 'localImage': 'assets/meusPictogrames/santi.png'},
    {'id': 2497, 'text': 'PAPA'},
    {'id': 31148, 'text': 'MAMA'},
    {},
    {'id': 2485, 'text': 'NEN'},
    {'id': 2484, 'text': 'NENA'},
    {'text': 'IAIA ROSA', 'localImage': 'assets/meusPictogrames/rosa.png'},
    {'text': 'IAIO TONI', 'localImage': 'assets/meusPictogrames/toni.png'},
    {'text': 'IAIA PILAR', 'localImage': 'assets/meusPictogrames/pilar.png'},
    {'text': 'IAIO SANTIAGO', 'localImage': 'assets/meusPictogrames/santiago.png'},
    {},
    {'text': 'AVI', 'localImage': 'assets/meusPictogrames/avi.png'},
    {'text': 'ÀVIA', 'localImage': 'assets/meusPictogrames/avia.png'},
    {
      'id': 7116,
      'text': 'FAMILIA',
      'navega': Familia(),
    },
    {'text': 'METGE', 'localImage': 'assets/meusPictogrames/metge.png'},
    {'text': 'PAOLA', 'localImage': 'assets/meusPictogrames/paola.png'},
    {'text': 'CONTXI', 'localImage': 'assets/meusPictogrames/contxi.png'},
    {'text': 'MARCOS', 'localImage': 'assets/meusPictogrames/marcos.png'},
    {'id': 8487, 'text': 'AMIC'},
    {
      'localImage': 'assets/meusPictogrames/persCol.png',
      'text': 'PERSONES COL·LEGI',
      'navega': PersonesCole(),
    },
  ];

  Widget build(BuildContext context) {
    final fraseModel = context.watch<FraseModel>();
    final frasePictogrames = fraseModel.frase;

    const Color colorPictos = Color(0xFFFAFAD1); // Color comú per a aquesta pantalla

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
                  childAspectRatio: 0.7,
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
                      buttonColor: catData['color'] as Color? ?? colorPictos, // Usa el color del mapa si existeix, sinó el color per defecte de la pantalla
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