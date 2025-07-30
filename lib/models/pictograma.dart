class Pictograma {
  final int? id;
  final String text;
  final String? localImage;
  final String? route;

  Pictograma({this.id, required this.text, this.localImage, this.route});

  String? get imageUrl {
    if (id != null) {
      return 'https://static.arasaac.org/pictograms/$id/${id}_500.png';
    }
    return null;
  }
}