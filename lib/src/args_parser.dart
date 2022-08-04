import 'package:args/args.dart';
import 'package:project_manager/src/utils.dart';

/// Parses command-line arguments and returns results
ArgResults? parseArguments(List<String> arguments) {
  final createParser = ArgParser()
    // ..addFlag('help', help: 'prints usage information.',abbr: 'h')
    ..addOption('name', help: 'Name of the bloc module', abbr: 'n');

  final parser = ArgParser()
    ..addCommand('create', createParser)
    ..addCommand('init')
    ..addFlag('help',
        abbr: 'h', help: 'prints usage information', negatable: false)
    ..addFlag('info', abbr: 'i', help: 'print library info', negatable: false);

  try {
    var result = parser.parse(arguments);
    return result;
  } on Error catch (e) {
    exitWith(
        'Invalid command input. see spider --help for info.', e.stackTrace);
    return null;
  }
}
