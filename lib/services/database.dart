import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:stugetow/views/separateClasses/Chats/Student.dart';
import 'package:stugetow/views/separateClasses/Company/Comp.dart';
import 'package:stugetow/views/separateClasses/Company/compPost.dart';
import 'package:stugetow/views/separateClasses/Institution/studentPost.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('students');
  final CollectionReference companyCollection = FirebaseFirestore.instance.collection('company');

  final CollectionReference companyPostCollection = FirebaseFirestore.instance.collection('companyPost');
  final CollectionReference studentPostCollection = FirebaseFirestore.instance.collection('studentPost');

  Future updateCompanyData({String? name, String? email, String? description}) async {
    return await companyCollection.doc(uid).set({
      'name': name,
      'email': email,
      'description': description,
      'role': 'company',
      'profileImg': ''
    });
  }

  Future updateUserData(String? fname, String? lname, String? school, String? faculty,
      String? course, String? studyLevel, String? work, String? bio) async {
     return await userCollection.doc(uid).set({
       'firstname': fname,
       'lastname': lname,
       'school': school,
       'faculty': faculty,
       'course': course,
       'studyLevel': studyLevel,
       'work': work,
       'bio': bio,
       'role': 'student',
       'profileImg': ''
     });
  }

  Future updateUserProfile({String? fname, String? lname, String? faculty,
      String? course, String? studyLevel, String? work, String? bio, String? img}) async {
    return await userCollection.doc(uid).update({
      'firstname': fname,
      'lastname': lname,
      'bio': bio,
      'studyLevel': studyLevel,
      'work': work,
      'course': course,
      'faculty': faculty,
      'profileImg': img
    });
  }

  Future updateCompanyProfile({String? name, String? description, String? img}) async {
    return await companyCollection.doc(uid).update({
      'name': name,
      'description': description,
      'profileImg': img
    });
  }

  Future currentUser() async {
    final userDoc = await companyCollection.doc(uid).get();
    final userStuDoc = await userCollection.doc(uid).get();

    if(userDoc.exists){
      final userData = userDoc.data();
      return userData;
    }
    else if(userStuDoc.exists){
      final userData = userStuDoc.data();
      return userData;
    }
    return null;
  }

  Future uploadStudentImage({File? image, String? folder, String? name}) async {
    if(image==null) return null;
    Reference ref = FirebaseStorage.instance.ref().child("images/student/$folder/$name");

    TaskSnapshot upload = await ref.putFile(image);
    var downUrl = await upload.ref.getDownloadURL();

    return downUrl;
  }

  Future uploadCompanyImage({File? image, String? folder, String? name}) async {
    if(image==null) return null;
    Reference ref = FirebaseStorage.instance.ref().child("images/company/$folder/$name");

    TaskSnapshot upload = await ref.putFile(image);
    var downUrl = await upload.ref.getDownloadURL();

    return downUrl;
  }

  Future getImageUrl({String? folder, String? role, String? name}) async {
    final ref = await FirebaseStorage.instance.ref("images/$role/$folder/$name").getDownloadURL();
    return ref;
  }

  Stream<QuerySnapshot> get students {
    return userCollection.snapshots();
  }


  ///-------------------------------User Details ends here-----------------------------///
            ///---------------------- aLL About user posts now below----------///


  Future makePostCompany({required Comp user, String? date, String? time, String? text, String? imgUrl, int? likes,
    bool? isOpen, bool? allowComment, bool? allowApplications}) async {
    return await companyPostCollection.add({
      'sender': {
        'name': user.name,
        'email': user.email,
        'role': 'company',
        'profileImg': user.profileImg
      },
      'uid': uid,
      'date': date,
      'time': time,
      'text': text,
      'imgUrl': imgUrl,
      'likes': likes,
      'isOpen': isOpen,
      'allowComment': allowComment,
      'allowApplications': allowApplications,
    });
  }

  Future makePostStudent({required Student user, String? date, String? time, String? text, String? imgUrl, int? likes, bool? allowComment}) async {
    return await studentPostCollection.add({
      'sender': {
        'firstname': user.firstname,
        'lastname': user.lastname,
        'studyLevel': user.studyLevel,
        'work': user.work,
        'school': user.school,
        'course': user.course,
        'faculty': user.faculty,
        'profileImg': user.profileImg
      },
      'uid': uid,
      'date': date,
      'time': time,
      'text': text,
      'imgUrl': imgUrl,
      'likes': likes,
      'allowComment': allowComment
    });
  }


  List<StudentPost> _fromSnapshotStudent(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      stuSender sender = stuSender(
          doc['sender']['firstname'], doc['sender']['lastname'], doc['sender']['studyLevel'], doc['sender']['school'],
          doc['sender']['faculty'], doc['sender']['course'], doc['sender']['work'], doc['sender']['profileImg']);
      return StudentPost(
          sender: sender,
          uid: doc['uid']??'',
          date: doc['date']??'',
          time: doc['time']??'',
          text: doc['text']??'',
          imgUrl: doc['imgUrl']??'',
          likes: doc['likes']??0,
          allowComment: doc['allowComment']??false,
      );
    }).toList();
  }
  Future<List<StudentPost>>  getPostStudent() async {
    List<StudentPost> list=[];
    await studentPostCollection.get().then((QuerySnapshot snapshot){
      _fromSnapshotStudent(snapshot).forEach((element) {
        list.add(element);
      });
    });

    return list;
  }

  List<CompanyPost> _fromSnapshotCompany(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      compSender sender = compSender(
          doc['sender']['name'], doc['sender']['email'],
          doc['sender']['role'], doc['sender']['profileImg']);
      return CompanyPost(
          sender: sender,
          uid: doc['uid']??'',
          date: doc['date']??'',
          time: doc['time']??'',
          text: doc['text']??'',
          imgUrl: doc['imgUrl']??'',
          likes: doc['likes']??0,
          isOpen: doc['isOpen']??false,
          allowComment: doc['allowComment']??false,
          allowApplication: doc['allowApplications']??false
      );
    }).toList();
  }
  Future<List<CompanyPost>>  getPostCompany() async {
    List<CompanyPost> list=[];
    QuerySnapshot qsCache = await companyPostCollection.get(GetOptions(source: Source.cache));
    QuerySnapshot qsServer = await companyPostCollection.get(GetOptions(source: Source.server));
    // await qsServer.then((QuerySnapshot snapshot){
    //   _fromSnapshotCompany(snapshot).forEach((element) {
    //     list.add(element);
    //   });
    // });
    if(qsCache.docs.isEmpty)
    _fromSnapshotCompany(qsServer).forEach((element) {
      list.add(element);
    });
    else
    _fromSnapshotCompany(qsCache).forEach((element) {
      list.add(element);
    });

    return list;
  }
  ////----------------------------------User Posts ends here--------------------------------------////
}