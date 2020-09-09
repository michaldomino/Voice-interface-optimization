import 'package:flutter/material.dart';

class DropdownWithDescription extends StatefulWidget {
  String description;
  String initialValue;
  List<DropdownWithDescriptionItem> items;
  Function(BuildContext, String) onChanged;

  DropdownWithDescription(
      {this.description, this.initialValue, this.items, this.onChanged});

  @override
  State<StatefulWidget> createState() => _DropdownWithDescriptionState();
}

class _DropdownWithDescriptionState extends State<DropdownWithDescription> {
  String _value;

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
                  .map((item) => DropdownMenuItem(
                        child: Text(item.text),
                        value: item.value,
                      ))
                  .toList(),
              onChanged: (value) => onChanged(context, value),
            ),
          ),
        ]);
  }

  onChanged(BuildContext context, String value) {
    widget.onChanged(context, value);
    _value = value;
  }
}

class DropdownWithDescriptionItem {
  String text;
  String value;

  DropdownWithDescriptionItem(this.text, this.value);
}
