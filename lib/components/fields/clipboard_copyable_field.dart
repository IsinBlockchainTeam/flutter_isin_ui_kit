import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/ui_utils.dart';
import 'custom_text_field.dart';

class ClipboardCopyableField extends CustomTextField {
  final Color? iconColor;

  const ClipboardCopyableField(
      {super.key,
      this.iconColor,
      required super.label,
      required super.value,
      super.labelColor,
      super.borderRadius = 10});

  void _onTapped(BuildContext context) {
    Clipboard.setData(ClipboardData(text: value));
    UIUtils.showToast(context, "Copied $label to clipboard");
  }

  @override
  Widget buildSuffixIcon(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTapped(context),
      child: Icon(
        Icons.copy,
        size: 20,
        color: iconColor,
      ),
    );
  }
}
