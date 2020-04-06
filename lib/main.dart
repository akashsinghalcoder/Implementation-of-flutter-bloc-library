import 'package:bloc_pattern/CounterBloc.dart';
import 'package:bloc_pattern/CounterEvents.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  CounterBloc counterBloc = CounterBloc();

  void listener(Stream<int> stream) async {
    await for (int value in stream) {
      setState(() {
        _counter = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Stream<int> stream = counterBloc.mapStateToEvent();
    listener(stream);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            RaisedButton(
              onPressed: () => counterBloc.addEvent(CounterIncrementEvent()),
              child: Text('+', style: Theme.of(context).textTheme.display1),
            ),
            RaisedButton(
                onPressed: () => counterBloc.addEvent(CounterDecrementEvent()),
                child: Text('-', style: Theme.of(context).textTheme.display1))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
