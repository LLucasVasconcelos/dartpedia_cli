import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:collection';
import 'arguments.dart';

class CommandRunner {
  final Map<String, Command> _commands = <String, Command>{};

  UnmodifiableSetView<Command> get commands =>
      UnmodifiableSetView<Command>(<Command>{..._commands.values});

  Future<void> run(List<String> input) async {
    final ArgResults results = parse(input);
    if (results.command != null) {
      Object? output = await results.command!.run(results);
      print(output.toString());
    }
  }

  void addCommand(Command command) {
    _commands[command.name] = command;
    command.runner = this;
  }

  ArgResults parse(List<String> input) {
    var results = ArgResults();
    results.command = _commands[input.first];
    return results;
  }

  // Returns usage for the executable only.
  // Should be overridden if you aren't using [HelpCommand]
  // or another means of printing usage.
  // final String version = "0.0.1";

  String get usage {
    final exeFile = Platform.script.path.split('/').last;
    return "usage: dart bin/$exeFile <command> [commandArg?] [...options?]";
  }
}

/// this Above is the test with another type of code.
// { 
  // /// Runs the command-line application logic with the given arguments.

  // Future<void> run(List<String> arguments) async {
  //   if (arguments.isEmpty || arguments.first == "help") {
  //     _printUsage();
  //   } else if (arguments.first == 'version') {
  //     print("dartpedia CLI version $version");
  //   } else if (arguments.first == "wikipedia") {
  //     // test this with "Flutter_(software)" or  "Dart_(programming_language)"
  //     // full-comand-line = dart run bin/cli.dart wikipedia "Dart_(programming_language)"

  //     final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
  //     print(arguments.sublist(1));
  //     _searchWikipedia(inputArgs);
  //   } else {
  //     _printUsage();
  //   }
  // }

  // Future<void> _printUsage() async {
  //   print("send a command");
  // }

  // Future<void> _searchWikipedia(List<String>? arguments) async {
  //   // Add this new function and add ? to arguments type
  //   final String articleTitle;
  //   if (arguments == null || arguments.isEmpty) {
  //     print("Please provide an article title.");
  //     final inputFromStdin = stdin.readLineSync();
  //     if (inputFromStdin == null || inputFromStdin.isEmpty) {
  //       print("No article title provided. Exiting.");
  //       return;
  //     }
  //     articleTitle = inputFromStdin;
  //   } else {
  //     articleTitle = arguments.join(" ");
  //   }
  //   print('Looking up articles about "$articleTitle". Please wait.');
  //   var articleContent = await getWikipediaArticle(articleTitle);
  //   print(articleContent);
  // }

  // Future<String> getWikipediaArticle(String articleTitle) async {
  //   final url = Uri.https(
  //     'en.wikipedia.org',
  //     '/api/rest_v1/page/summary/$articleTitle',
  //   );
  //   print(url);
  //   print("--------");
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     return response.body;
  //   }
  //   return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
  // }
// }
