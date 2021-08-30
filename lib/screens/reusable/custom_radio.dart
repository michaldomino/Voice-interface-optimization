import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRadio<T> extends StatefulWidget {
  final List<RadioModel<T>> radioModels;

  final T currentValue;
  final void Function(T) onValueChangedCallback;

  const CustomRadio({
    Key? key,
    required this.radioModels,
    required this.currentValue,
    required this.onValueChangedCallback,
  }) : super(key: key);

  @override
  _CustomRadioState<T> createState() => _CustomRadioState(radioModels);
}

class _CustomRadioState<T> extends State<CustomRadio<T>> {
  final List<RadioModel<T>> _radioModels;

  _CustomRadioState(this._radioModels);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _radioModels
          .map((e) => InkWell(
                child: RadioItem<T>(e, widget.currentValue),
                onTap: () => widget.onValueChangedCallback(e.value),
              ))
          .toList(),
    );
  }
}

class RadioItem<T> extends StatelessWidget {
  final RadioModel<T> _item;

  final T _currentValue;

  RadioItem(this._item, this._currentValue);

  @override
  Widget build(BuildContext context) {
    return _item.value == _currentValue
        ? _item.itemWidgetSelected
        : _item.itemWidgetNotSelected;
  }
}

class RadioModel<T> {
  T value;
  final Widget itemWidgetSelected;
  final Widget itemWidgetNotSelected;

  RadioModel(this.value, this.itemWidgetSelected, this.itemWidgetNotSelected);
}
