import 'dart:io';
import 'package:mustache_template/mustache.dart';

import 'auth_constants.dart';
import 'package:project_manager/src/utils.dart';

class CreateAuthModule {
  final String name;

  CreateAuthModule(this.name);

  void createFiles() {
    createFile('$name/lib/auth/bloc/login_bloc.dart',
        Template(AuthConstants.loginBloc).renderString({'package_name': name}));

    createFile(
        '$name/lib/auth/bloc/login_event.dart',
        Template(AuthConstants.loginEvent)
            .renderString({'package_name': name}));

    createFile(
        '$name/lib/auth/bloc/login_state.dart',
        Template(AuthConstants.loginState)
            .renderString({'package_name': name}));

    createFile('$name/lib/auth/repository/login_repository.dart',
        Template(AuthConstants.loginRepo).renderString({'package_name': name}));

    createFile(
        '$name/lib/auth/repository/login_repository_impl.dart',
        Template(AuthConstants.loginRepoImpl)
            .renderString({'package_name': name}));

    createFile('$name/lib/auth/ui/login.dart',
        Template(AuthConstants.loginUi).renderString({'package_name': name}));
  }
}
