import 'dart:io';
import 'package:mustache_template/mustache.dart';

import 'auth_constants.dart';
import 'package:project_manager/src/utils.dart';

class CreateAuthModule{
  final String name;

  CreateAuthModule(this.name);

  void createFiles(){
    File('$name/lib/auth/bloc/login_bloc.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(Template(AuthConstants.loginBloc).renderString({'package_name': name}));
    });

    File('$name/lib/auth/bloc/login_event.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(Template(AuthConstants.loginEvent).renderString({'package_name': name}));
    });

    File('$name/lib/auth/bloc/login_state.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(Template(AuthConstants.loginState).renderString({'package_name': name}));
    });

    File('$name/lib/auth/repository/login_repository.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(Template(AuthConstants.loginRepo).renderString({'package_name': name}));
    });

    File('$name/lib/auth/repository/login_repository_impl.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(Template(AuthConstants.loginRepoImpl).renderString({'package_name': name}));
    });

    File('$name/lib/auth/ui/login.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(Template(AuthConstants.loginUi).renderString({'package_name': name}));
    });
  }

}
