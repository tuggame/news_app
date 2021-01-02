import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:news_app/core/pref_service.dart';
import 'package:news_app/core/pref_store.dart';
import 'package:news_app/network/firebase_helper.dart';
import 'package:news_app/ui/detail/view/detail_view.dart';
import 'package:news_app/ui/settings/view/settings_view.dart';
import 'package:news_app/ui/signin/view/signin_view.dart';
import 'package:news_app/ui/signup/view/signup_view.dart';
import 'package:news_app/ui/themes.dart' as Themes;
import 'package:news_app/ui/welcome/view/welcome_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ui/home/view/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseHelper.createInstance();
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(MyApp(preferences));
}

class MyApp extends StatelessWidget {
  MyApp(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  ThemeData _getTheme(PrefStore prefStore) {
    return prefStore.darkMode ? Themes.darkTheme : Themes.lightTheme;
  }

  ThemeMode _getThemeMode(PrefStore prefStore) {
    return prefStore.darkMode ? ThemeMode.dark : ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PreferenceService>(
          create: (_) => PreferenceService(_sharedPreferences),
        ),
        ProxyProvider<PreferenceService, PrefStore>(
          update: (_, preferenceService, __) => PrefStore(preferenceService),
        ),
      ],
      child: Consumer<PrefStore>(
        builder: (context, prefStore, _) {
          return Observer(
            builder: (_) => MaterialApp(
              title: 'News App',
              initialRoute: (FirebaseHelper.helperInstance.firebaseInstance.currentUser == null) ? '/welcome' : '/',
              routes: {
                '/': (context) => HomeView(),
                '/welcome': (context) => WelcomeScreen(),
                '/signin': (context) => SignInView(),
                '/signup': (context) => SignUpView(),
                '/detail': (context) => DetailView(),
                '/settings': (context) => SettingsView(),
              },
              debugShowCheckedModeBanner: false,
              theme: _getTheme(prefStore),
              themeMode: _getThemeMode(prefStore),
              darkTheme: Themes.darkTheme,
              //home: HomeView(),
            ),
          );
        },
      ),
    );
  }
}
