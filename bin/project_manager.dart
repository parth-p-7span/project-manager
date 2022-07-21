import 'dart:io';
import 'package:args/args.dart';
import 'package:logging/logging.dart';
import 'package:project_manager/src/args_parser.dart';
import 'package:project_manager/src/command_processor.dart';
import 'package:project_manager/src/utils.dart';

void main(List<String> arguments) {
  exitCode=0;

  final ArgResults? argResults = parseArguments(arguments);
  if (argResults == null) return;

  CommandProcessor().execute(argResults);
}


/// sets up logging for stacktrace and logs.
void setupLogging() {
  Logger.root.level = Level.INFO; // defaults to Level.INFO
  recordStackTraceAtLevel = Level.ALL;
  Logger.root.onRecord.listen((record) {
    if (record.level == Level.SEVERE) {
      stderr.writeln('[${record.level.name}] ${record.message}');
    } else {
      stdout.writeln('[${record.level.name}] ${record.message}');
    }
  });
}