import 'package:flutter/material.dart';

import 'package:parkingapp/widgets/sidemenu.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello?',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('try better'),
      ),
      body: SizedBox.expand(
        child: DraggableScrollableSheet(
          initialChildSize: 0.04,
          minChildSize: 0.04,
          builder: (BuildContext context, ScrollController scrollController) {
            return ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
                child: Container(
                    color: Colors.red[100],
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(title: Text('Item $index'));
                      },
                    )
                )
            );
            // return Container(
            //   color: Colors.blue[100],
            //   child: ListView.builder(
            //     controller: scrollController,
            //     itemCount: 25,
            //     itemBuilder: (BuildContext context, int index) {
            //       return ListTile(title: Text('Item $index'));
            //     },
            //   ),
            // );
          },
        ),
      ),
    );
  }
}