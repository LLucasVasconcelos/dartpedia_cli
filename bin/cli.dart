import 'dart:io';
import 'package:http/http.dart' as http;

const version = '0.0.1';


void main(List<String> arguments){
  if (arguments.isEmpty){
    print('Hello, Dart!');
  } else if (arguments.first == 'version'){
    print("dartpedia CLI version $version");
  
  }else if (arguments.first == "search"){
    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    print(arguments.sublist(1));
    searchWikipedia(inputArgs);
  }
  else{
    printUsage();
  }
}

void printUsage(){
    print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'"
  );
}

void searchWikipedia(List<String>? arguments) { // Add this new function and add ? to arguments type
  final String articleTitle;
  if (arguments == null || arguments.isEmpty){
    print("Please provide an article title.");
    articleTitle = stdin.readLineSync()?? '';
  }else{
    articleTitle = arguments.join(" ");
  }
  print('Looking up articles about "$articleTitle". Please wait.');
  print('Here ya go!');
  print('(Pretend this is an article about "$articleTitle")');
}