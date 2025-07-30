import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Accions extends StatelessWidget {
  Accions({Key? key}) : super(key: key);

  List<Map<String, dynamic>> get pictogramesData => [
    {'text': 'VOLER', 'localImage': 'assets/meusPictogrames/voler.png'},
    {'text': 'ANAR', 'localImage': 'assets/meusPictogrames/anar.png'},
    {'id': 19524, 'text': 'AJUDAR'},
    {'id': 28429, 'text': 'S\'HA ACABAT'},
    {'id': 2276, 'text': 'BEURE'},
    {'id': 2349, 'text': 'MENJAR'},
    {'id': 28157, 'text': 'ESCLAFAR'},
    {'id': 6617, 'text': 'PUJAR'},
    {'id': 8649, 'text': 'PASSEJAR'},
    {'id': 22205, 'text': 'DESCANSAR'},
    {'id': 2430, 'text': 'PIPÍ'},
    {'id': 2474, 'text': 'MIRAR'},
    {'id': 5549, 'text': 'PARAR TAULA'},
    {'id': 9035, 'text': 'NETEJAR'},
    {},
    {'id': 6053, 'text': 'BAIXAR'},
    {'id': 2439, 'text': 'JUGAR'},
    {'id': 4550, 'text': 'ABRAÇAR'},
    {'text': 'FER', 'localImage': 'assets/meusPictogrames/fer.png'},
    {'id': 6624, 'text': 'TREBALLAR'},
    {'id': 6875, 'text': 'OBRIR'},
    {'id': 7056, 'text': 'TANCAR'},
    {'id': 12252, 'text': 'AJUDA\'M'},
    {
      'id': 3220,
      'navega': Accions2(),
    },
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
                  crossAxisCount: 8,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 18,
                ),
                itemCount: pictogramesData.length,
                itemBuilder: (context, index) {
                  final catData = pictogramesData[index];

                  if (catData.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  if (catData.containsKey('navega')) {
                    return MesPictos(
                      id: catData['id'],
                      navega: catData['navega'],
                      onTap: () async {
                        if (catData.containsKey('text')) {
                          await TTSService().speak(catData['text']);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => catData['navega']),
                        );
                      },
                    );
                  }

                  final Pictograma currentPictogram = Pictograma(
                    id: catData['id'],
                    text: catData['text'] ?? '',
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
