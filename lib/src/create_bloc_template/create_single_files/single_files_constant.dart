import 'package:mustache_template/mustache_template.dart';

class SingleFilesConstant{

  static String appScreens = """
/// define all your screen name here..
class AppScreens {
  AppScreens._();

  static const String home = '/home';
  static const String splash = '/splash';
  static const String login = '/login';
}
  """;

  static String appConstants = """
class AppConstants{
  AppConstants._();
}
  """;

  static String homeUi = """
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home Page"),
      ),
    );
  }
}

  """;

  static String preferenceManager = """
import 'package:rxdart/src/transformers/flat_map.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static const _keyUserToken = 'keyUserToken';
  static const _keyUserProfile = 'keyUserProfile';
  static const keyLanguageCode = 'language_code';
  static const keyIsGuestUser = 'guest_user';
  static const keyFullName = 'name';
  static const keyEmail = 'email';

  Future<bool> isLoggedIn() async {
    final preferences = await _getPreferences();
    return preferences.containsKey(_keyUserToken) &&
        preferences.containsKey(_keyUserProfile);
  }

  Future<bool> isGuestUser() async {
    final preferences = await _getPreferences();
    return preferences.getBool(keyIsGuestUser) ?? false;
  }

  void setGuestUser(bool isGuestUser) async {
    (await _getPreferences()).setBool(keyIsGuestUser, isGuestUser);
  }

  Future<SharedPreferences> _getPreferences() async =>
      await SharedPreferences.getInstance();

  Future<String?> getUserToken() async {
    return (await _getPreferences()).getString(_keyUserToken);
  }

  void setUserToken(String? token) async {
    if (token == null || token.isEmpty) {
      (await _getPreferences()).remove(_keyUserToken);
    } else {
      (await _getPreferences()).setString(_keyUserToken, token);
    }
  }

  /// Get [String] from the [SharedPreferences]
  Stream<String?> getString(String key) {
    return _getSharedPreference()
        .map((preference) => preference.getString(key));
  }

  /// Set [String] to the [SharedPreferences]
  Stream<bool> setString(String key, String value) {
    return _getSharedPreference().flatMap(
            (preference) => _convertToRx(preference.setString(key, value)));
  }

  Stream<SharedPreferences> _getSharedPreference() {
    return _convertToRx(_getPreferences());
  }

  Stream<T> _convertToRx<T>(Future<T> future) {
    return future.asStream();
  }
}
  """;

  static String splashScreen = """

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:{{package_name}}/app_screens/app_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () => _navigateToHome(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(

        child: Container(
          color: Colors.white,
          child: Center(
            child: SizedBox(
              width: 20,
              height: 20,
              child: Icon(Icons.home),
            ),
          ),
        ),
      ),
    );
  }
  void _navigateToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppScreens.login,
          (Route<dynamic> route) => false,
    );
  }

}

  """;

  static String mainDart = """
import 'package:flutter/material.dart';
import 'package:{{package_name}}/splash_screen/splash_screen.dart';
import 'package:{{package_name}}/utils/app_router.dart';
import 'package:{{package_name}}/utils/app_theme.dart';
import 'package:{{package_name}}/utils/app_dependencies.dart';

void main() {

  setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final AppRouter _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '{package_name} Template',
      theme: ThemeUtils.buildAppTheme(context),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      onGenerateRoute: _router.getRoute,
      navigatorObservers: [_router.routeObserver],
    );
  }
}
  """;

}
