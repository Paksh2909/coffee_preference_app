import 'package:brewcrew/screens/home/settings_form.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/models/brew.dart';

class BrewTile extends StatelessWidget {

  final Brew brew;

  BrewTile({this.brew});

  @override
  Widget build(BuildContext context) {

    void _showSettings() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          onTap: () => _showSettings(),
          leading: CircleAvatar(
            backgroundImage: AssetImage("assets/coffee_icon.png"),
            radius: 25,
            backgroundColor: Colors.brown[brew.strength],
          ),
          title: Text(brew.name),
          subtitle: Text("Takes ${brew.sugars} sugar(s)"),
        ),
      ),
    );
  }
}

