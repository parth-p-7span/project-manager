import 'dart:io';
import 'package:mustache_template/mustache.dart';

import 'utils_constant.dart';
import 'package:project_manager/src/utils.dart';

class CreateUtilsFiles{
  final String name;

  CreateUtilsFiles(this.name);

  void createFiles(){
    File('$name/lib/utils/app_dependencies.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(Template(UtilsConstant.appDependencies).renderString({'package_name': name}));
    });

    File('$name/lib/utils/app_router.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(Template(UtilsConstant.appRouter).renderString({'package_name': name}));
    });

    File('$name/lib/utils/app_styles.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(Template(UtilsConstant.appStyles).renderString({'package_name': name}));

    });

    File('$name/lib/utils/app_theme.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(Template(UtilsConstant.appTheme).renderString({'package_name': name}));
    });
  }

}