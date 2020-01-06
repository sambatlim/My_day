import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          _addNewToday(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

Widget _header() {
  return Container(
    decoration: BoxDecoration(),
  );
}

void _addNewToday(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return new Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(10.0),
                  topRight: const Radius.circular(10.0))),
        );
      });
}
