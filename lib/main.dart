import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //int of hr, min and sec
  int hour = 0;
  int min = 0;
  int sec = 0;

  //for displaying time
  String timeToDisplay = '';

  //creating boolean for start and stop button
  bool started = true;
  bool stoped = true;

  //setting bool cancel timer
  bool cancelTimer = false;

  //creating an int for calculating time
  int timefortimer;
  //creating duration to pass in timer
  final dur = const Duration(seconds: 1);

  void start() {
    setState(() {
      started = false;
      stoped = false;
    });
  }

  //start and stop simple logic
  // void start() {
  //   //setting state of the boolean
  //   setState(() {
  //     started = false;
  //     stoped = false;
  //   });
  //   //getting time in seconds
  //   timefortimer = ((hour * 3600) + (min * 60) + sec);
  //   //timer
  //   Timer.periodic(dur, (Timer t) {
  //     //it is callback func
  //     //it is created to stop timer
  //     // Duration is 1 timer will be created after each second
  //     setState(() {
  //       if (timefortimer < 1 || cancelTimer == true) {
  //         t.cancel();
  //         Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => MyHomePage(),
  //             ));
  //       } else if (timefortimer < 60) {
  //         //condition if less than 60 sec are left
  //         int s = timefortimer;
  //         timeToDisplay = s.toString();
  //         timefortimer--; //it means timefortimer = timefortimer - 1
  //       } else if (timefortimer < 3600) {
  //         //condition if less than 60 min are left
  //         int m = timefortimer ~/ 60;
  //         int s = timefortimer - (m * 60);
  //         timeToDisplay = m.toString() + ':' + s.toString();
  //         timefortimer--; //it means timefortimer = timefortimer - 1
  //       } else {
  //         //it is for time in hrs is left
  //         int h = timefortimer ~/ 3600;
  //         int secOfMin = timefortimer - (h * 3600);
  //         int m = secOfMin ~/ 60;
  //         int s = secOfMin - (secOfMin * 60);
  //         timeToDisplay =
  //             h.toString() + ':' + m.toString() + ':' + s.toString();
  //         timefortimer--;
  //       }
  //     });
  //   });
  // }

  void stop() {
    setState(() {
      stoped = true;
      started = true;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    });
  }

  Widget timer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'HH',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: hour,
                      minValue: 0,
                      maxValue: 23,
                      listViewWidth: 60.0,
                      onChanged: (value) {
                        setState(() {
                          hour = value;
                        });
                      },
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'MM',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: min,
                      minValue: 0,
                      maxValue: 59,
                      listViewWidth: 60.0,
                      onChanged: (value) {
                        setState(() {
                          min = value;
                        });
                      },
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'SS',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    NumberPicker.integer(
                      initialValue: sec,
                      minValue: 0,
                      maxValue: 59,
                      listViewWidth: 60.0,
                      onChanged: (value) {
                        setState(() {
                          sec = value;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: started
                ? Text('')
                : CountdownFormatted(
                    duration: Duration(hours: hour, minutes: min, seconds: sec),
                    onFinish: () {
                      setState(() {
                        started = true;
                        stoped = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      });
                    },
                    builder: (BuildContext ctx, String remaining) {
                      return Text(
                        remaining,
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ); // 01:00:00
                    },
                  ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: 35.0,
                    vertical: 12.0,
                  ),
                  onPressed: started ? start : null,
                  child: Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(
                    horizontal: 35.0,
                    vertical: 12.0,
                  ),
                  onPressed: stoped ? null : stop,
                  child: Text(
                    'Stop',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //removed stopwatch

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Watch',
          ),
          bottom: TabBar(
            tabs: [
              Text('Timer'),
              Text('StopWatch'),
            ],
            labelStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
            labelPadding: EdgeInsets.only(
              bottom: 10.0,
            ),
            unselectedLabelColor: Colors.white60,
          ),
        ),
        body: TabBarView(children: [timer(), Text('Stop')]),
      ),
    );
  }
}
