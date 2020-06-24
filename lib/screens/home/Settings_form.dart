import 'package:crewbrewapp/models/User.dart';
import 'package:crewbrewapp/services/database.dart';
import 'package:crewbrewapp/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:crewbrewapp/shared/constants.dart';
import 'package:provider/provider.dart';


class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  // form value
  String _currentName ;
  String _currentSugars ;
  int _currentStrength ;


  @override
  Widget build(BuildContext context) {


    final user = Provider.of<User>(context);


    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) { // this snqpshot is not reffering to data from firebase

        if(snapshot.hasData){

          UserData userData = snapshot.data ;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Update your brews',
                    style: TextStyle(fontSize: 18.0)),

                SizedBox(height: 20.0),

                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'please enter name' : null,
                  onChanged: (val) => setState( ()=> _currentName = val ),
                ),

                SizedBox(height: 20.0),
                // drop down
                DropdownButtonFormField(

                    value: _currentSugars ?? userData.sugars,
                    decoration: textInputDecoration,
                    items: sugars.map((sugar){
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar Sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState (() => _currentSugars = val)
                ),
                SizedBox(height: 20.0),

                Slider(
                  value: (_currentStrength ?? userData.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? userData.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? userData.strength],
                  min: 100.0,
                  max: 800.0,
                  divisions: 8,
                  onChanged: (val) => setState( () => _currentStrength = val.round()),
                ),

                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),

                  onPressed: () async {

                    if(_formKey.currentState.validate()){

                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? userData.sugars ,
                        _currentName ?? userData.name,
                        _currentStrength ?? userData.strength
                      );
                      Navigator.pop(context);
                    }

                  },
                ),

              ],
            ),

          );

        }else{

          return Loading();
        }


      }
    );
  }
}
