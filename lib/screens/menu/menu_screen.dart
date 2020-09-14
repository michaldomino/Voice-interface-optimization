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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
        builder: (context, state) {
      return FutureBuilder(
        future: _loadLanguage(),
        builder: (context, _) {
          return Scaffold(
            appBar: CustomAppbar(context).get(),
            body: ListView.separated(
                itemCount: 2,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  return Container(
                    height: 100,
                    child: RaisedButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            _listViewItems[index].text,
                            style: TextStyle(fontSize: 20),
                          ),
                          Icon(
                            _listViewItems[index].iconData,
                            size: 30,
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
      text: "Custom text speaking",
      color: Colors.green,
      iconData: Icons.edit,
      routeName: RoutesModel.CUSTOM_TEXT_SPEAKING),
  _ListViewItem(
      text: "Other",
      color: Colors.blue,
      iconData: Icons.list,
      routeName: RoutesModel.SETTINGS),
];

class _ListViewItem {
  String text;
  Color color;
  IconData iconData;
  String routeName;

  _ListViewItem({this.text, this.color, this.iconData, this.routeName});
}
