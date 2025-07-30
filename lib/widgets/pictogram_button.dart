import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/pictograma.dart';
import '../services/tts.dart';

class PictogramButton extends StatelessWidget {
  final Pictograma pictogram;
  final VoidCallback? onTap;
  final Color? buttonColor;
  final bool showText;

  const PictogramButton({
    Key? key,
    required this.pictogram,
    this.onTap,
    this.buttonColor,
    this.showText = true,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (pictogram.text.isNotEmpty) {
          await TTSService().speak(pictogram.text);
        }

        if (onTap != null) {
          onTap!();
        }
        if (pictogram.route != null && Navigator.of(context).canPop()) {
          Navigator.pushNamed(context, pictogram.route!);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(8),
          color: buttonColor ?? Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: pictogram.localImage != null
                    ? Image.asset(
                        pictogram.localImage!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.error),
                      )
                    : pictogram.imageUrl != null
                        ? CachedNetworkImage(
                            imageUrl: pictogram.imageUrl!,
                            fit: BoxFit.contain,
                            placeholder: (context, url) =>
                                const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : const Icon(Icons.error),
              ),
            ),
            if (showText)
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    pictogram.text.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 19,
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