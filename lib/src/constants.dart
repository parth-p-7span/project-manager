class Constants {
  static const String INFO = '''

SEVEN:
  A small dart command-line tool to maintain and generate painless dart code for your flutter project.
  
  AUTHOR            7Span (https://7span.com)
  HOMEPAGE          https://github.com/parthp-7span/seven-dart-package
  SDK VERSION       2.6
  
  see seven --help for more available commands.
''';

  static const String SUCCESS = '''
  ✅ Gotcha....All files generated successfully :)
  ''';

  static const String VERSION_UPDATED = '''
  ✅ Project version successfully updated.
  ''';
}

class ConsoleMessages {
  static const String notFlutterProjectError =
      'Current directory is not flutter project. Please execute '
      'this command in a flutter project root path.';

  static const String INVALID_ARGS = '''
  Could not find command.
  
  Use `seven -H` or `seven <command> -H` for more information.  ''';
}
