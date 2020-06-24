import 'file:///E:/developement/android/projects/flutter/crew_brew_app/lib/services/auth.dart';
import 'package:crewbrewapp/shared/constants.dart';
import 'package:crewbrewapp/shared/loading.dart';
import 'package:flutter/material.dart';


class SignIn extends StatefulWidget {

  final Function toggleView ;
  SignIn ({this.toggleView});



  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

    final AuthService _authService = AuthService();
    final _formkey = GlobalKey <FormState> ();

    String email = '' ;
    String password = '' ;
    String error = '' ;
    bool loading = false ;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('sign in to crew brew'),
        actions: <Widget>[
          FlatButton.icon(onPressed: (){
            widget.toggleView();
          },
              icon: Icon(Icons.person,
                  color: Colors.white),
              label:Text('Register',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),

      body: Container(

        padding: EdgeInsets.symmetric(vertical:20.0 ,horizontal:50.0 ),

        child: Form(

          key: _formkey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'email'),
                validator: (val) => val.isEmpty ? 'please enter a valid email ' : null,
                onChanged: (val){
                  setState(() => email=val);
                },
              ),

              SizedBox(height: 20.0),

              TextFormField(

                decoration: textInputDecoration.copyWith(hintText: 'password'),
                validator: (val) => val.length < 6 ? 'your password is not valid' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);
              },
              ),

              SizedBox(height:30.0),

              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async{

                  if(_formkey.currentState.validate()){

                    setState(() => loading = true);
                    dynamic result = await _authService.signInWithEmailAndPassword(email, password);

                    if (result == null){
                      setState(() => error = 'Failed to sign in');
                      loading = false ;
                    }
                  }
                },

              ),

              SizedBox(height: 35.0),

              Text(error,
                style: TextStyle (color: Colors.red,fontSize: 15.0),
              )


            ],


          ),


        ),

      ),

    );
  }
}
