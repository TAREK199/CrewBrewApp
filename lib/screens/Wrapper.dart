import 'package:crewbrewapp/models/User.dart';
import 'package:crewbrewapp/screens/auth/authenticate.dart';
import 'package:crewbrewapp/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    final user = Provider.of<User>(context);

    // return either home or auth

    if(user == null){
      return Authenticate();
    }else{
      return Home() ;
    }
  }
}
