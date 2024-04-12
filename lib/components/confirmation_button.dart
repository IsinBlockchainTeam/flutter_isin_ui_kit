import 'package:flutter/material.dart';

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

  showConfirmDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(alertTitle),
              content: Text(alertContent),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    onConfirmedAction(context);
                  },
                  child: Text(alertConfirmation),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(alertCancel),
                ),
              ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        showConfirmDialog(context);
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
