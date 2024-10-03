import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/gradient_bg.dart';
import 'pages/login/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'You App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define your color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        // Use the color scheme to define the gradient colors
        extensions: [
          MyThemeExtension(
            gradientColors: [
              Color(0xFF1C3237),
              Color(0xFF0F1C22),
            ],
          ),
        ],
      ),
      home: MyHomePage(title: 'This is Home Page')
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<MyThemeExtension>()!;

    return GradientScaffold(
      title: widget.title.toString(),
      body:
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: themeExtension.gradientColors,
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
        
          child: 
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the LoginPage when the button is pressed
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text('Go to Login Page')
                  ),
                ],
              ),
            ),

        ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
