import 'package:flutter/material.dart';

class DropdownWithDescription<T> extends StatefulWidget {
  final String description;
  final T initialValue;
  final List<TextDropdownMenuItem> items;
  final void Function(T) onChangedAction;

  DropdownWithDescription(
      {required this.description,
      required this.initialValue,
      required this.items,
      required this.onChangedAction});

  @override
  State<StatefulWidget> createState() => _DropdownWithDescriptionState<T>();
}

class _DropdownWithDescriptionState<T>
    extends State<DropdownWithDescription<T>> {
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
            child: DropdownButton<T>(
              isExpanded: true,
              value: _value,
              items: widget.items
                  .map((item) => DropdownMenuItem<T>(
                        child: Text(item.text),
                        value: item.value,
                      ))
                  .toList(),
              onChanged: (T? value) => onChanged(value),
            ),
          ),
        ]);
  }

  onChanged(T? value) {
    if (value != null) {
      widget.onChangedAction(value);
      _value = value;
    }
  }
}

class TextDropdownMenuItem<T> {
  String text;
  T value;

  TextDropdownMenuItem(this.text, this.value);
}
