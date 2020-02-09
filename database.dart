import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:payme/models/brew.dart';
import 'package:payme/models/user.dart';
class DatabaseService
{
final String uid;
DatabaseService(
  {
    this.uid
  }
);
  final CollectionReference brewCollection=Firestore.instance.collection("brews");
     
     Future updateuserdata(String purpose,String name,int amount) async{

          return await brewCollection.document(uid).setData(
            {
               "purpose":purpose,
               "name":name,
               "amount":amount,
            }
          );
     }
     // 

//brew list from snapshot
List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot)
{
  return snapshot.documents.map((doc)
  {
    return Brew(
      name: doc.data["name"] ?? "",
      amount: doc.data['amount'] ?? 0,
      purpose: doc.data["purpose"] ??  "",
    );
  }).toList();
}
// userdata from snapshot
UserData _userDataFromSnapshot(DocumentSnapshot snapshot)
{
return UserData(
  uid: uid,
  name: snapshot.data["name"],
  purpose: snapshot.data["purpose"],
  amount:snapshot.data["name"],
  
);
}

     //getting brews stream
     Stream<List<Brew>> get brews
     {
       return brewCollection.snapshots().map(_brewListFromSnapshot);
     }
     // get user document stream
     Stream <UserData> get userData
     {
       return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
     }
}