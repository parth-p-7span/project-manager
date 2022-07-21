import 'dart:io';

import 'package:args/args.dart';
import 'package:project_manager/src/constants.dart';
import 'package:project_manager/src/help_menuals.dart';
import 'package:project_manager/src/utils.dart';
import 'package:project_manager/project_manager.dart';


class CommandProcessor {
  void execute(ArgResults rootCommand){
    if (rootCommand.command == null) {
      processArgs(rootCommand.arguments);
    } else {
      switch (rootCommand.command!.name) {
        case 'create':
          processCreateCommand(rootCommand.command!);
          break;
        default:
          stdout.writeln('No command found. Use seven --help to see available commands');
          break;
          // exitWith(
          //     'No command found. Use Spider --help to see available commands');
      }
    }
  }

  void processArgs(List<String> arguments) {
    if (arguments.hasArg('help', 'h')) {
      stdout.writeln(HelpManuals.SEVEN_HELP);
    } else if (arguments.hasArg('info', 'i')) {
      printInfo();
    } else {
      stdout.writeln(HelpManuals.SEVEN_HELP);
    }
  }

  /// CREATE COMMAND
  void processCreateCommand(ArgResults command) async {
    checkFlutterProject();
    if (command.arguments.hasArg('help', 'h')) {
      stdout.writeln(HelpManuals.CREATE_HELP);
    } else {
      var name = command['name'];
      Process.runSync('flutter', ['pub', 'add', 'rxdart']);
      Seven.create(name);
      stdout.writeln(Constants.SUCCESS);
    }
  }

  void printInfo() => stdout.writeln(Constants.INFO);

}

extension ArgExtension on List<String> {
  bool hasArg(String flag, String abbr) {
    return contains('--$flag') || contains('-$abbr');
  }
}