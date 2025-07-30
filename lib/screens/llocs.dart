import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Llocs extends StatelessWidget {
  Llocs({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {'text': 'CASA', 'localImage': 'assets/meusPictogrames/casa.png'},
    {'text': 'BOTIGA', 'localImage': 'assets/meusPictogrames/botiga.png'},
    {'id': 6454, 'text': 'COL·LEGI'},
    {'text': 'CLASSE', 'localImage': 'assets/meusPictogrames/classe.png'},
    {'id': 2430, 'text': 'LAVABO'},
    {'id': 3142, 'text': 'PISCINA'},
    {'text': 'GARATGE', 'localImage': 'assets/meusPictogrames/garatge.png'},
    {'id': 6896, 'text': 'TRASTER'},
    {'id': 2974, 'text': 'HORT'},
    {},
    {'id': 2704, 'text': 'TARRAGONA'},
    {'text': 'TORTOSA', 'localImage': 'assets/meusPictogrames/tortosa.png'},
    {'id': 6523, 'text': 'AMBULATORI'},
    {'id': 3116, 'text': 'HOSPITAL'},
    {'id': 2849, 'text': 'PERRUQUERIA'},
    {},
    {'id': 11343, 'text': 'PIS'},
    {'id': 5957, 'text': 'XALET'},
    {'text': 'RESTAURANT', 'localImage': 'assets/meusPictogrames/restaurant.png'},
    {'id': 28131, 'text': 'CAFETERIA'},
    {'id': 15728, 'text': 'HOTEL'},
    {},
    {'id': 8254, 'text': 'BALCÓ'},
    {
      'id': 3220,
      'text': '',
      'navega': Llocs2(),
    },
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
                  childAspectRatio: .9,
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
