class AuthConstants{
  static String loginBloc = """
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{package_name}}/auth/repository/login_repository.dart';
import 'package:{{package_name}}/model/api_models/api_status.dart';
import 'package:get_it/get_it.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _loginRepository = GetIt.I<LoginRepository>();

  LoginBloc() : super(LoginState()) {
    on<PerformLoginEvent>(_performLogin);
  }

  void _performLogin(PerformLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginState(isLoading: true));
    final response = await _loginRepository.login(event.email, event.password);
    if (response.status == ApiStatus.success) {
      emit(LoginState(
        isCompleted: true,
      ));
    } else {
      emit(LoginState(error: response.error));
    }
  }
}

  """;

  static String loginEvent = """
abstract class LoginEvent {
  const LoginEvent();
}

class PerformLoginEvent extends LoginEvent {
  final String email;
  final String password;

  PerformLoginEvent({required this.email, required this.password});
}


  """;

  static String loginState = """
import 'package:{{package_name}}/model/api_models/api_error.dart';

class LoginState {
  final bool isLoading;
  final ApiError? error;
  final bool isCompleted;
  final bool isEmailVerified;

  LoginState({
    this.isLoading = false,
    this.error,
    this.isCompleted = false,
    this.isEmailVerified = false,
  });
}

  """;

  static String loginRepo = """
import 'package:{{package_name}}/model/api_models/api_response.dart';

abstract class LoginRepository {
  Future<ApiResponse> login(String email, String password);
}

  """;

  static String loginRepoImpl = """
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:{{package_name}}/api_client/api_utils.dart';
import 'package:{{package_name}}/model/api_models/api_response.dart';
import 'package:get_it/get_it.dart';

import 'login_repository.dart';


class LoginRepositoryImpl extends LoginRepository {
  final _dio = GetIt.I<Dio>();

  @override
  Future<ApiResponse> login(
      String email,
      String password,
      ) async {
    final requestData = jsonEncode({
      'email': email,
      'password': password,
    });
    try {
      final response = await _dio.post('/authaccount/login', data: requestData);
      return ApiResponse.success(data:response);
    } on DioError catch (error) {
      return ApiResponse.error(error: ApiUtils.getApiError(error));
    }
  }

}

  """;

  static String loginUi = """
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{package_name}}/auth/bloc/login_bloc.dart';
import 'package:{{package_name}}/auth/bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static Widget create() {
    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(),
      child: const LoginScreen(),
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isCompleted) {
            if (state.isEmailVerified) {
              // TODO: _navigateToHome(context);

            } else {
              // TODO: _navigateToVerifyEmail(context);
            }
          }
          // TODO: Show snackbar error
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  children: [

                  ],
                ),
              ),

            );
          },
        ),
      ),
    );
  }
}
  """;
}