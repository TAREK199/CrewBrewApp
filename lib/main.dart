import 'file:///E:/developement/android/projects/flutter/crew_brew_app/lib/services/auth.dart';
import 'package:crewbrewapp/models/User.dart';
import 'package:crewbrewapp/screens/Wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    
    return StreamProvider <User>.value(
      value: AuthService().user, // to specify wish stream we want to listen
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}


