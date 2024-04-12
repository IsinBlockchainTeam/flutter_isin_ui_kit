import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/ui_utils.dart';

class ClipboardCopyableText extends StatelessWidget {
  final String text;
  final String textLabel;

  const ClipboardCopyableText(
      {super.key, required this.text, required this.textLabel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            flex: 4,
            child: SelectableText(
              text,
              style: const TextStyle(fontSize: 15),
            )),
        Flexible(
            flex: 1,
            child: Center(
                child: TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: text));
                UIUtils.showToast(context, "Copied $textLabel to clipboard");
              },
              child: const Icon(Icons.copy),
            )))
      ],
    );
  }
}
