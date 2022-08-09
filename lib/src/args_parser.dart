import 'dart:io';

import 'package:args/args.dart';
import 'package:project_manager/src/constants.dart';
import 'package:project_manager/src/utils.dart';

/// Parses command-line arguments and returns results
ArgResults? parseArguments(List<String> arguments) {
  final createParser = ArgParser()
    ..addFlag('help', help: 'prints usage of create command', abbr: 'H')
    ..addOption('name', help: 'Name of the bloc module', abbr: 'N');

  final boostParser = ArgParser()
    ..addFlag('help', help: 'prints usage of boost command', abbr: 'H')
    ..addFlag('number', abbr: 'N', help: 'Increase build number of project')
    ..addFlag('version', abbr: 'V', help: 'Increase project version');

  final parser = ArgParser()
    ..addCommand('create', createParser)
    ..addCommand('init')
    ..addCommand('boost', boostParser)
    ..addFlag('help',
        abbr: 'H', help: 'prints usage information', negatable: false)
    ..addFlag('info', abbr: 'I', help: 'print library info', negatable: false);

  try {
    var result = parser.parse(arguments);
    return result;
  } catch (e) {
    stdout.writeln(ConsoleMessages.INVALID_ARGS);
  }
}
