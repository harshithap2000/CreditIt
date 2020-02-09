import 'package:flutter/material.dart';
import 'package:payme/home/brewtile.dart';
import 'package:payme/models/brew.dart';
import 'package:provider/provider.dart';
class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];
  //  brews.forEach((brew) {
  //    print(brew.name);
  //    print(brew.purpose);
  //    print(brew.amount); 
  //   });
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context,index)
      {
     return  BrewTile(brew: brews[index]);
      },
      
    );
  }
}