import 'package:flutter/material.dart';
import 'package:flutter_isin_ui_kit/utils/ui_utils.dart';

class ConfirmationButton extends StatelessWidget {
  final String buttonText;
  final String alertTitle;
  final String alertContent;
  final String alertConfirmation;
  final String alertCancel;
  final Function(BuildContext context) onConfirmedAction;
  final FontWeight buttonFontWeight;
  final Color buttonColor;

  const ConfirmationButton(
      {super.key,
      required this.onConfirmedAction,
      required this.buttonText,
      required this.alertTitle,
      required this.alertContent,
      required this.alertConfirmation,
      required this.alertCancel,
      this.buttonFontWeight = FontWeight.normal,
      this.buttonColor = Colors.red});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        UIUtils.showConfirmDialog(context, alertTitle, alertContent,
            alertConfirmation, alertCancel, onConfirmedAction);
      },
      style: FilledButton.styleFrom(backgroundColor: buttonColor),
      child: Text(
        buttonText,
        style: TextStyle(
          fontWeight: buttonFontWeight,
        ),
      ),
    );
  }
}
