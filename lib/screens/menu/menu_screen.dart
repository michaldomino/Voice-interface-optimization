import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/logic/routes_model.dart';
import 'package:voice_interface_optimization/screens/reusable/appbar.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  static const double _LIST_VIEW_ITEM_HEIGHT = 100;
  static const double _LIST_VIEW_ITEM_TEXT_SIZE = 20;
  static const double _LIST_VIEW_ITEM_ICON_SIZE = 30;
  static const double _LIST_VIEW_ITEMS_SEPARATOR_HEIGHT = 10;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return Scaffold(
        appBar: CustomAppbar(context).get(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.separated(
              itemCount: _listViewItems.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: _LIST_VIEW_ITEMS_SEPARATOR_HEIGHT),
              itemBuilder: (context, index) {
                return Container(
                  height: _LIST_VIEW_ITEM_HEIGHT,
                  child: ElevatedButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 5,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              Intl.message(_listViewItems[index].text),
                              style: TextStyle(
                                  fontSize: _LIST_VIEW_ITEM_TEXT_SIZE,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Icon(
                            _listViewItems[index].iconData,
                            size: _LIST_VIEW_ITEM_ICON_SIZE,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    onPressed: () => Navigator.pushNamed(
                        context, _listViewItems[index].routeName),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color>((states) {
                        return _listViewItems[index].color;
                      }),
                    ),
                  ),
                );
              }),
        ),
      );
    });
  }
}

List<_ListViewItem> _listViewItems = [
  _ListViewItem(
      text: 'customTextSpeaking',
      color: Colors.green,
      iconData: Icons.edit,
      routeName: RoutesModel.CUSTOM_TEXT_SPEAKING),
  _ListViewItem(
      text: 'predefinedTextSpeaking',
      color: Colors.blue,
      iconData: Icons.list,
      routeName: RoutesModel.PREDEFINED_TEXT_SPEAKING),
  _ListViewItem(
      text: 'voiceRecognition',
      color: Colors.yellow,
      iconData: Icons.mic,
      routeName: RoutesModel.VOICE_RECOGNITION),
];

class _ListViewItem {
  String text;
  Color color;
  IconData iconData;
  String routeName;

  _ListViewItem({this.text, this.color, this.iconData, this.routeName});
}
