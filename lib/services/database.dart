import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crewbrewapp/models/User.dart';
import 'package:crewbrewapp/models/brew.dart';


class DatabaseService {
  
  
  final String uid ;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');



  // update document in firestore or create new one if it dosnt exist
  Future updateUserData (String sugars,String name , int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name' : name,
      'strength' : strength,
    });
  }

  // brew list from snapshot to convert it into brew list object

  List<Brew> _brewListFromSnapshot (QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew (
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? 0,
        strength: doc.data['strength'] ?? '0',
      );
    }).toList(); // to convert it from iterator to list
  }

  UserData _userDataFromSnapshot (DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
    );
  }

  // get brews stream ===> listen to firestore and notify us about any changements in docs
  Stream <List<Brew>> get brews {
    return brewCollection.snapshots()
    .map(_brewListFromSnapshot);
  }

  // get user doc stream

  Stream <UserData> get userData {
    return brewCollection.document(uid).snapshots()
    .map(_userDataFromSnapshot)
    ;
  }

}