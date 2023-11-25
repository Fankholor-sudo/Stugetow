import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stugetow/models/mainPage/AnimatedPageRouteSlide.dart';
import 'package:stugetow/models/mainPage/drawer_profile.dart';
import 'package:stugetow/models/mainPage/mainPageMenu.dart';
import 'package:stugetow/screens/Chats/UserProfileDestination.dart';
import 'package:stugetow/screens/CompanyState/StateDestinations.dart';
import 'package:stugetow/screens/Institutions/InstitutionDestination.dart';
import 'package:stugetow/screens/Institutions/Schools.dart';
import 'package:stugetow/screens/CompanyState/latestPostedJobs.dart';
import 'package:stugetow/screens/Chats/chats.dart';
import 'package:flutter/material.dart';
import 'package:stugetow/screens/Relevant_Company/CompanySector.dart';
import 'package:stugetow/screens/mainPage/mainPageSettings.dart';
import 'package:stugetow/screens/mainPage/myCompanyProfile.dart';
import 'package:stugetow/screens/mainPage/myProfile.dart';
import 'package:stugetow/services/auth.dart';
import 'package:stugetow/views/Authentication/Login.dart';
import 'package:stugetow/views/separateClasses/Chats/messages.dart';
import 'package:stugetow/views/separateClasses/Company/jobsFeeds.dart';
import 'package:stugetow/views/separateClasses/Institution/posts.dart';
import 'package:stugetow/views/separateClasses/Relevant_to_you/RelevantJobposts.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  MainPageClass createState() => MainPageClass();
}

class MainPageClass extends State<MainPage> {
  PageController? _pageController;
  ScrollController? _scrollNestedController;
  int page = 0;
  late bool isVisible;

  var _filteredUser;
  var _listHolder;

