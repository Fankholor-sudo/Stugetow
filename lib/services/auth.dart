import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stugetow/services/database.dart';
import 'package:stugetow/views/separateClasses/Chats/Student.dart';
import 'package:stugetow/views/separateClasses/Company/Comp.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      UserCredential response = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = response.user!;
      _setData(user.uid);
      return true;
    }
    catch(e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future updateUserProfile({String? fname, String? lname, String? faculty,
    String? course, String? studyLevel, String? work, String? bio, File? img, String? imgUrl}) async {
    try {
      User user = _auth.currentUser!;
      var url = await DatabaseService(uid: user.uid).uploadStudentImage(image:img, folder:"profile", name: user.uid);
      if(url!=null){
        await DatabaseService(uid: user.uid).updateUserProfile(
            fname:fname, lname:lname, faculty:faculty, course:course,
            studyLevel:studyLevel, work:work, bio:bio, img: url
        );
      }
      else{
        await DatabaseService(uid: user.uid).updateUserProfile(
            fname:fname, lname:lname, faculty:faculty, course:course,
            studyLevel:studyLevel, work:work, bio:bio, img: imgUrl
        );
      }
      return url;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }

  Future updateCompanyProfile({String? name, String? description, File? img, String? imgUrl}) async {
    try{
      User user = _auth.currentUser!;
      final url = await DatabaseService(uid: user.uid).uploadCompanyImage(image: img, folder:"profile", name: user.uid);
      if(url!=null){
        await DatabaseService(uid: user.uid).updateCompanyProfile(name:name, description:description, img: url);
      }
      else{
        await DatabaseService(uid: user.uid).updateCompanyProfile(name:name, description:description, img: imgUrl);
      }
      return url;
    }
    catch(e){
      print(e.toString());
      return false;
    }
  }

  Future registerWithEmailAndPassword({required String email, required String password,
      String? fname, String? lname, String? school, String? faculty,
      String? course, String? studyLevel, String? work, String? bio}) async {
    try {
      UserCredential response = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = response.user!;
      await DatabaseService(uid: user.uid).updateUserData(fname, lname, school, faculty, course, studyLevel, work, bio);
      _setData(user.uid);
      return true;
    }
    catch(e) {
      print(e.toString());
      return e.toString();
    }
  }

  Future registerWithEmailAndPasswordCompany({required String email, required String password, String? name, String? description}) async {
    try {
      UserCredential response = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = response.user!;
      await DatabaseService(uid: user.uid).updateCompanyData(name:name ,email:email ,description: description );
      _setData(user.uid);
      return true;
    }
    catch(e) {
      print('registration: '+e.toString());
      return e.toString();
    }
  }

  Future getStudents() async {
    try {
      User user = _auth.currentUser!;
      var result = DatabaseService(uid: user.uid).students;
      return result;
    }
    catch(e) {
      return null;
    }
  }

  Future getUserData() async {
    try {
      User user = _auth.currentUser!;
      var result = await DatabaseService(uid: user.uid).currentUser();
      return result;
    }
    catch(e) {
      return null;
    }
  }

  _setData(uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('uid',uid);
  }

  Future signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  ///----------------New stuff here-------------------///
  Future postStudent({required Student userParam,String? date, String? time, String? text, File? img, int? likes, bool? allowComment}) async {
    try{
      User user = _auth.currentUser!;
      final url = await DatabaseService(uid: user.uid).uploadStudentImage(
          image:img, folder:'posts', name: img!=null?basename(img.path):""
      );
      await DatabaseService(uid: user.uid).makePostStudent(
          user: userParam, date: date, time: time, text: text, imgUrl: url,
          likes: likes, allowComment: allowComment
      );

      return url;
    }
    catch(e) {
      print(e.toString());
      return false;
    }
  }

  Future postCompany({required Comp userParam, String? date, String? time, String? text, File? img, int? likes,
    bool? isOpen, bool? allowComment, bool? allowApplications}) async {
    try{
      User user = _auth.currentUser!;
      final url = await DatabaseService(uid: user.uid).uploadCompanyImage(
          image:img, folder:'posts', name: img!=null?basename(img.path):""
      );
      await DatabaseService(uid: user.uid).makePostCompany(
          user: userParam, date: date, time: time, text: text, imgUrl: url, likes: likes,
          isOpen: isOpen, allowComment: allowComment, allowApplications: allowApplications
      );

      return url;
    }
    catch(e) {
      print(e.toString());
      return false;
    }
  }

  Future getPostCompany() async {
    try{
      User user = _auth.currentUser!;
      return await DatabaseService(uid: user.uid).getPostCompany();
    }
    catch(e) {
      print(e);
      return null;
    }
  }

  Future getPostStudent() async {
    try{
      User user = _auth.currentUser!;
      return await DatabaseService(uid: user.uid).getPostStudent();
    }
    catch(e) {
      print(e);
      return null;
    }
  }
}