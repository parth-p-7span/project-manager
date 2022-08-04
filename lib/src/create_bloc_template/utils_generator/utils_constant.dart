class UtilsConstant{
  static String appDependencies = """
import 'package:dio/dio.dart';
import 'package:{{package_name}}/api_client/dio_client.dart';
import 'package:{{package_name}}/auth/repository/login_repository.dart';
import 'package:{{package_name}}/auth/repository/login_repository_impl.dart';
import 'package:{{package_name}}/preferences/preferences_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final GetIt _getIt = GetIt.instance;

void setupDependencies() {
  // Logger
  _getIt.registerSingleton<Logger>(Logger());

  // Preference Manager
  _getIt.registerSingleton<PreferencesManager>(PreferencesManager());

  // DIO HTTP Client
  _getIt.registerSingleton<Dio>(DioClient().getDio());

  // Login
  _getIt.registerSingleton<LoginRepository>(LoginRepositoryImpl());
}
  """;

  static String appRouter = """
import 'package:flutter/material.dart';
import 'package:{{package_name}}/app_screens/app_screens.dart';
import 'package:{{package_name}}/auth/ui/login.dart';

class AppRouter {
  final RouteObserver<PageRoute> routeObserver;

  AppRouter() : routeObserver = RouteObserver<PageRoute>();


  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppScreens.login:
        return _buildRoute(
          settings,
          LoginScreen.create(),
        );
      default:
        return _buildRoute(settings, Container());
    }
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) => builder,
    );
  }

}
  """;

  static String appStyles = """
import 'package:flutter/material.dart';

class AppStyles{

  static const white = Color(0xffffffff);
  static const black = Color(0xff000000);
}
  """;

  static String appTheme = """
import 'package:flutter/material.dart';
import 'package:{{package_name}}/utils/app_styles.dart';

class ThemeUtils {
  ThemeUtils._();

  static ThemeData buildAppTheme(BuildContext context) {
    ThemeData theme = ThemeData();

    theme = theme.copyWith(
      appBarTheme: _appBarTheme(theme),
      elevatedButtonTheme: _elevatedButtonTheme(theme),
      outlinedButtonTheme: _outlinedButtonTheme(theme),
      textButtonTheme: _textButtonTheme(theme),
      inputDecorationTheme: _inputDecorationTheme(theme),
      tabBarTheme: _tabBarTheme(theme),
      scaffoldBackgroundColor: AppStyles.black,
    );

    return theme;
  }

  static AppBarTheme _appBarTheme(ThemeData theme) {
    return theme.appBarTheme.copyWith();
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(ThemeData theme) {
    return ElevatedButtonThemeData();
  }

  static OutlinedButtonThemeData _outlinedButtonTheme(ThemeData theme) {
    return OutlinedButtonThemeData();
  }

  static TextButtonThemeData _textButtonTheme(ThemeData theme) {
    return TextButtonThemeData();
  }

  static InputDecorationTheme _inputDecorationTheme(ThemeData theme) {
    return InputDecorationTheme();
  }

  static TabBarTheme _tabBarTheme(ThemeData theme) {
    return TabBarTheme();
  }
}
  """;
}