import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'add_myday.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  final List<String> entries = <String>[
    'shopping',
    'go home',
    'work',
    'shopping',
    'go home',
    'work'
  ];

  final List<int> colorCodes = <int>[600, 500, 100];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SafeArea(
        child: Stack(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                  image: DecorationImage(
                      image: new AssetImage('assets/planning.jpg'),
                      fit: BoxFit.fitHeight)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 158, left: 8, right: 8),
            child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.circular(10),
                        color: Colors.black12,
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              width: 65,
                              height: 70,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          new AssetImage('assets/planning.jpg'),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Center(child: Text('${entries[index]}')),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(_createRoute());
          ;
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AddMyday(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
