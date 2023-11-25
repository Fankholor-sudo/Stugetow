import 'package:stugetow/views/separateClasses/Institution/UserInstitution.dart';

class User {
  final int id;
  final String name;
  final String type;
  final String imageUrl;
  final String course;
  final String faculty;
  final String currentWorkStatus;
  final UserInstitution university;

  User(
    this.id,
    this.name,
    this.type,
    this.imageUrl,
    this.course,
    this.faculty,
    this.currentWorkStatus,
    this.university,
  );
}
