import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/language_bloc.dart';
import '../localization/localization.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(localization.translate("profile"))),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text(localization.translate("my_account")),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(localization.translate("settings")),
          ),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text(localization.translate("theme")),
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text(localization.translate("language")),
            trailing: DropdownButton<String>(
              value: BlocProvider.of<LanguageBloc>(context).state.languageCode,
              onChanged: (newLang) {
                if (newLang != null) {
                  BlocProvider.of<LanguageBloc>(context).add(ChangeLanguage(newLang));
                }
              },
              items: [
                DropdownMenuItem(value: 'en', child: Text("English")),
                DropdownMenuItem(value: 'ru', child: Text("Русский")),
                DropdownMenuItem(value: 'kk', child: Text("Қазақша")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
