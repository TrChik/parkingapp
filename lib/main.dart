
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
        title: Text('trying get stuff to work here ok'),
      ),
      body: SizedBox.expand(
        child: DraggableScrollableSheet(
          initialChildSize: 0.05,
          minChildSize: 0.05,
          builder: (BuildContext context, ScrollController scrollController) {
          double scrollableSheetDragBarHeight = MediaQuery.of(context).size.height * 0.1;
            return ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
              child: Container(
                color: Colors.blue[100],
                child: ListView(
                  controller: scrollController,
                  children: <Widget>[
                    Container(
                      color: Colors.blue[600],
                      height: scrollableSheetDragBarHeight,      // here, you need to add that white cool thingie
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: scrollableSheetDragBarHeight/2,
                            child: Center(
                              child: Container(
                                width: 100,
                                height: scrollableSheetDragBarHeight/6,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  child: Container(
                                    color: Colors.black45,
                                  )
                                )
                              )
                            )
                          ),
                          Container(
                            height: scrollableSheetDragBarHeight/2,
                            padding: EdgeInsets.only(top: 7),
                            child: Text(
                              'Info',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)
                            ),
                          )
                        ],
                      )
                    ),
                    ListTile(title: Text('no')),
                  ]
                )
              )
            );
          },
        ),
      ),
    );
  }
}