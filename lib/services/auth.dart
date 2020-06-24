import 'package:crewbrewapp/models/User.dart';
import 'package:crewbrewapp/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


 class AuthService {

     final FirebaseAuth _auth = FirebaseAuth.instance ;


     // auth change user stream
     Stream <User> get user {
       return _auth.onAuthStateChanged
       //     .map((FirebaseUser user) => _userFromFirebaseUser(user)); // map this user with a stream of users
              .map(_userFromFirebaseUser); // the same meaning
     }

     User _userFromFirebaseUser(FirebaseUser user){
       return user != null ? User(uid: user.uid) : null;
     }

     //  sign in anon
     Future signInAnon () async{
       try{
         AuthResult result = await _auth.signInAnonymously();
         FirebaseUser user = result.user ;

         return _userFromFirebaseUser(user);

       } catch(e){
         print(e.toString());
         return null ;
       }
     }

 // sign in with email and password

     Future signInWithEmailAndPassword(String email , String password) async{
       try{
         AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
         FirebaseUser user = result.user ;
         return _userFromFirebaseUser(user);
       }
       catch(e){
         print(e.toString());
         return null ;
       }

     }
 // register with email and password

     Future registerWithEmailAndPassword(String email , String password) async{

       try{
         AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
         FirebaseUser user = result.user ; // grap the user from this result  ( firebase user )

         // create new document fo the user with uid

         await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);

         return _userFromFirebaseUser(user) ; // turn a firebase user to a regular user
       }
       catch(e){

         print(e.toString());
         return null ;

       }
     }

 // sign out
   Future signOut () async{

       try{
         return await _auth.signOut();
       }catch(e){

         print(e.toString());
         return null ;
       }
   }





 }
