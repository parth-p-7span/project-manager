import 'dart:io';

import 'package:interact/interact.dart';
import 'package:project_manager/src/create_riverpod_template/riverpod_template_constants.dart';
import 'package:project_manager/src/utils.dart';
import 'package:mustache_template/mustache.dart';

class RiverPodTemplateGenerator {
  void initProject(String name) async {
    final spinner = Spinner(
      icon: '✅',
      rightPrompt: (done) =>
          done ? 'Gotcha, your project is created.' : 'Creating your project',
    ).interact();

    await Process.run('flutter', ['create', name]);
    await Process.run('flutter',
        ['pub', 'add', 'flutter_riverpod', 'go_router', 'equatable', 'dio'],
        workingDirectory: '${Directory.current.path}/$name');

    createFile(
        '$name/lib/constants/app_constants.dart',
        Template(RiverPodConstants.appConstants)
            .renderString({'package_name': name}));

    createFile(
        '$name/lib/login/controller/login_controller.dart',
        Template(RiverPodConstants.loginController)
            .renderString({'package_name': name}));

    createFile(
        '$name/lib/login/controller/login_states.dart',
        Template(RiverPodConstants.loginStates)
            .renderString({'package_name': name}));

    createFile(
        '$name/lib/login/services/login_repository.dart',
        Template(RiverPodConstants.loginRepository)
            .renderString({'package_name': name}));

    createFile(
        '$name/lib/login/services/login_service.dart',
        Template(RiverPodConstants.loginService)
            .renderString({'package_name': name}));

    createFile(
        '$name/lib/login/ui/login_screen.dart',
        Template(RiverPodConstants.loginScreen)
            .renderString({'package_name': name}));

    createFile(
        '$name/lib/provider/dio_provider.dart',
        Template(RiverPodConstants.dioProvider)
            .renderString({'package_name': name}));

    createFile(
        '$name/lib/provider/router_provider.dart',
        Template(RiverPodConstants.routerProvider)
            .renderString({'package_name': name}));

    createFile(
        '$name/lib/ui/home_screen.dart',
        Template(RiverPodConstants.homeScreen)
            .renderString({'package_name': name}));

    createFile(
        '$name/lib/utils/app_styles.dart',
        Template(RiverPodConstants.appStyles)
            .renderString({'package_name': name}));

    createFile(
        '$name/lib/utils/app_theme.dart',
        Template(RiverPodConstants.appTheme)
            .renderString({'package_name': name}));

    createFile(
        '$name/lib/main.dart',
        Template(RiverPodConstants.mainDart)
            .renderString({'package_name': name}));

    spinner.done();
  }
}

void main() {
  RiverPodTemplateGenerator().initProject('parth');
}
