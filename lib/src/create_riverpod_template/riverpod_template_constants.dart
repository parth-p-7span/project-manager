class RiverPodConstants {
  static String appConstants = """
class AppConstants {
  AppConstants._();

  static String baseUrl = "";
  static String apiKey = "";
}
  """;

  static String loginController = """

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{package_name}}/login/controller/login_states.dart';
import 'package:{{package_name}}/login/services/login_repository.dart';

class LoginController extends StateNotifier<LoginState> {
  LoginController(this.ref) : super(const LoginStateInitial());

  final Ref ref;

  void login(String email, String password) async {
    state = const LoginStateLoading();
    try {
      await ref.read(authRepositoryProvider).login(email, password);
      state = const LoginStateSuccess();
    } catch (e) {
      state = LoginStateError(e.toString());
    }
  }
}

final loginControllerProvider =
    StateNotifierProvider<LoginController, LoginState>(
        (ref) => LoginController(ref));

  """;

  static String loginStates = """
import 'package:equatable/equatable.dart';

class LoginState extends Equatable{
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginStateInitial extends LoginState {
  const LoginStateInitial();

  @override
  List<Object?> get props => [];
}

class LoginStateLoading extends LoginState {
  const LoginStateLoading();

  @override
  List<Object?> get props => [];
}

class LoginStateSuccess extends LoginState {
  const LoginStateSuccess();

  @override
  List<Object?> get props => [];
}

class LoginStateError extends LoginState {
  final String error;

  const LoginStateError(this.error);

  @override
  List<Object?> get props => [error];
}

  """;

  static String loginRepository = """
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{package_name}}/login/services/login_service.dart';

class LoginRepository {
  final LoginService _authService;

  LoginRepository(this._authService);

  Future<String> login(String email, String password) async {
    return _authService.login(email, password);
  }
}

final authRepositoryProvider = Provider<LoginRepository>(
    (ref) => LoginRepository(ref.read(loginServiceProvider)));
  """;

  static String loginService = """
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{package_name}}/provider/dio_provider.dart';

class LoginService {
  final Ref _ref;

  LoginService(this._ref);

  Future<String> login(String email, String password) async {
    /// TODO: login api call
    // final dio = _ref.watch(dioProvider);
    // final response = await dio.get('login', queryParameters: {});

    return Future.delayed(const Duration(seconds: 3))
        .then((value) => 'authToken');
  }
}

final loginServiceProvider = Provider<LoginService>((ref) => LoginService(ref));

  """;

  static String loginScreen = """
import 'package:flutter/material.dart';
import 'package:{{package_name}}/login/controller/login_controller.dart';
import 'package:{{package_name}}/utils/app_styles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(loginControllerProvider.notifier)
                      .login(emailController.text, passwordController.text);
                },
                child: const Text('Login'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

  """;

  static String dioProvider = """
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{package_name}}/constants/app_constants.dart';

final dioProvider = Provider <Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: AppConstants.baseUrl,
  ));
});
  
  """;

  static String routerProvider = """
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{package_name}}/login/controller/login_controller.dart';
import 'package:{{package_name}}/login/controller/login_states.dart';
import 'package:{{package_name}}/login/ui/login_screen.dart';
import 'package:{{package_name}}/ui/home_screen.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: router,
    routes: router._routes,
    redirect: router._redirectLogic,
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<LoginState>(
        loginControllerProvider, (previous, next) => notifyListeners());
  }

  String? _redirectLogic(GoRouterState state) {
    final loginState = _ref.read(loginControllerProvider);

    final areWeLoggingIn = state.location == '/login';

    if (loginState is LoginStateInitial) {
      return areWeLoggingIn ? null : '/login';
    }

    if (areWeLoggingIn) return '/';

    return null;
  }

  List<GoRoute> get _routes => [
        GoRoute(
            path: '/login',
            name: 'login',
            builder: (context, state) => const LoginScreen()),
        GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomeScreen()),
      ];
}

  """;

  static String homeScreen = """
import 'package:flutter/material.dart';
import 'package:{{package_name}}/utils/app_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppStyles.white,
      body: Center(
        child: Text('Home Page'),
      ),
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

  static String mainDart = """
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:{{package_name}}/provider/router_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter RiverPod Boilerplate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}

  """;
}
