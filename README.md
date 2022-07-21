![Pub Version](https://img.shields.io/pub/v/project_manager?style=plastic)  ![Dart Version](https://img.shields.io/badge/dart-v2.16.0-orange?style=plastic)

# project_manager
A command-line tool to generate painless dart code for bloc pattern in your flutter project.
Use `seven` command to perform operations.

## Installation

#### You can activate this using dart pub command

This is package is an independent library that is not linked to your project. So there's no need to add it to your
flutter project as it works as a global command line tool for all of your projects.

```shell
dart pub global activate project_manager
```

Run following command to add pub cache to system's environment/path variable. So that you can access `seven` command in every project.<br/>

<i>Note: You need to execute this command eveytime when you open new terminal.</i>

```shell
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

## Usage

#### Help Command - Run following command to see Help

```shell
seven --help
```

#### Create Command - Run following command to create template code for a module with `bloc` structure

```shell
seven create --name module_name
```

You can use --name OR -n before module name

<b>For Example:</b>
```shell
seven create --name feature-chat 
```
OR
```shell
seven create -n feature-chat
```

## Contributors


[Parth Panchal](https://www.linkedin.com/in/parthpanchal8401/)
<a href="https://twitter.com/hitchhickerrr" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/twitter.svg" alt="twitter_logo" height="18" width="28" /></a>
<a href="https://linkedin.com/in/parthpanchal8401" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="linedin_logo" height="18" width="28" /></a>

[Mukund Jogi](https://www.linkedin.com/in/mukund-a-jogi/)
<a href="https://twitter.com/mukundjogi" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/twitter.svg" alt="twitter_logo" height="18" width="28" /></a>
<a href="https://linkedin.com/in/mukund-a-jogi" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="linedin_logo" height="18" width="28" /></a>

[Milan Surelia](https://www.linkedin.com/in/milansurelia/)
<a href="https://twitter.com/milanpsurelia" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/twitter.svg" alt="twitter_logo" height="18" width="28" /></a>
<a href="https://linkedin.com/in/milansurelia" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="linedin_logo" height="18" width="28" /></a>


## Having Issues

File the Issue [here](https://github.com/parthp-7span/project-manager/issues)

## Looking to contribute to this package:

**🤘🏻 Great!**
Fork the [Repo](https://github.com/parthp-7span/project-manager), Update Code, Write a meaningful Commit Message, Send a PR. That's all you need to Contribute.

