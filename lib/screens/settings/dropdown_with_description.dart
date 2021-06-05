import 'package:flutter/material.dart';

class DropdownWithDescription<T> extends StatefulWidget {
  final String description;
  final T initialValue;
  final List<TextDropdownMenuItem> items;
  final void Function(BuildContext, dynamic) onChangedAction;

  DropdownWithDescription(
      {required this.description,
      required this.initialValue,
      required this.items,
      required this.onChangedAction});

  @override
  State<StatefulWidget> createState() => _DropdownWithDescriptionState();
}

class _DropdownWithDescriptionState<T> extends State<DropdownWithDescription> {
  late T _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            child: Text(widget.description),
            flex: 1,
          ),
          Flexible(
            flex: 2,
            child: DropdownButton(
              isExpanded: true,
              value: _value,
              items: widget.items
                  .map((item) => DropdownMenuItem<T>(
                        child: Text(item.text),
                        value: item.value,
                      ))
                  .toList(),
              onChanged: (T? value) => onChanged(context, value),
            ),
          ),
        ]);
  }

  onChanged(BuildContext context, T? value) {
    if (value != null) {
      widget.onChangedAction(context, value);
      _value = value;
    }
  }
}

class TextDropdownMenuItem<T> {
  String text;
  T value;

  TextDropdownMenuItem(this.text, this.value);
}
