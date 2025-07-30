import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Teclat extends StatelessWidget {
  Teclat({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogramesData = [
    {'id': 2627, 'text': '1'},
    {'id': 2628, 'text': '2'},
    {'id': 2629, 'text': '3'},
    {'id': 2630, 'text': '4'},
    {'id': 2631, 'text': '5'},
    {'id': 2632, 'text': '6'},
    {'id': 2633, 'text': '7'},
    {'id': 2634, 'text': '8'},
    {'id': 2635, 'text': '9'},
    {'id': 2626, 'text': '0'},
    {'id': 3418, 'text': '?'},
    {'id': 3417, 'text': '!'},

    {'id': 3146, 'text': 'Q'},
    {'id': 3167, 'text': 'W'},
    {'id': 3096, 'text': 'E'},
    {'id': 3147, 'text': 'R'},
    {'id': 3158, 'text': 'T'},
    {'id': 3171, 'text': 'Y'},
    {'id': 3164, 'text': 'U'},
    {'id': 3117, 'text': 'I'},
    {'id': 3136, 'text': 'O'},
    {'id': 3137, 'text': 'P'},
    {'id': 3415, 'text': '¿'},
    {'id': 3414, 'text': '¡'},

    {'id': 3049, 'text': 'A'},
    {'id': 3152, 'text': 'S'},
    {'id': 3088, 'text': 'D'},
    {'id': 3101, 'text': 'F'},
    {'id': 3104, 'text': 'G'},
    {'id': 3112, 'text': 'H'},
    {'id': 3119, 'text': 'J'},
    {'id': 3120, 'text': 'K'},
    {'id': 3121, 'text': 'L'},
    {'id': 29078, 'text': 'Ç'},
    {'id': 5095, 'text': '#'},
    {'id': 3200, 'text': '-'},

    {},
    {'id': 3173, 'text': 'Z'},
    {'id': 3168, 'text': 'X'},
    {'id': 3069, 'text': 'C'},
    {'id': 3165, 'text': 'V'},
    {'id': 3061, 'text': 'B'},
    {'id': 3133, 'text': 'N'},
    {'id': 3125, 'text': 'M'},
    {'id': 5085, 'text': 'Ñ'},
    {'id': 3189, 'text': ','},
    {'id': 3218, 'text': '.'},
    {'id': 3177, 'text': '@'},
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
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 12,
                  childAspectRatio: .8,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 7,
                ),
                itemCount: pictogramesData.length,
                itemBuilder: (context, index) {
                  final catData = pictogramesData[index];

                  if (catData.isEmpty) {
                    return const CeldaBuida();
                  }

                  final Pictograma currentPictogram = Pictograma(
                    id: catData['id'],
                    text: catData['text']!,
                    localImage: catData['localImage'],
                  );

                  return PictogramButton(
                    pictogram: currentPictogram,
                    buttonColor: buttonBgColor,
                    showText: false,
                    onTap: () => fraseModel.addWord(currentPictogram),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: SizedBox(
              height: 110,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: fraseModel.sentenceText));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Frase copiada!')),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          'assets/meusPictogrames/copy.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: GestureDetector(
                      onTap: () {
                        SystemSound.play(SystemSoundType.click);
                        fraseModel.addWord(Pictograma(text: ' '));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        fraseModel.deleteLast();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: Image.asset(
                          'assets/meusPictogrames/undo.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}