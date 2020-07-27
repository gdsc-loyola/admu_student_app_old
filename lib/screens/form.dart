import 'package:flutter/material.dart';

class DataForm extends StatefulWidget {
  @override
  _DataFormState createState() => new _DataFormState();
}

class _DataFormState extends State<DataForm> {
  final _formKey = GlobalKey<FormState>();

  String _coursename = '';
  String _code = '';
  int _units = 0;
  var myLetterGrade = "W";
  var sliderValue = 0.0;
  double _grade = -1;
  String _dropdownlabel = "Units";

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Form(
          key: _formKey,
          child: new ListView(
            children: getFormWidget(),
          )),
    );
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();

    formWidget.add(new Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Text(
        'Course Data Form',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.italic),
      ),
    ));

    formWidget.add(new TextFormField(
      autofocus: true,
      decoration: InputDecoration(labelText: 'Course Name', hintText: 'Course'),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a Course Name';
        }
        return null;
      },
      onSaved: (value) {
        setState(() {
          _coursename = value;
        });
      },
    ));

    formWidget.add(new Row(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
          width: MediaQuery.of(context).size.width / 3,
          child: TextFormField(
            decoration:
                InputDecoration(labelText: 'Course Code', hintText: 'Code'),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a Course Code';
              }
              return null;
            },
            onSaved: (value) {
              setState(() {
                _code = value;
              });
            },
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
          width: MediaQuery.of(context).size.width / 2.5,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(70, 20, 0, 0),
                height: 80,
                child: DropdownButton(
                  hint: Text(
                    _dropdownlabel,
                    style: TextStyle(fontSize: 17, color: Colors.grey[600]),
                  ),
                  items: [
                    DropdownMenuItem(child: Text("1"), value: 1,),
                    DropdownMenuItem(child: Text("2"), value: 2),
                    DropdownMenuItem(child: Text("3"), value: 3),
                    DropdownMenuItem(child: Text("4"), value: 4),
                    DropdownMenuItem(child: Text("5"), value: 5),
                    DropdownMenuItem(child: Text("6"), value: 6)
                  ],
                  onChanged: (value) {
                    setState(() {
                      _units = value;
                      _dropdownlabel = _units.toString();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ));

    formWidget.add(new Container(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Text(
                'Grade',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
                child: Text(
              myLetterGrade,
              style: TextStyle(fontSize: 72.0),
            )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
            child: Container(
              child: Slider(
                  min: 0.0,
                  max: 8.0,
                  divisions: 8,
                  value: sliderValue,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.grey,
                  onChanged: (newValue) {
                    setState(() {
                      sliderValue = newValue;
                      if (sliderValue < 2.0) {
                        myLetterGrade = "F";
                        _grade = 0.0;
                      }
                      if (sliderValue >= 2.0 && sliderValue < 4.0) {
                        myLetterGrade = "D";
                        _grade = 1.0;
                      }
                      if (sliderValue >= 4.0 && sliderValue < 5.0) {
                        myLetterGrade = "C";
                        _grade = 2.0;
                      }
                      if (sliderValue >= 5.0 && sliderValue < 6.0) {
                        myLetterGrade = "C+";
                        _grade = 2.5;
                      }
                      if (sliderValue >= 6.0 && sliderValue < 7.0) {
                        myLetterGrade = "B";
                        _grade = 3.0;
                      }
                      if (sliderValue >= 7.0 && sliderValue < 8.0) {
                        myLetterGrade = "B+";
                        _grade = 3.5;
                      }
                      if (sliderValue == 8.0) {
                        myLetterGrade = "A";
                        _grade = 4.0;
                      }
                    });
                  }),
            ),
          ),
        ],
      ),
    ));

    void onPressedSubmit() {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        var arr = new List(5);
        arr[0] = _coursename;
        arr[1] = _code;
        arr[2] = _units;
        arr[3] = _grade;
        arr[4] = myLetterGrade;
        print('form submitted');
      }
    }

    formWidget.add(new FloatingActionButton(
        child: new Icon(Icons.check),
        backgroundColor: Colors.green,
        elevation: 2.0,
        onPressed: onPressedSubmit));

    return formWidget;
  }
}
