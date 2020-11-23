import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/video_model.dart';
import './screens/video_detail.dart';
import './screens/video_list.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      title: new Text(
        'Welcome In SplashScreen',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      seconds: 8,
      navigateAfterSeconds: AfterSplash(),
      image: new Image.asset('assets/welcome.gif'),
      backgroundColor: Colors.black,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 150.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.white,
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ignore: missing_required_param
        ChangeNotifierProvider(
          builder: (_) => VideoProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Live Streaming',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: VideoList(),
        routes: {'/detail': (ctx) => VideoDetail()},
      ),
    );
  }
}
