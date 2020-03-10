import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_day/bloc/bloc.dart';
import 'package:my_day/model/model.dart';

import 'add_myday.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final DiaryBloc diaryBloc = new DiaryBloc();
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new SafeArea(child: _getDiary(context)),
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
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _getDiary(context) {
    return StreamBuilder(
      stream: DiaryBloc().diary,
      builder:
          (BuildContext context, AsyncSnapshot<List<DiaryModel>> snapshot) {
        return getDiaryCardWidget(snapshot, context);
      },
    );
  }

  Widget getDiaryCardWidget(AsyncSnapshot<List<DiaryModel>> snapshot, context) {
    if (snapshot.hasData) {
      return Stack(children: <Widget>[
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
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                DiaryModel diary = snapshot.data[index];
                String imageinbase64 = diary.image;
                var _image = base64Decode(imageinbase64.toString());
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
                            child: Image.memory(_image),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Center(child: Text('${diary.description}')),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ]);
    } else {
      return Center(child: loadingData());
    }
  }

  Widget loadingData() {
    diaryBloc.getDiary();
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Loading...",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  dispose() {
    print('dispose');
    diaryBloc.dispose();
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
