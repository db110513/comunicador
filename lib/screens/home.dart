import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comunicador/exports.dart';
import 'package:comunicador/models/pictograma.dart';
import 'package:comunicador/widgets/pictogram_button.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categoriesData = [
    {
      'id': 7203,
      'text': 'PERSONES',
      'color': const Color(0xFFFAFAD1),
      'screen': (BuildContext context) => Persones(),
    },
    {
      'id': 7297,
      'text': 'ACCIONS',
      'color': const Color(0xFFc8f5c8),
      'screen': (BuildContext context) => Accions(),
    },
    {
      'id': 9810,
      'text': 'JOCS I ESPORTS',
      'color': const Color(0xFFfbdd8c),
      'screen': (BuildContext context) => Jocs(),
    },
    {},
    {
      'id': 32584,
      'text': 'ATRIBUTS',
      'color': const Color(0xFF8cb2f2),
      'screen': (BuildContext context) => Atributs(),
    },
    {
      'id': 9819,
      'text': 'LLOCS',
      'color': const Color(0xFFfbdd8c),
      'screen': (BuildContext context) => Llocs(),
    },
    {
      'id': 10351,
      'text': 'TRANSPORTS',
      'color': Colors.white,
      'screen': (BuildContext context) => Transports(),
    },
    {
      'id': 4610,
      'text': 'ALIMENTS',
      'color': Colors.white,
      'screen': (BuildContext context) => Aliments(),
    },
    {
      'id': 7233,
      'text': 'ROBA',
      'color': Colors.white,
      'screen': (BuildContext context) => Roba(),
    },
    {
      'id': 32592,
      'text': 'EXPRESSIONS',
      'color': const Color(0xFFefbfd6),
      'screen': (BuildContext context) => Expressions(),
    },
    {
      'id': 2793,
      'text': 'TECLAT',
      'color': const Color(0xFFfbdd8c),
      'screen': (BuildContext context) => Teclat(),
    },
    {
      'id': 11476,
      'text': 'SENTIMENTS',
      'color': Colors.white,
      'screen': (BuildContext context) => Sentiments(),
    },
    {
      'id': 32578,
      'text': 'APARELLS I MOBLES',
      'color': const Color(0xFFfbdd8c),
      'screen': (BuildContext context) => AparellsMobles(),
    },
    {
      'id': 32582,
      'text': 'OBJECTES QUOTIDIANS',
      'color': const Color(0xFFfbdd8c),
      'screen': (BuildContext context) => ObjectesQuotidians(),
    },
    {
      'text': 'TEMPS',
      'color': const Color(0xFFfbdd8c),
      'screen': (BuildContext context) => Temps(),
      'localImage': 'assets/meusPictogrames/temps.png',
    },
    {
      'text': 'COS I SALUT',
      'color': const Color(0xFFfbdd8c),
      'screen': (BuildContext context) => CosHigieneSalut(),
      'localImage': 'assets/meusPictogrames/cosSalut.png',
    },
    {
      'id': 7765,
      'text': 'ESPAI',
      'color': Colors.white,
      'screen': (BuildContext context) => Espai(),
    },
    {},
    {
      'text': 'COLOR, FORMA, MIDA',
      'color': Colors.white,
      'screen': (BuildContext context) => ColorFormaMida(),
      'localImage': 'assets/meusPictogrames/colorFormaMida.png',
    },
    {
      'id': 20389,
      'text': 'NATURA',
      'color': Colors.white,
      'screen': (BuildContext context) => Natura(),
    },
    {
      'id': 7099,
      'text': 'ACTIVITATS I FESTES',
      'color': Colors.white,
      'screen': (BuildContext context) => ActivitatsFestes(),
    },
  ];

  Widget build(BuildContext context) {
    final fraseModel = context.watch<FraseModel>();
    final frasePictogrames = fraseModel.frase;

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
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 18,
                ),
                itemCount: categoriesData.length,
                itemBuilder: (context, index) {
                  final catData = categoriesData[index];

                  if (catData.isEmpty || catData['text'] == null || catData['screen'] == null) {
                    return const SizedBox.shrink();
                  }

                  final Pictograma categoryPictogram = Pictograma(
                    id: catData['id'],
                    text: catData['text']!,
                    localImage: catData['localImage'],
                  );

                  return PictogramButton(
                    pictogram: categoryPictogram,
                    buttonColor: catData['color'] as Color?,
                    onTap: () async {
                      await TTSService().speak(categoryPictogram.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: catData['screen'],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}