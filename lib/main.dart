import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'pages/HomePage.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color.fromARGB(255, 72, 139, 207)),
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
