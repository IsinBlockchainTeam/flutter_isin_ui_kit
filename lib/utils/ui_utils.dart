import 'package:flutter/material.dart';

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

  static showCustomDialog(String text, BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
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
        });
  }
}
