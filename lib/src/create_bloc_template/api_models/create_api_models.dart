import 'dart:io';
import 'model_constant.dart';

class CreateApiModels{
  final String name;

  CreateApiModels(this.name);

  void createFiles(){
    File('$name/lib/model/api_models/api_error.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(ModelConstant.apiError);
    });

    File('$name/lib/model/api_models/api_response.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(ModelConstant.apiResponse);
    });

    File('$name/lib/model/api_models/api_status.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(ModelConstant.apiStatus);
    });
  }

}