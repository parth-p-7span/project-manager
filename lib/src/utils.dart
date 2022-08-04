import 'dart:io';
import 'package:project_manager/src/constants.dart';
import 'package:project_manager/src/process_terminator.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as p;

void error(String msg, [StackTrace? stackTrace]) =>
    Logger('Seven').log(const Level('ERROR', 1100), msg, null, stackTrace);


/// Checks whether the directory in which the command has been fired is a
/// dart/flutter project or not. Exits with error message if it is not.
void checkFlutterProject() {
  var pubspecPath = p.join(Directory.current.path, 'pubspec.yaml');
  if (!File(pubspecPath).existsSync()) {
    stdout.writeln(ConsoleMessages.notFlutterProjectError);
    error(ConsoleMessages.notFlutterProjectError);
    exit(2);
  }
}

/// exits process with a message on command-line
void exitWith(String msg, [StackTrace? stackTrace]) {
  ProcessTerminator.getInstance().terminate(msg, stackTrace);
}
