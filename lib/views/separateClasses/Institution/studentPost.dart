
class StudentPost{
  final stuSender? sender;
  final String? uid;
  final String? date;
  final String? time;
  final String? text;
  final String? imgUrl;
  final int? likes;
  final bool? allowComment;

  StudentPost({
    this.sender,
    this.uid,
    this.date,
    this.time,
    this.text,
    this.imgUrl,
    this.likes,
    this.allowComment
  });
}

class stuSender{
  final String firstname;
  final String lastname;
  final String school;
  final String faculty;
  final String course;
  final String studyLevel;
  final String work;
  final String profileImg;

  stuSender(this.firstname, this.lastname, this.studyLevel, this.school, this.faculty, this.course, this.work, this.profileImg);
}