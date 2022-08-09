class HelpManuals {
  static const CREATE_HELP = '''

seven create [arguments]
  creates boiler plate files of bloc pattern in provided path.
  
  ARGUMENTS:
  -N, --name            Name of your bloc module.
  -H, --help            Show usage
''';

  static const SEVEN_HELP = '''

Seven CLI Tool
  Seven is a command-line tool to maintain and generate painless dart code for your flutter project.
     
  COMMANDS:  
  create                Creates boiler plate code for given bloc module name
  init                  Creates fresh, realtime flutter boiler plate project
  boost                 Updates project version
  
  GLOBAL ARGUMENTS:
  -H, --help            Show usage
  -I, --info            Show info
''';

  static const BOOST_HELP = '''

seven boost [arguments]
  Update the project version.
  
  ARGUMENTS:
  -N, --number            Increment the project build number
  -V, --version           Increment the project patch version
  -H, --help              Show usage
''';
}
