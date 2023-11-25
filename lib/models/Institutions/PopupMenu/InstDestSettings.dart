import 'package:flutter/material.dart';

class SchoolSettings extends StatefulWidget {
  @override
  _SchoolSettingsState createState() => _SchoolSettingsState();
}

class _SchoolSettingsState extends State<SchoolSettings> {
  bool isSwitched = true;
  bool isSwitchedTwo = false;
  bool isSwitchedThree = false;
  String? _currentSelectedValueFaculty;
  String? _currentSelectedValueCourse;

  var faculties = [
    "Science",
    "Art",
    "Engineering",
    "Law",
    "Medicine",
    "Humanity",
    "Teaching",
    "Business"
  ];
  var courses = [
    "Bsc General Science",
    "Mathematical Science",
    "Mining Engineering",
    "LLB Law",
    "Psychology",
    "Computer Science",
    "Civil Engineering",
    "Teaching",
    "Geology",
    "Biological Science",
    "Acturial Science",
    "Medicine",
    "Film and Television",
    "Music and Production",
    "Business Management"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        titleSpacing: 0,
        elevation: 1,
        backgroundColor: Colors.white,//.grey[50],
        leading:  IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.blueAccent[200]),
          iconSize: 25.0,
          onPressed: () => Navigator.pop(context,),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                "Post on display",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),

      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 18.0, right:10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child:Text(
                      "All",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                  Switch(
                    value: isSwitched,
                    onChanged: (value){
                      setState(() {
                        isSwitched = value;
                        print(isSwitched);
                      });
                    },
                    activeTrackColor: Colors.blue[400],
                    activeColor: Colors.white,
                    inactiveTrackColor: Colors.blueGrey[300],
                    inactiveThumbColor: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0,),
            Container(
              padding: EdgeInsets.only(left: 18.0, right:10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child:Text(
                      "Faculty",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                  Switch(
                    value: isSwitchedTwo,
                    onChanged: (value){
                      setState(() {
                        isSwitchedTwo = value;
                        print(isSwitchedTwo);
                      });
                    },
                    activeTrackColor: Colors.blue[400],
                    activeColor: Colors.white,
                    inactiveTrackColor: Colors.blueGrey[300],
                    inactiveThumbColor: Colors.white,
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(left:16,right:50),
              child: FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("Please select faculty"),
                        value: _currentSelectedValueFaculty,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            _currentSelectedValueFaculty = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: faculties.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(fontSize: 18),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 8.0,),
            Container(
              padding: EdgeInsets.only(left: 18.0, right:10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child:Text(
                      "Course",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: .5,
                      ),
                    ),
                  ),
                  Switch(
                    value: isSwitchedThree,
                    onChanged: (value){
                      setState(() {
                        isSwitchedThree = value;
                        print(isSwitchedThree);
                      });
                    },
                    activeTrackColor: Colors.blue[400],
                    activeColor: Colors.white,
                    inactiveTrackColor: Colors.blueGrey[300],
                    inactiveThumbColor: Colors.white,
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(left:16,right:50),
              child: FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("Please Select Course"),
                        value: _currentSelectedValueCourse,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            _currentSelectedValueCourse = newValue;
                            state.didChange(newValue);
                          });
                        },
                        items: courses.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style:TextStyle(fontSize: 18),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
