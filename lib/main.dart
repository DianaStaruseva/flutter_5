import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_5/screen.dart';

void main() async {
  final   SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  runApp( MyApp(sharedPreferences));
}


class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;
   MyApp(this.sharedPreferences,{super.key});

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      routes: {'/second':(context) =>  Screen(count: sharedPreferences.getInt("counter") ?? 0 )},
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home:  MyHomePage(sharedPreferences, title: '',),
    );
  }
}

class MyHomePage extends StatefulWidget {
   final SharedPreferences sharedPreferences;

  const MyHomePage(this.sharedPreferences,{super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String message="Значение";

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    await widget.sharedPreferences.setInt("counter", _counter);
     await widget.sharedPreferences.setString("message", message);
  }

String currenttext="";
  @override
  void initState()  { 
    _counter =  widget.sharedPreferences.getInt('counter') ?? 0 ;
     currenttext =  widget.sharedPreferences.getString('message') ?? '' ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.sharedPreferences.getString('message')??''),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
           
                FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
          ],
        ),
      ),
      floatingActionButton:  ElevatedButton(
                onPressed: () {
                  List<Object> 
                  toScreen=<Object>[];
                  toScreen.add(_counter);
                  toScreen.add(widget.sharedPreferences.getString('message')??'');

                    Navigator.pushNamed(context,"/second", arguments:  toScreen
                     );
                },
                child: Text('Перейти на страницу')), 
        
    );
  }
}
