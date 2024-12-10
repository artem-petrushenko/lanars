import 'package:flutter/material.dart';
import 'package:lanars/src/common/widget/text/default_text.dart';

class DocumentCart extends StatelessWidget {
  const DocumentCart({
    super.key,
    required this.url,
    required this.title,
    required this.subtitle,
    required this.isShowLeather,
  });

  final String url;
  final String title;
  final String subtitle;
  final bool isShowLeather;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          SizedBox(
            width: 40,
            child: Center(
              child: DefaultText.titleMedium(
                title.isNotEmpty && isShowLeather ? title.substring(0, 1) : '',
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        Expanded(
          child: Card.outlined(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: Image.network(
                  url,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.image),
                  fit: BoxFit.cover,
                  width: 56,
                  height: 56,
                ),
              ),
              title: Text(title),
              subtitle: Text(subtitle),
            ),
          ),
        ),
      ],
    );
  }
}
