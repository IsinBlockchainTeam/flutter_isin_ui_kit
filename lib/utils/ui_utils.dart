import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UIUtils {
  static void showToast(BuildContext context, String text,
      {Color? backgroundColor}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
    );
  }

  static showLoadingDialog(String text, BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(text)
                ],
              ),
            ),
          );
        });
  }

  static showInputDialog(BuildContext context, String title, String hint,
      Function(String) onSubmitted) {
    TextEditingController textEditingController = TextEditingController();
    FocusNode focusNode = FocusNode();

    showDialog(
      context: context,
      builder: (context) {
        WidgetsBinding.instance
            .addPostFrameCallback((_) => focusNode.requestFocus());

        return AlertDialog(
          title: Text(title),
          contentPadding: const EdgeInsets.fromLTRB(24, 16, 0, 24),
          content: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  decoration: InputDecoration(hintText: hint),
                  onSubmitted: (value) {
                    onSubmitted(value);
                    Navigator.of(context)
                        .pop(); // Optionally close the dialog on submit
                  },
                  autofocus: true,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (textEditingController.text.isNotEmpty) {
                    onSubmitted(textEditingController.text);
                    Navigator.of(context)
                        .pop(); // Close the dialog after submission
                  }
                },
                icon: const Icon(Icons.send),
              )
            ],
          ),
        );
      },
    );
  }

  static showConfirmDialog(
      BuildContext context,
      String title,
      String content,
      String okText,
      String cancelText,
      Function(BuildContext) onConfirmedAction,
      {Color okColor = Colors.red}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: okColor),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    onConfirmedAction(context);
                  },
                  child: Text(okText),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(cancelText),
                ),
              ]);
        });
  }

  static Widget buildQrDialogFromJson(Map<String, dynamic> json) {
    return Dialog(
      child: SizedBox(
          child: QrImageView(
        data: jsonEncode(json),
        version: QrVersions.auto,
        backgroundColor: Colors.white,
      )),
    );
  }

  static Widget buildAsyncComponent(Future future, Function buildChild) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Container();
        }

        final result = snapshot.data;

        return buildChild(result);
      },
    );
  }
}
