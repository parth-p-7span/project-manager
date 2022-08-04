import 'dart:io';
import 'package:mustache_template/mustache.dart';

import 'api_client_constants.dart';

class CreateApiClient {
  final String name;

  CreateApiClient(this.name);

  void createFiles() {
    File('$name/lib/api_client/api_utils.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(Template(ApiClientConstants.apiUtils)
          .renderString({'package_name': name}));
    });

    File('$name/lib/api_client/dio_client.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(Template(ApiClientConstants.dioClient)
          .renderString({'package_name': name}));
    });
  }
}