  String? user;

  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Profile(),
      body: NestedScrollView(
          controller: _scrollNestedController,
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return <Widget>[
                SliverAppBar(
                  floating: true,
                  pinned: false,
                  snap: true,
                  forceElevated: true,
                  backgroundColor: Colors.grey[50],
                  shadowColor: Colors.black,

                  leading: Container(
                    height: 50,
                    width: 50,
                    margin: EdgeInsets.only(top: 7.0),
                    alignment: Alignment.bottomRight,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                        AssetImage('assets/images/logo/tranparentBackground.png'),
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.search),
                      color: Color.fromRGBO(41, 127, 212, 1),
                      iconSize: 25.0,
                      onPressed: () {
                        _showBottomSearch(context);
                      },
                    ),
                    PopupMenuButton<String>(
                      onSelected: onClickMenu,
                      icon: Icon(Icons.more_vert, color: Color.fromRGBO(9, 86, 164, 1)),
                      color: Colors.blueGrey,
                      itemBuilder: (BuildContext context) {
                        return MainPageMenu.choicesMain.map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(
                              choice,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList();
                      },
                    ),
                  ],

                ),
            ];
          },
          body: PageView(
            children: <Widget>[
              Container(child: NoteList(notifyParent: refresh)),
              Container(child: School(notifyParent: refresh)),
              Container(child: CompanySector(notifyParent: refresh)),
              Container(child: Likes(notifyParent: refresh)),
            ],
            controller: _pageController,
            onPageChanged: onPageChanged,
          ),
        ),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        height: !isVisible ? 0.0 : 60.0,
        child: BottomNavigationBar(
          selectedItemColor: Colors.blueGrey,
          unselectedItemColor: Colors.blueGrey.withOpacity(.7),
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.work,
                size: 30.0,
              ),
              label: "work",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.school,
                size: 30.0,
              ),
              label: "institutions",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bubble_chart,
                size: 30.0,
              ),
              label: "my Jobs",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.people,
                size: 30.0,
              ),
              label: "talks",
            ),
          ],
          onTap: jumpToPage,
          currentIndex: page,
        ),
      ),
    );
  }

  void _showBottomSearch(context) {
    _getList(page);
    showModalBottomSheet(
        backgroundColor: Color.fromRGBO(255, 255, 255, .85),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 5.0),
                      child: TextField(
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        decoration: InputDecoration(
                            hintText: "Search...",
                            prefixIcon: Icon(Icons.search,
                                color: Colors.grey.shade400, size: 25),
                            filled: true,
                            fillColor: Colors.grey.shade100,
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey.shade400,
                              fontSize: 18,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            contentPadding: EdgeInsets.all(5.0)),
                        onChanged: (value) {
                          setState(() {
                            print("page: " + page.toString() + "\nvalue : " + value);
                            _filterText(value, page);
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          for (var index = 0;
                          index < _filteredUser.length;
                          ++index)
                            Container(
                              child: Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            GestureDetector(
                                              onTap: () {
                                                switch (page) {
                                                  case 0:
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            StateDestinationScreen(
                                                              destination:
                                                              _filteredUser[
                                                              index],
                                                            ),
                                                      ),
                                                    );
                                                    break;

                                                  case 1:
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            SchoolDestinationScreen(
                                                              destination:
                                                              _filteredUser[
                                                              index],
                                                            ),
                                                      ),
                                                    );
                                                    break;

                                                  case 2:
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            StateDestinationScreen(
                                                              destination:
                                                              _filteredUser[
                                                              index],
                                                            ),
                                                      ),
                                                    );
                                                    break;
                                                  case 3:
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            UserDestinationScreen(
                                                              destination:
                                                              _filteredUser[
                                                              index],
                                                            ),
                                                      ),
                                                    );
                                                    break;
                                                }
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  CircleAvatar(
                                                    radius: 24.0,
                                                    backgroundImage: AssetImage(
                                                        _filteredUser[index]
                                                            .imageUrl),
                                                  ),
                                                  SizedBox(
                                                    width: 10.0,
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: <Widget>[
                                                        Text(
                                                          _filteredUser[index]
                                                              .name,
                                                          style: TextStyle(
                                                            color:
                                                            Colors.black87,
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Container(
                                                          width: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.6,
                                                          child: Text(
                                                            page == 3
                                                                ? _filteredUser[
                                                            index]
                                                                .type +
                                                                " | " +
                                                                _filteredUser[
                                                                index]
                                                                    .university
                                                                    .name
                                                                : page == 1
                                                                ? _filteredUser[
                                                            index]
                                                                .describtion
                                                                : "Company",
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                  0, 0, .5),
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                            ),
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .width *
                                                              0.6,
                                                          child: Text(
                                                            page == 3
                                                                ? _filteredUser[
                                                            index]
                                                                .course
                                                                : page == 0
                                                                ? "Focus | " +
                                                                _filteredUser[index]
                                                                    .faculty
                                                                : page == 1
                                                                ? "Location | " +
                                                                _filteredUser[index]
                                                                    .province
                                                                : page ==
                                                                2
                                                                ? "Focus | " +
                                                                _filteredUser[index]
                                                                    .faculty
                                                                : "",
                                                            style: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(0,
                                                                  0, 0, .5),
                                                              fontSize: 12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                            ),
                                                            overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _getList(int pageN) {
    switch (pageN) {
      case 0:
        _listHolder = favoriteJobFeeds;
        break;
      case 1:
        _listHolder = favoriteInstitution;
        break;
      case 2:
        _listHolder = favoriteRelevant;
        break;
      case 3:
        _listHolder = favorite;
        break;
      default:
        _listHolder = favorite;
    }
    _filteredUser = _listHolder;
  }

  void _filterText(String value, int pageNum) {
    switch (pageNum) {
      case 0:
        print(_filteredUser);
        _filteredUser = _listHolder
            .where((u) =>
        (u.name
            .trim()
            .toLowerCase()
            .contains(value.toLowerCase()) ||
            u.faculty.trim().toLowerCase().contains(value.toLowerCase())))
            .toList();
        print(_filteredUser);
        break;
      case 1:
        print(_filteredUser);
        _filteredUser = _listHolder
            .where((u) =>
        (u.name
            .trim()
            .toLowerCase()
            .trim()
            .contains(value.toLowerCase()) ||
            u.province.trim().toLowerCase().contains(value.toLowerCase()) ||
            u.describtion
                .trim()
                .toLowerCase()
                .contains(value.toLowerCase())))
            .toList();
        print(_filteredUser);
        break;
      case 2:
        print(_filteredUser);
        _filteredUser = _listHolder
            .where((u) =>
        (u.name
            .trim()
            .toLowerCase()
            .contains(value.toLowerCase()) ||
            u.faculty.trim().toLowerCase().contains(value.toLowerCase())))
            .toList();
        print(_filteredUser);
        break;
      case 3:
        print(_filteredUser);
        _filteredUser = _listHolder
            .where((u) =>
        (u.name
            .trim()
            .toLowerCase()
            .contains(value.toLowerCase()) ||
            u.type.trim().toLowerCase().contains(value.toLowerCase()) ||
            u.course.trim().toLowerCase().contains(value.toLowerCase())))
            .toList();
        print(_filteredUser);
        break;
    }
  }

  void onClickMenu(String item) async {
    if (item == MainPageMenu.profile) {
      if (user == 'student') {
        Navigator.push(
          context,
          AnimatedPageRouteSlide(
            page: MyProfileDestinationScreen(
              destination: postByUser[0].sender,
            ),
          ),
        );
      } else if (user == 'company') {
        Navigator.push(
          context,
          AnimatedPageRouteSlide(
            page: CompanyProfileDestinationScreen(
              destination: allJobPosts[0].sender
            ),
          ),
        );
      }
    } else if (item == MainPageMenu.settings) {
      Navigator.push(
        context,
        AnimatedPageRouteSlide(
          page: MainPageSettings(),
        ),
      );
    } else if (item == MainPageMenu.logout) {
      await _auth.signOut();
      Navigator.pushReplacement(
        context,
        AnimatedPageRouteSlide(
          page: Login(),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
    setState(() {
      _pageController = new PageController();
      _scrollNestedController = new ScrollController();
      isVisible = true;
      _scrollNestedController!.addListener(() {
        //moving Up
        if (_scrollNestedController!.position.userScrollDirection ==
            ScrollDirection.forward) {
          setState(() {
            isVisible = true;
          });
        }
        //moving Down
        else if (_scrollNestedController!.position.userScrollDirection == ScrollDirection.reverse) {
          setState(() {
            isVisible = false;
          });
        }
      });
    });
  }

  _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var role = prefs.getString('role');
    setState((){user=role;});
  }

  refresh(dynamic visibility) {
    setState(() {
      isVisible = visibility;
    });
  }

  void jumpToPage(int page){
    _pageController!.jumpToPage(page);
  }
  void navigateToPage(int page) {
    _pageController!.animateToPage(page,
        duration: Duration(milliseconds: 400), curve: Curves.linear);
  }

  void onPageChanged(int page) {
    setState(() {
      this.page = page;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
    _scrollNestedController!.dispose();
  }
}
