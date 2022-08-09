import 'dart:io';
import 'package:mustache_template/mustache.dart';

import 'utils_constant.dart';
import 'package:project_manager/src/utils.dart';

class CreateUtilsFiles {
  final String name;

  CreateUtilsFiles(this.name);

  void createFiles() {
    createFile(
        '$name/lib/utils/app_dependencies.dart',
        Template(UtilsConstant.appDependencies)
            .renderString({'package_name': name}));

    createFile('$name/lib/utils/app_router.dart',
        Template(UtilsConstant.appRouter).renderString({'package_name': name}));

    createFile('$name/lib/utils/app_styles.dart',
        Template(UtilsConstant.appStyles).renderString({'package_name': name}));

    createFile('$name/lib/utils/app_theme.dart',
        Template(UtilsConstant.appTheme).renderString({'package_name': name}));
  }
}
