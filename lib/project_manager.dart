import 'package:interact/interact.dart';
import 'package:project_manager/src/create_bloc_module/bloc_file_generator.dart';
import 'package:project_manager/src/create_bloc_template/bloc_template_generator.dart';
import 'package:project_manager/src/create_riverpod_template/riverpod_template_generator.dart';

class Seven{
  static void create(String name) {
    var generator = BlocFileGenerator();
    generator.createFiles(name);
  }

  static void init() async {
    final name = Input(
      prompt: 'Project Name',
      validator: (String x) {
        if (x == "") {
          throw ValidationError('Not a valid name');
        } else {
          return true;
        }
      },
    ).interact();

    final architectures = ['BLoC', 'RiverPod'];

    final selection = Select(
      prompt: 'Select your project architecture',
      options: architectures,
    ).interact();

    switch (selection){
      case 0:
        var generator = BlocTemplateGenerator();
        generator.initProject(name);
        break;
      case 1:
        var generator = RiverPodTemplateGenerator();
        generator.initProject(name);
        break;
      default:
        break;
    }
  }
}