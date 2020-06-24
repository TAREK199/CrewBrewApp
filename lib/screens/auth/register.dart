import 'package:crewbrewapp/shared/constants.dart';
import 'package:crewbrewapp/shared/loading.dart';
import 'package:flutter/material.dart';
import '../../services/auth.dart';



class Register extends StatefulWidget {

  final Function toggleView ; // passing this function in the constructor
  Register({this.toggleView});


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  final AuthService _authService = AuthService();
  final _formKey = GlobalKey <FormState>();

  String email = '';
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
            widget.toggleView(); // using widget and not (this) to call toggleview function
          },
              icon: Icon(Icons.person,
                         color: Colors.white),
              label:Text('Sign In',
                    style: TextStyle(color: Colors.white),
              ))
        ],

      ),

      body: Container(

        padding: EdgeInsets.symmetric(vertical:20.0 ,horizontal:50.0 ),

        child: Form(
          key: _formKey, // associating the global key with the form
          child: Column(

            children: <Widget>[

              SizedBox(height: 20.0),

              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'email'),
                validator: (val) => val.isEmpty ? 'Enter an Email ' : null,
                onChanged: (val){
                  setState(() => email = val);
                },
              ),

              SizedBox(height: 20.0),

              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'password'),
                validator: (val) => val.length < 6 ? 'Enter a password 6+ char' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);
                },
              ),

              SizedBox(height:30.0),

              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onPressed: () async{

                  if (_formKey.currentState.validate()){

                    setState(() => loading = true);
                    dynamic result = await _authService.registerWithEmailAndPassword(email, password);

                    if(result == null){
                      setState(() => error = 'please suply a valid email');
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
