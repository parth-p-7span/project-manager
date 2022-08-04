import 'dart:io';

import 'package:interact/interact.dart';
import 'package:project_manager/src/create_bloc_template/api_client/create_api_client.dart';
import 'package:project_manager/src/create_bloc_template/api_models/create_api_models.dart';
import 'package:project_manager/src/create_bloc_template/auth/create_auth_module.dart';
import 'package:project_manager/src/create_bloc_template/create_single_files/create_single_files.dart';
import 'package:project_manager/src/create_bloc_template/utils_generator/create_utils_files.dart';

class BlocTemplateGenerator{
  void initProject(String name) async {

    final spinner = Spinner(
      icon: '✅',
      rightPrompt: (done) => done
          ? 'Gotcha, your project is created.'
          : 'Creating your project',
    ).interact();

    await Process.run('flutter', ['create', name]);
    await Process.run('flutter', ['pub', 'add', 'rxdart', 'shared_preferences', 'flutter_bloc', 'dio', 'get_it', 'logger'], workingDirectory: '${Directory.current.path}/$name');

    CreateApiClient(name).createFiles();
    CreateUtilsFiles(name).createFiles();
    CreateApiModels(name).createFiles();
    CreateSingleFiles(name).createFiles();
    CreateAuthModule(name).createFiles();

    spinner.done();
  }
}
