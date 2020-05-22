
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
          initialChildSize: 0.02,
          minChildSize: 0.02,
          builder: (BuildContext context, ScrollController scrollController) {
          double scrollableSheetDragBarHeight = MediaQuery.of(context).size.height * 0.1;
            return ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20,), topRight: Radius.circular(20.0)),

              child: Container(


                color: Colors.blue[100],
                child: ListView(
             controller: scrollController,
                  children: <Widget>[
                    Container( // нашей кнопкой будет контейнер
                      decoration: BoxDecoration( // стилизуем контейнер
                        shape: BoxShape.circle, // зададим ему круглую форму
                        color: Color(0xFF17A2B8), // и покрасим его в синий
                      ),
                      width: 20.0,
                      height: 20.0,
                    ),
                    Container(
                      color: Colors.blue[600],
                      height: scrollableSheetDragBarHeight  ,    // here, you need to add that white cool thing

                      child:Center(

                    child: Text('info'),
                      ),

            ),

                    ListTile(title: Text('nein')),

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