import 'dart:io';

import 'package:interact/interact.dart';

class RiverPodTemplateGenerator{
  void initProject(String name) async {

    final spinner = Spinner(
      icon: '✅',
      rightPrompt: (done) => done
          ? 'Gotcha, your project is created.'
          : 'Creating your project',
    ).interact();

    await Process.run('flutter', ['create', name]);
    await Process.run('flutter', ['pub', 'add', 'flutter_riverpod', 'go_router', 'equatable', 'dio'], workingDirectory: '${Directory.current.path}/$name');


    spinner.done();
  }
}
