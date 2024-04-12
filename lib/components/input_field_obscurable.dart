import 'package:flutter/material.dart';

class InputFieldObscurable extends StatefulWidget {
  final String hintText;
  final String labelText;
  final bool isEnabled;
  final String? Function(String?) validator;
  final double expandedHeight;
  final String initialValue;

  const InputFieldObscurable({
    super.key,
    required this.hintText,
    required this.labelText,
    this.isEnabled = true,
    required this.validator,
    this.expandedHeight = 130,
    this.initialValue = '',
  });

  @override
  State<InputFieldObscurable> createState() => _InputFieldObscurableState();
}

class _InputFieldObscurableState extends State<InputFieldObscurable> {
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _obscured ? null : widget.expandedHeight,
      child: TextFormField(
        initialValue: widget.initialValue,
        keyboardType: TextInputType.visiblePassword,
        obscureText: _obscured,
        expands: !_obscured,
        maxLines: _obscured ? 1 : null,
        enabled: widget.isEnabled,
        focusNode: textFieldFocusNode,
        validator: widget.validator,
        decoration: InputDecoration(
          //Hides label on focus or if filled
          hintText: widget.hintText,
          labelText: widget.labelText,
          isDense: true,
          // Reduces height a bit
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.lock_rounded, size: 24),
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
            child: GestureDetector(
              onTap: _toggleObscured,
              child: Icon(
                _obscured
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
