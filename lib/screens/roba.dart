import 'package:flutter/material.dart';
import 'package:comunicador/exports.dart';
import 'package:provider/provider.dart';

class Roba extends StatelessWidget {
  Roba({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> pictogrames = [
    {'id': 3329, 'text': 'ULLERES'},
    {'id': 28195, 'text': 'CASC'},
    {'id': 5985, 'text': 'DISFRESSA'},
    {'id': 2303, 'text': 'CALÇOTETS'},
    {'id': 2565, 'text': 'PANTALONS'},
    {'id': 2436, 'text': 'JERSEI'},
    {'id': 2290, 'text': 'BUFANDA'},
    {'id': 2415, 'text': 'GUANTS'},
    {'id': 37574, 'text': 'SANDÀLIES'},
    {'id': 2298, 'text': 'MITJONS'},
    {'id': 4872, 'text': 'JAQUETA'},
    {'id': 2332, 'text': 'XANDALL'},
    {'id': 2601, 'text': 'BANYADOR'},
    {'id': 3108, 'text': 'GORRO'},
    {'id': 2622, 'text': 'SABATES'},
    {'id': 2620, 'text': 'SABATILLES'},
    {'id': 3229, 'text': 'BATA'},
    {'id': 2522, 'text': 'PIJAMA'},
  ];

  Widget build(BuildContext context) {
    final frase = context.watch<FraseModel>().frase;

    return Scaffold(
      body: Column(
        children: [
          Frase(
            sentenceWords: frase,
            onPopPressed: () => Navigator.pop(context),
            onHomePressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            onDeleteLast: () => context.read<FraseModel>().deleteLast(),
            onClearAll: () => context.read<FraseModel>().clearAll(),
            onPlaySentence: () async {
              await TTSService().speak(frase.join(' '));
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
                itemCount: pictogrames.length,
                itemBuilder: (context, index) {
                  final cat = pictogrames[index];
                  return InkWell(
                    onTap: () async {
                      await TTSService().speak(cat['text']);
                      context.read<FraseModel>().addWord(cat['text']);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: cat.containsKey('localImage')
                                  ? Image.asset(
                                      cat['localImage'],
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                                    )
                                  : Image.network(
                                      'https://static.arasaac.org/pictograms/${cat['id']}/${cat['id']}_500.png',
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                                    ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                              child: Text(
                                cat['text'],
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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