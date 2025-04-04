import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageBloc extends Bloc<LanguageEvent, Locale> {
  LanguageBloc() : super(const Locale('ru')) {
    _loadLanguage();
  }

  void _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString('locale') ?? 'ru';
    add(ChangeLanguage(langCode));
  }

  @override
  Stream<Locale> mapEventToState(LanguageEvent event) async* {
    if (event is ChangeLanguage) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('locale', event.languageCode);
      yield Locale(event.languageCode);
    }
  }
}

abstract class LanguageEvent {}

class ChangeLanguage extends LanguageEvent {
  final String languageCode;
  ChangeLanguage(this.languageCode);
}
