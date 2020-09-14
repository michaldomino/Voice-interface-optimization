import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_interface_optimization/blocs/localization/localization_cubit.dart';
import 'package:voice_interface_optimization/blocs/texts_language/texts_language_cubit.dart';
import 'package:voice_interface_optimization/models/routes_model.dart';
import 'package:voice_interface_optimization/persistence/shared_preferences_wrapper.dart';
import 'package:voice_interface_optimization/screens/reusable/appbar.dart';

import '../reusable/appbar.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  static const double LIST_VIEW_ITEM_HEIGHT = 100;
  static const double LIST_VIEW_ITEM_TEXT_SIZE = 20;
  static const double LIST_VIEW_ITEM_ICON_SIZE = 30;
  static const double LIST_VIEW_ITEMS_SEPARATOR_HEIGHT = 10;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return FutureBuilder(
        future: _loadLanguage(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: CustomAppbar(context).get(),
            body: ListView.separated(
                itemCount: _listViewItems.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: LIST_VIEW_ITEMS_SEPARATOR_HEIGHT),
                itemBuilder: (context, index) {
                  return Container(
                    height: LIST_VIEW_ITEM_HEIGHT,
                    child: RaisedButton(
                      child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                _listViewItems[index].text,
                                style:
                                TextStyle(fontSize: LIST_VIEW_ITEM_TEXT_SIZE),
                              ),
                              Icon(
                                _listViewItems[index].iconData,
                                size: LIST_VIEW_ITEM_ICON_SIZE,
                              ),
                            ],
                          ),
                          onPressed: () => Navigator.pushNamed(
                              context, _listViewItems[index].routeName),
                          color: _listViewItems[index].color,
                        ),
                      );
                    }),
              );
            },
          );
        });
  }

  Future _loadLanguage() async {
    SharedPreferencesWrapper sharedPreferencesWrapper =
    await SharedPreferencesWrapper.getInstance();
    BlocProvider.of<LocalizationCubit>(context).changeAppLanguage(
        context, sharedPreferencesWrapper.getAppLanguageCode());
    BlocProvider.of<TextsLanguageCubit>(context).changeTextsLanguage(
        context, sharedPreferencesWrapper.getTextsLanguage());
  }
}

List<_ListViewItem> _listViewItems = [
  _ListViewItem(
      text: 'Custom text speaking',
      color: Colors.green,
      iconData: Icons.edit,
      routeName: RoutesModel.CUSTOM_TEXT_SPEAKING),
  _ListViewItem(
      text: 'Predefined text speaking',
      color: Colors.blue,
      iconData: Icons.list,
      routeName: RoutesModel.PREDEFINED_TEXT_SPEAKING),
];

class _ListViewItem {
  String text;
  Color color;
  IconData iconData;
  String routeName;

  _ListViewItem({this.text, this.color, this.iconData, this.routeName});
}
