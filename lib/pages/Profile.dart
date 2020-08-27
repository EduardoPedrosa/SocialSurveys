import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({this.logout});
  final Function logout;

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  signOut() {
    try {
      widget.logout();
    } catch (e) {
      print(e);
    }
  }

  void _select(String choice) {
    if (choice == "Sair da conta") {
      signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text('Perfil'),
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: _select,
          itemBuilder: (BuildContext context) {
            return ["Sair da conta"].map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    ));
  }
}
