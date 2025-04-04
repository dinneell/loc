import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/language_bloc.dart';
import 'localization/localization.dart';
import 'screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final savedLocale = prefs.getString('locale') ?? 'ru';

  runApp(MyApp(locale: savedLocale));
}

class MyApp extends StatelessWidget {
  final String locale;
  const MyApp({super.key, required this.locale});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LanguageBloc()..add(ChangeLanguage(locale)),
      child: BlocBuilder<LanguageBloc, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'FitBuddy',
            locale: locale,
            supportedLocales: const [Locale('en'), Locale('ru'), Locale('kk')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: ProfileScreen(),
          );
        },
      ),
    );
  }
}
