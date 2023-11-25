import 'package:flutter/material.dart';
import 'package:stugetow/views/separateClasses/Chats/messages.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlide.dart';
import 'package:stugetow/screens/Chats/UserProfileDestination.dart';
import 'package:stugetow/views/separateClasses/Chats/Users.dart';
import 'package:flutter/services.dart';

class ViewUsers extends StatefulWidget {
  @override
  ViewUsersState createState() => ViewUsersState();
}

class ViewUsersState extends State<ViewUsers> {
  List<User>? filteredUser ;
  List<User>?_filteredUser;
  String? _currentSelectedValueCourse;
  String? _currentSelectedValueFaculty;
  TextEditingController? _searchController;

  var courses = [
    "Accounting Science",
    "Biological Science",
    "Acturial Science",
    "Computer Science",
    "Applied Mathematics",
    "Mining Engineering",
    "Electrical Engineering",
    "Civil Engineering",
    "Social Worker",
    "Mathematics",
    "Psychology",
    "Teaching",
    "Medicine",
    "Business",
    "Science",
    "Nursing",
    "Music",
    "Law"
  ];
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
  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height,
      width: double.infinity,
      child: DefaultTabController(
        length:3,
        child: Scaffold(
          appBar: new AppBar(
            brightness: Brightness.dark,
            titleSpacing: 0,
            elevation: 1,
             backgroundColor: Colors.grey[300],
            leading:  Container(
              color: Color.fromRGBO(9, 86, 164, .7),
              child: IconButton(
                icon: Icon(Icons.arrow_back,color: Colors.grey[80]),
                iconSize: 22.0,
                onPressed: () => Navigator.pop(context,),
              ),
            ),
            title: Container(
              child: TextField(
                controller: _searchController,
                focusNode: FocusNode(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                  fontSize: 22,
                ),
                decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[800],
                      fontSize: 18,
                    ),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          _searchController!.clear();
                          _currentSelectedValueCourse = null;
                          _currentSelectedValueFaculty = null;
                          filteredUser = favorite;
                        });
                      },
                      icon: Icon(Icons.close, color: Colors.black54, size:22),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left:10.0,top:13)
                ),
                onChanged: (value) {
                  setState(() {
                    filteredUser = favorite.where((u) => (
                        u.name.trim().toLowerCase().contains(value.toLowerCase())
                    )).toList();
                    _filteredUser = filteredUser;
                    _currentSelectedValueCourse = null;
                    _currentSelectedValueFaculty = null;
                  });
                },
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(25),
              child: Container(
                color: Colors.white54,
                child: SafeArea(
                  child: Column(
                    children: [
                       TabBar(
                         indicator: UnderlineTabIndicator(
                           borderSide: BorderSide(
                             width: 4.0,
                             color: Color.fromRGBO(9, 86, 164, .7)
                           ),
                         ),
                         indicatorWeight: 10,
                         labelColor: Color.fromRGBO(9, 86, 164, .9),
                         labelStyle: TextStyle(
                             fontSize: 20,
                             letterSpacing: 0.3,
                             fontWeight: FontWeight.w500
                         ),
                         unselectedLabelColor: Colors.black87,
                         tabs: [
                           Container(
                             height:18,
                             child: Tab(
                               text: 'All',
                             ),
                          ),
                           Container(
                             height: 18,
                             child: Tab(
                               text: 'Course',
                              ),
                           ),
                           Container(
                             height: 18,
                             child: Tab(
                               text: 'Faculty',
                             ),
                           ),
                         ],
                       ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Center(child: firstPage(context)),
              Center(child: secondPage(context)),
              Center(child: thirdPage(context))
            ],
          ),
        ),
      ),
    );
  }

  Widget firstPage(context){
    return Container(
      child: ListView(
        children: <Widget>[
          for (var index = 0; index < filteredUser!.length; ++index)
            Container(
              child: Column(
                children: <Widget>[
                  InkWell(
                    splashColor: Colors.blueGrey,
                    onTap: () { Future.delayed(Duration(milliseconds: 200),() {
                      Navigator.push(context,
                        AnimatedPageRouteSlide(page: UserDestinationScreen(
                          destination: filteredUser![index],
                        )),
                      );
                    });
                    },
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 24.0,
                                    backgroundImage: AssetImage(
                                        filteredUser![index].imageUrl
                                    ),
                                  ),
                                  SizedBox(width: 10.0,),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          filteredUser![index].name,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          child: Text(
                                            filteredUser![index].type + " | " +filteredUser![index].university.name,
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, .5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          child: Text(
                                            filteredUser![index].course,
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, .5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              //),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget secondPage(context){
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(height:10),
          Container(
            margin: EdgeInsets.only(left:16,right:16),
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: Text("Please Select Course"),
                      value: _currentSelectedValueCourse,
                      isDense: true,
                      onTap: (){
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        },
                      onChanged: (String? newValue) {
                        setState(() {
                          _currentSelectedValueCourse = newValue;
                          state.didChange(newValue);

                          _filteredUser = filteredUser!.where((u) => (
                              u.course.trim().toLowerCase().contains(newValue!.toLowerCase())
                          )).toList();
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
          SizedBox(height:10),
          for (var index = 0; index < _filteredUser!.length; ++index)
            Container(
              child: Column(
                children: <Widget>[
                  InkWell(
                    splashColor: Colors.blueGrey,
                    onTap: () { Future.delayed(Duration(milliseconds: 200),() {
                      Navigator.push(context,
                        AnimatedPageRouteSlide(page: UserDestinationScreen(
                          destination: _filteredUser![index],
                        )),
                      );
                    });
                    },
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 24.0,
                                    backgroundImage: AssetImage(
                                        _filteredUser![index].imageUrl
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),

                                  Container(
                                    child: Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          _filteredUser![index].name,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          child: Text(
                                            "faculty" + " | " +_filteredUser![index].faculty,
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, .5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          child: Text(
                                            _filteredUser![index].course,
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, .5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget thirdPage(context){
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.only(left:16,right:16),
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
                      onTap: (){
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                      },
                      onChanged: (String? newValue) {
                        setState(() {
                          _currentSelectedValueFaculty = newValue;
                          state.didChange(newValue);

                          _filteredUser = filteredUser!.where((u) => (
                              u.faculty.trim().toLowerCase().contains(newValue!.toLowerCase())
                          )).toList();
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
          SizedBox(height:10),
          for (var index = 0; index < _filteredUser!.length; ++index)
            Container(
              child: Column(
                children: <Widget>[
                  InkWell(
                    splashColor: Colors.blueGrey,
                    onTap: () { Future.delayed(Duration(milliseconds: 200),() {
                      Navigator.push(context,
                        AnimatedPageRouteSlide(page: UserDestinationScreen(
                          destination: _filteredUser![index],
                        )),
                      );
                    });
                    },
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 24.0,
                                    backgroundImage: AssetImage(
                                        _filteredUser![index].imageUrl
                                    ),
                                  ),
                                  SizedBox(width: 10.0,),

                                  Container(
                                    child: Column(
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          _filteredUser![index].name,
                                          style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          child: Text(
                                            "faculty" + " | " +_filteredUser![index].faculty,
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, .5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.6,
                                          child: Text(
                                            _filteredUser![index].course,
                                            style: TextStyle(
                                              color: Color.fromRGBO(0, 0, 0, .5),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
        ],
      ),
    );
  }


  @override
  void initState(){
    super.initState();
    filteredUser = favorite;
    _filteredUser = filteredUser;
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController!.dispose();
  }
}
