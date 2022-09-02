import 'dart:io';

import 'package:interact/interact.dart';
import 'package:project_manager/src/create_bloc_module/bloc_file_generator.dart';
import 'package:project_manager/src/create_bloc_template/bloc_template_generator.dart';
import 'package:project_manager/src/create_riverpod_template/riverpod_template_generator.dart';
import 'package:project_manager/src/utils.dart';

class Seven {
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

    switch (selection) {
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

  static void boostNumber() async {
    final boostPattern = RegExp(
        r'((version:.)(\d*)\.(\d*)\.(\d*)\+?(\-(beta)?(alpha)?(dev)?\.)?)(\d*)');
    String pubspec = "";
    await File('pubspec.yaml').readAsString().then((String contents) {
      pubspec = contents;
    });
    pubspec = pubspec.replaceAllMapped(
        boostPattern,
        (match) => match[10]!.isEmpty
            ? '${match[1]}+1'
            : '${match[1]}${int.parse(match[10]!).plus()}');
    // print(pubspec);
    createFile('pubspec.yaml', pubspec);
  }

  static void boostVersion() async {
    final boostPattern = RegExp(
        r'(version:.\d*\.\d*\.)(\d*)(\+?(\-(beta)?(alpha)?(dev)?\.)?(\d*))');
    String pubspec = "";
    await File('pubspec.yaml').readAsString().then((String contents) {
      pubspec = contents;
    });
    pubspec = pubspec.replaceAllMapped(boostPattern,
        (match) => '${match[1]}${int.parse(match[2]!).plus()}${match[3]}');
    createFile('pubspec.yaml', pubspec);
  }
}

extension BoostInt on int {
  int plus() => this + 1;
}

void main() {
  Seven.boostVersion();
}
