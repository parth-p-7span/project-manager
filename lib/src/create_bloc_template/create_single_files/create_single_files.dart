import 'dart:io';
import 'package:mustache_template/mustache_template.dart';

import 'single_files_constant.dart';

class CreateSingleFiles{
  final String name;

  CreateSingleFiles(this.name);

  void createFiles() async {
    File('$name/lib/app_screens/app_screens.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(SingleFilesConstant.appScreens);
    });

    File('$name/lib/constants/app_constants.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(SingleFilesConstant.appConstants);
    });

    File('$name/lib/home/ui/home.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(SingleFilesConstant.homeUi);
    });

    File('$name/lib/preferences/preferences_manager.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(SingleFilesConstant.preferenceManager);
    });

    File('$name/lib/splash_screen/splash_screen.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(Template(SingleFilesConstant.splashScreen).renderString(
          {'package_name': name}));
    });

    await File('$name/lib/main.dart').writeAsString(
        Template(SingleFilesConstant.mainDart).renderString({'package_name': name}));
  }
}
