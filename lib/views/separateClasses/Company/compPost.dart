
class CompanyPost{
  final compSender? sender;
  final String? uid;
  final String? date;
  final String? time;
  final String? text;
  final String? imgUrl;
  final int? likes;
  final bool? allowComment;
  final bool? isOpen;
  final bool? allowApplication;

  CompanyPost({
    this.sender,
    this.uid,
    this.date,
    this.time,
    this.text,
    this.imgUrl,
    this.likes,
    this.allowComment,
    this.isOpen,
    this.allowApplication
  });
}

class compSender{
  final String name;
  final String email;
  final String role;
  final String profileImg;

  compSender(this.name, this.email, this.role, this.profileImg);
}