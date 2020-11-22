import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/video_model.dart';
import './screens/video_detail.dart';
import './screens/video_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
