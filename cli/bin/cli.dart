import 'dart:io';
import 'package:http/http.dart' as http;

const version = '0.0.1';


void main(List<String> arguments){
  if (arguments.isEmpty || arguments.first == "help"){
    printUsage();
  }else if (arguments.first == 'version'){
    print("dartpedia CLI version $version");
  }else if (arguments.first == "wikipedia"){
    // test this with "Flutter_(software)" or  "Dart_(programming_language)"
    // full-comand-line = dart run bin/cli.dart wikipedia "Dart_(programming_language)"

    final inputArgs = arguments.length > 1 ? arguments.sublist(1) : null;
    print(arguments.sublist(1));
    searchWikipedia(inputArgs);
  }else{
    printUsage();
  }
}

void printUsage(){
    print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'"
  );
}

void searchWikipedia(List<String>? arguments) async { // Add this new function and add ? to arguments type
  final String articleTitle;
  if (arguments == null || arguments.isEmpty){
    print("Please provide an article title.");
    final inputFromStdin = stdin.readLineSync();
    if(inputFromStdin ==null || inputFromStdin.isEmpty){
      print("No article title provided. Exiting.");
      return;
    }
    articleTitle = inputFromStdin;
  }else{
    articleTitle = arguments.join(" ");
  }
  print('Looking up articles about "$articleTitle". Please wait.');
  var articleContent = await getWikipediaArticle(articleTitle);
  print(articleContent);
}

Future<String> getWikipediaArticle (String articleTitle)async{
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle'
  );
  print(url);
  print("--------");
  final response = await http.get(url);

  if (response.statusCode == 200){
    return response.body;
  }
  return 'Error: Failed to fetch article "$articleTitle". Status code: ${response.statusCode}';
}