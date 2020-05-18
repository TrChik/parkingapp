import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.blue[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[ 
            Container(
              color: Colors.blue[200],
              height: 80,
              padding: EdgeInsets.only(top: 40),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.black, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text('get listing'),
              onTap: () => {},
            ),
            ListTile(
              title: Text('reload'),
              onTap: () => {Navigator.of(context).pop()},
            )
          ],
        )
      )
    );
  }
}