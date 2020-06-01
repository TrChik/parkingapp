
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:parkingapp/widgets/sidemenu.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                color: Colors.black,
                child: Image.asset(
                  'images/imagescheme.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: RaisedButton(
                  onPressed: () {},
                  color: Colors.blue[400],
                  child: Container(
                    padding: EdgeInsets.only(left: 100, right: 100),
                    child: Text('View list')
                  )
                )
              ),
            ],
          ),
          SizedBox.expand(
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
                          height: scrollableSheetDragBarHeight,      
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
        ],
      )
    );
  }
}