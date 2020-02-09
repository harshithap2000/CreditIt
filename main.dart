import 'package:flutter/material.dart';
import 'package:payme/models/user.dart';
import 'package:payme/screens/wrapper.dart';
import 'package:payme/services/auth.dart';
import 'package:provider/provider.dart';


void main()=>runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value( //  providing stream of user type data from firebase to all its descendants 
      value: Authservice().user,
          child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}