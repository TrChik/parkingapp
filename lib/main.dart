

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// import 'package:parkingapp/widgets/sidemenu.dart';

import 'clientModel.dart';
import 'data.dart';



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
      title: '.lego parking app',
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
      appBar: AppBar(
        title: Text('.lego parking app'),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewRoute()),
                    );
                  },
                  color: Colors.blue[400],
                  child: Container(
                    padding: EdgeInsets.only(left: 120, right: 120),
                    child: Text('View list',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))
                  )
                )
              ),
              const SizedBox(height: 5),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ReserveRoute()),
                    );
                  },
                  color: Colors.blue[400],
                  child: Container(
                    padding: EdgeInsets.only(left: 100, right: 100),
                    child: Text('Reserve place',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))
                  )
                )
              )
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
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  'Info',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)
                                ),
                              )
                            ],
                          )
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.all(8),
                          title: Text(
                          '''The price of a place on weekdays – 7 UAH/h 
(from 12 o`clock to 15 - 8 UAH/h)

Place price on weekends – 10 UAH/ h
Season tickets:
• Month – 600 UAH
• 3 month- 1500 UAH
• Half year- 2800 UAH

For regular customers hourly discount – 2 UAH. 

The price of providing additional technical services 
(such as car washing, refuelling, etc.) - depending on the services provided.

Fine for a long delay in the parking lot – 300 UAH.''', 
                            maxLines: 20,
                            style: TextStyle(fontSize: 18)
                          )
                        ),
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

class ViewRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    double containerWidth = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: FutureBuilder<List<Client>>(
          future: DBProvider.db.getAllClients(),
          builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot){
            if(!snapshot.hasData) return Text('Loading...');
            if(snapshot.data.length == 0) DBProvider.db.fillDataBase(40);
            return Text('View list');
          }
        )
      ),
      body: Row(
        children: <Widget>[
          Container(
            color: Colors.green[100],
            width: containerWidth,
            child: FutureBuilder<List<Client>>(
              future: DBProvider.db.getFreeClients(),
              builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot){
                if(!snapshot.hasData){
                  return Container();
                }
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    Client item = snapshot.data[index];
                    return ListTile(
                      title: Text(item.id.toString())
                    );
                  },
                );
              }
            )
          ),
          Container(
            width: containerWidth,
            color: Colors.red[100],
            child: FutureBuilder<List<Client>>(
              future: DBProvider.db.getNotFreeClients(),
              builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot){
                if(!snapshot.hasData){
                  return Container();
                }
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    Client item = snapshot.data[index];
                    return ListTile(
                      title: Text(item.id.toString())
                    );
                  },
                );
              }
            )
          )
        ],
      ),
      );
  }
}

class ReserveRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => {
            Navigator.of(context).pop()
          }
        ),
        title: FutureBuilder<List<Client>>(
          future: DBProvider.db.getAllClients(),
          builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot){
            if(!snapshot.hasData) return Text('Loading...');
            if(snapshot.data.length == 0) DBProvider.db.fillDataBase(40);
            return Text('Place reservation');
          }
        )
      ),
      body: Column (
        children: <Widget>[
          FutureBuilder<List<Client>>(
            future: DBProvider.db.getAllClients(),
            builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot){
              return Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    padding: EdgeInsets.only(left: 30),
                    child: FreeDropDownList()
                  )
                ],
              );
            }
          )
        ],
      )
    );
  }
}

class FreeDropDownList extends StatefulWidget {
  FreeDropDownList({Key key}) : super(key: key);

  @override

  _FreeDropDownList createState() => _FreeDropDownList();
}

class _FreeDropDownList extends State<FreeDropDownList> {
  int dropdownValue = 1;

  @override
  Widget build(BuildContext context){
    return FutureBuilder<List<Client>>(
      future: DBProvider.db.getNotFreeClients(),
      builder: (BuildContext context, AsyncSnapshot<List<Client>> snapshot){
        if(!snapshot.hasData){
          return Center(
            child: Text('It appears no free places were found...')
          );
        }
        List<int> valueList;
        for(Client client in snapshot.data){
          valueList.add(client.id);
        }
        return DropdownButton<int>(
          
          value: dropdownValue,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.deepPurple),
          onChanged: (int newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: []
        );
      }
    );
    
  }
}