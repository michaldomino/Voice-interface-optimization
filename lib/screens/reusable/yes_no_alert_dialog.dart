import 'package:flutter/material.dart';
import 'package:voice_interface_optimization/generated/l10n.dart';

class YesNoAlertDialog extends StatelessWidget {
  final String titleText;
  final String contentText;

  final void Function() onYesAction;
  final void Function() onNoAction;

  const YesNoAlertDialog(
      {Key? key,
      required this.titleText,
      required this.contentText,
      required this.onYesAction,
      required this.onNoAction})
      : super(key: key);

  @override
  AlertDialog build(BuildContext context) {
    return AlertDialog(
      title: Text(titleText),
      content: Text(contentText),
      actions: [
        _yesButton(context),
        _noButton(context),
      ],
    );
  }

  _yesButton(BuildContext context) {
    return TextButton(
      child: Text(S.of(context).yes),
      onPressed: onYesAction,
    );
  }

  _noButton(BuildContext context) {
    return TextButton(
      child: Text(S.of(context).no),
      onPressed: onNoAction,
    );
  }
}
