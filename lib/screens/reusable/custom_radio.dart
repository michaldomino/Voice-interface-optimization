import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  final List<RadioModel> _radioModels;

  const CustomRadio(this._radioModels, {Key? key}) : super(key: key);

  @override
  _CustomRadioState createState() => _CustomRadioState(_radioModels);
}

class _CustomRadioState extends State<CustomRadio> {
  final List<RadioModel> _radioModels;

  _CustomRadioState(this._radioModels);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _radioModels
          .map((e) => OutlinedButton(
                child: RadioItem(e),
                onPressed: () {
                  if (!e.isSelected) {
                    setState(() {
                      _radioModels
                          .forEach((element) => element.isSelected = false);
                      e.isSelected = true;
                    });
                  }
                },
              ))
          .toList(),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return _item.isSelected
        ? _item.itemWidgetSelected
        : _item.itemWidgetNotSelected;
    // if (_item.isSelected == true) {
    //   return _item.itemWidgetSelected;
    // }
    // return _item.itemWidgetNotSelected;
  }
}

class RadioModel {
  bool isSelected = false;
  final Widget itemWidgetSelected;
  final Widget itemWidgetNotSelected;

  RadioModel(this.itemWidgetSelected, this.itemWidgetNotSelected);
}
