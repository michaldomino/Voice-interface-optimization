import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:voice_interface_optimization/blocs/authentication/authentication_cubit.dart';
import 'package:voice_interface_optimization/logic/value_models/routes_model.dart';
import 'package:voice_interface_optimization/screens/reusable/popup_menu_button_choice.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final List<PopupMenuButtonChoice> _appBarButtonChoices;

  const CustomPopupMenuButton(this._appBarButtonChoices, {Key? key})
      : super(key: key);

  _select(BuildContext context, PopupMenuButtonChoice value) {
    switch (value.text) {
      case PopupMenuChoicesTextModel.SETTINGS:
        {
          Navigator.pushNamed(context, RoutesModel.SETTINGS);
        }
        break;
      case PopupMenuChoicesTextModel.LOG_OUT:
        {
          BlocProvider.of<AuthenticationCubit>(context).logout();
          Navigator.pushReplacementNamed(context, RoutesModel.LOGIN);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return _appBarButtonChoices.map((choice) {
          return PopupMenuItem<PopupMenuButtonChoice>(
            value: choice,
            child: Text(Intl.message((choice.text))),
          );
        }).toList();
      },
      onSelected: (PopupMenuButtonChoice choice) {
        _select(context, choice);
      },
    );
  }
}
