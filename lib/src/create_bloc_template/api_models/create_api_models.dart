import 'dart:io';
import 'model_constant.dart';
import 'package:project_manager/src/utils.dart';

class CreateApiModels{
  final String name;

  CreateApiModels(this.name);

  void createFiles(){

    createFile('$name/lib/model/api_models/api_error.dart', ModelConstant.apiError);

    createFile('$name/lib/model/api_models/api_response.dart', ModelConstant.apiResponse);

    createFile('$name/lib/model/api_models/api_status.dart', ModelConstant.apiStatus);

  }

}