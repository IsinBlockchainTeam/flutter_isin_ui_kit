import 'package:flutter/material.dart';
import 'package:flutter_isin_ui_kit/components/clipboard_copyable_text.dart';
import 'package:flutter_isin_ui_kit/components/confirmation_button.dart';
import 'package:flutter_isin_ui_kit/components/field_obscurable.dart';
import 'package:flutter_isin_ui_kit/components/input_field_obscurable.dart';
import 'package:flutter_isin_ui_kit/components/modal_mobile_scanner.dart';
import 'package:flutter_isin_ui_kit/utils/restart_widget.dart';
import 'package:flutter_isin_ui_kit/utils/ui_utils.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  String text = 'default value';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example app'),
        backgroundColor: Colors.cyanAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipboardCopyableText(
                text: text,
                textLabel: 'Clipboard Copyable Text',
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputFieldObscurable(
                        hintText: 'Insert Text',
                        labelText: 'Text',
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Text';
                          }

                          text = value;

                          return null;
                        },
                        initialValue: text),
                    OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(
                            () {},
                          );
                        }
                      },
                      child: const Text('Set text'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FieldObscurable(
                  key: ValueKey(text),
                  labelText: 'Read-only',
                  text: 'read-only $text'),
              const SizedBox(height: 20),
              ConfirmationButton(
                onConfirmedAction: (BuildContext context) {
                  UIUtils.showToast(context, 'Action confirmed',
                      backgroundColor: Colors.green);

                  RestartWidget.restartApp(context);
                },
                buttonText: 'Restart app',
                alertTitle: 'Confirmation',
                alertContent: 'Are you sure you want to confirm this action?',
                alertConfirmation: 'Yes',
                alertCancel: 'No',
                buttonFontWeight: FontWeight.bold,
                buttonColor: Colors.green,
              ),
              const SizedBox(height: 20),
              ModalMobileScanner(
                onDetect: (String? value) =>
                    print(value ?? 'No valid value detected'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
