import 'package:firebase_auth/firebase_auth.dart';
import 'package:payme/models/user.dart';
import 'package:payme/services/database.dart';
class Authservice
{
  final  FirebaseAuth _auth= FirebaseAuth.instance;
// create user object based on firebase User
User _userFromFirebaseUser(FirebaseUser user)
{
  return user !=null?User(uid: user.uid):null;
}

// auth change user stream
Stream<User> get user
{
  return _auth.onAuthStateChanged
  //.map((FirebaseUser user) => _userFromFirebaseUser(user)); 
               //or
     .map(_userFromFirebaseUser);           
}

  Future signInAnon() async
  { 
    try {
    AuthResult result= await _auth.signInAnonymously();
      FirebaseUser user= result.user;
      return _userFromFirebaseUser(user) ;
  } 
  catch (e) {
          print(e.toString());
          return null;
          }
      
  }
  Future registerWithEmail(String email,String password) async
  {
    try {
    AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user= authResult.user;

//create a new document for the user with the uid
await DatabaseService(uid:user.uid).updateuserdata("marriage","piyush",100);

    return _userFromFirebaseUser(user);
    
    } catch (e) {
      print(e.toString());
      return null;
    }

  }

Future signOut() async{
  try {
    return await _auth.signOut();
  } catch (e) {
    print(e.toString());
    return null; 
  }
}
Future signInWithEmail(String email,String password) async
  {
    try {
    AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user= authResult.user;
    return _userFromFirebaseUser(user);
    
    } catch (e) {
      print(e.toString());
      return null;
    }

  }


}