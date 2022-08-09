import 'dart:io';
import 'package:mustache_template/mustache.dart';
import 'package:project_manager/src/utils.dart';

import 'api_client_constants.dart';

class CreateApiClient {
  final String name;

  CreateApiClient(this.name);

  void createFiles() {
    createFile(
        '$name/lib/api_client/api_utils.dart',
        Template(ApiClientConstants.apiUtils)
            .renderString({'package_name': name}));

    createFile(
        '$name/lib/api_client/dio_client.dart',
        Template(ApiClientConstants.dioClient)
            .renderString({'package_name': name}));
  }
}
