import 'package:project_manager/src/bloc_file_generator.dart';

class Seven{
  static void create(String name) {
    var generator = BlocFileGenerator();
    generator.createFiles(name);
  }
}