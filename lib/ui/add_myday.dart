import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_day/bloc/bloc.dart';
import 'package:my_day/model/model.dart';
import 'package:my_day/ui/home_page.dart';

class AddMyday extends StatefulWidget {
  @override
  _AddMydayState createState() => _AddMydayState();
}

class _AddMydayState extends State<AddMyday> {
  List<String> _allStatus = ['sad', 'normal', 'happy'];
  int _value = 1;
  File _image;
  var _place = new TextEditingController();
  var _description = new TextEditingController();
  final DiaryBloc diaryBloc = new DiaryBloc();

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add My Day'),
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Form(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: _image == null
                        ? IconButton(
                            icon: Icon(Icons.add_a_photo),
                            color: Colors.black,
                            onPressed: getImage,
                          )
                        : Container(
                            width: 100, height: 100, child: Image.file(_image)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List<Widget>.generate(
                        _allStatus.length,
                        (int index) {
                          return ChoiceChip(
                            label: Text(_allStatus[index]),
                            selected: _value == index,
                            onSelected: (bool selected) {
                              setState(() {
                                _value = selected ? index : null;
                              });
                            },
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8, top: 20),
                    child: TextFormField(
                      controller: _place,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.place),
                        hintText: 'Where did it happen?',
                        labelText: 'Where did it happened?',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8, left: 8, top: 20),
                    child: TextFormField(
                      controller: _description,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.info),
                        hintText: 'Describe what happended to you',
                        labelText: 'What happened?',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 50,
                    color: Colors.indigoAccent,
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.width * 0.15,
                        left: 8,
                        right: 8),
                    child: RaisedButton(
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: _updateToDatabase,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateToDatabase() {
    if (_image != null) {
      List<int> imageBytes = _image.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      print(base64Image);
      String _feeling;
      _value == null ? _feeling = 'no status' : _feeling = _allStatus[_value];
      final myDayModel = DiaryModel(
          description: _description.text,
          place: _place.text,
          feeling: _feeling,
          image: 'picture');
      diaryBloc.addDiary(myDayModel);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }
}
