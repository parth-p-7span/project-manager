import 'dart:io';
import 'package:mustache_template/mustache_template.dart';
import 'package:project_manager/src/utils.dart';

import 'single_files_constant.dart';

class CreateSingleFiles {
  final String name;

  CreateSingleFiles(this.name);

  void createFiles() async {
    createFile('$name/lib/app_screens/app_screens.dart',
        SingleFilesConstant.appScreens);

    createFile('$name/lib/constants/app_constants.dart',
        SingleFilesConstant.appConstants);

    createFile('$name/lib/home/ui/home.dart', '$name/lib/home/ui/home.dart');

    createFile('$name/lib/preferences/preferences_manager.dart',
        SingleFilesConstant.preferenceManager);

    createFile(
        '$name/lib/splash_screen/splash_screen.dart',
        Template(SingleFilesConstant.splashScreen)
            .renderString({'package_name': name}));

    createFile(
        '$name/lib/main.dart',
        Template(SingleFilesConstant.mainDart)
            .renderString({'package_name': name}));
  }
}
