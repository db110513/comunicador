import 'package:flutter/material.dart';

class MesPictos extends StatelessWidget {
  final int? id;
  final String? localImage;
  final String? text;
  final Widget? navega;
  final Future<void> Function()? onTap;

  const MesPictos({
    Key? key,
    this.id,
    this.localImage,
    this.text,
    this.navega,
    this.onTap,
  }) : super(key: key);

  Widget build(BuildContext context) {
    Widget imageWidget;
    if (id != null) {
      imageWidget = Image.network(
        'https://static.arasaac.org/pictograms/$id/${id}_500.png',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    } else if (localImage != null) {
      imageWidget = Image.asset(
        localImage!,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
      );
    } else {
      imageWidget = const Icon(Icons.error);
    }

    return InkWell(
      onTap: () async {
        if (onTap != null) await onTap!();
        if (navega != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navega!),
          );
        }
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
                child: imageWidget,
              ),
            ),
            if (text != null)
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    text!,
                    style: const TextStyle(
                      fontSize: 24,
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
  }
}