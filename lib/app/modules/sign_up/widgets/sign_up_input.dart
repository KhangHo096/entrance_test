import 'package:entrance_test/app/msc/colors.dart';
import 'package:entrance_test/app/msc/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class SignUpInput extends StatefulWidget {
  final String title;
  final bool needObscured;
  final String inputNote;
  final Color inputNoteColor;
  final PasswordLevel? passwordLevel;
  final Function(String) onChanged;

  const SignUpInput({
    required this.title,
    required this.needObscured,
    required this.onChanged,
    required this.inputNote,
    required this.inputNoteColor,
    this.passwordLevel,
    super.key,
  });

  @override
  State<SignUpInput> createState() => _SignUpInputState();
}

class _SignUpInputState extends State<SignUpInput> {
  late final FocusNode focusNode;
  bool _focused = false;
  bool _obscured = false;

  @override
  void initState() {
    focusNode = FocusNode(debugLabel: widget.title);
    if (widget.needObscured) {
      _obscured = true;
    }
    focusNode.addListener(() {
      setState(() {
        _focused = focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _title(),
        _textField(),
        widget.needObscured ? _leveledDivider() : _divider(colorMain),
        ...note(),
      ],
    );
  }

  Widget _leveledDivider() {
    switch (widget.passwordLevel) {
      case null:
        return _divider(colorMain);
      case PasswordLevel.tooShort:
        return _divider(colorWhiteTrans50);
      case PasswordLevel.empty:
        return _divider(colorRed);
      case PasswordLevel.weak:
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: _divider(colorRed),
            ),
            Expanded(
              flex: 3,
              child: _divider(colorWhiteTrans50),
            ),
          ],
        );
      case PasswordLevel.fair:
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: _divider(colorYellow),
            ),
            Expanded(
              flex: 2,
              child: _divider(colorWhiteTrans50),
            ),
          ],
        );
      case PasswordLevel.good:
        return Row(
          children: [
            Expanded(
              flex: 3,
              child: _divider(colorMain),
            ),
            Expanded(
              flex: 1,
              child: _divider(colorWhiteTrans50),
            ),
          ],
        );
      case PasswordLevel.strong:
        return _divider(colorGreen);
      case PasswordLevel.tooLong:
        return _divider(colorRed);
    }
  }

  Widget _divider(Color color) {
    return Divider(
      height: 1.dp,
      thickness: 1,
      color: color,
    );
  }

  List<Widget> note() {
    if (widget.inputNote.isNotEmpty) {
      return [
        SizedBox(height: 10.dp),
        Row(
          children: [
            const Spacer(),
            Text(
              widget.inputNote,
              style: text12.copyWith(color: widget.inputNoteColor),
            ),
          ],
        ),
      ];
    }
    return [];
  }

  TextField _textField() {
    return TextField(
      focusNode: focusNode,
      style: text12.white,
      obscureText: _obscured,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: _focused ? '' : widget.title,
        hintStyle: text12.whiteTrans50,
        suffixIconConstraints: BoxConstraints(maxWidth: 20.dp),
        suffixIcon: widget.needObscured
            ? IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  setState(() {
                    _obscured = !_obscured;
                  });
                },
                icon: Icon(
                  _obscured
                      ? Icons.visibility_rounded
                      : Icons.visibility_off_rounded,
                  color: colorWhiteTrans50,
                  size: 16.dp,
                ),
              )
            : const SizedBox(),
      ),
    );
  }

  Text _title() {
    return Text(
      widget.title,
      style: _focused ? text12.whiteTrans50 : text12.black,
    );
  }
}

class EmailInput extends StatelessWidget {
  final bool emailValid;
  final String emailError;
  final Function(String) onChanged;

  const EmailInput({
    required this.emailValid,
    required this.emailError,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SignUpInput(
      title: 'Your email',
      needObscured: false,
      onChanged: onChanged,
      inputNote: emailError,
      inputNoteColor: colorRed,
    );
  }
}

class PasswordInput extends StatelessWidget {
  final bool passwordValid;
  final PasswordLevel? passwordLevel;
  final Function(String) onChanged;

  const PasswordInput({
    required this.passwordValid,
    required this.passwordLevel,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SignUpInput(
      title: 'Your password',
      needObscured: true,
      onChanged: onChanged,
      inputNote: _inputNote(),
      inputNoteColor: _inputNoteColor(),
      passwordLevel: passwordLevel,
    );
  }

  Color _inputNoteColor() {
    switch (passwordLevel) {
      case PasswordLevel.empty:
        return colorRed;
      case PasswordLevel.weak:
        return colorRed;
      case PasswordLevel.fair:
        return colorYellow;
      case PasswordLevel.good:
        return colorMain;
      case PasswordLevel.strong:
        return colorGreen;
      case PasswordLevel.tooShort:
        return colorWhiteTrans50;
      case null:
        return Colors.transparent;
      case PasswordLevel.tooLong:
        return colorRed;
    }
  }

  String _inputNote() {
    switch (passwordLevel) {
      case PasswordLevel.empty:
        return 'Password is required!';
      case PasswordLevel.weak:
        return 'Weak';
      case PasswordLevel.fair:
        return 'Fair';
      case PasswordLevel.good:
        return 'Good';
      case PasswordLevel.strong:
        return 'Strong';
      case PasswordLevel.tooShort:
        return 'Too short';
      case null:
        return '';
      case PasswordLevel.tooLong:
        return 'Password must be from 6 to 18 characters';
    }
  }
}

enum PasswordLevel {
  empty,
  tooShort,
  weak,
  fair,
  good,
  strong,
  tooLong,
}
