import 'package:stugetow/views/separateClasses/Institution/UserInstitution.dart';

class StudentsPosts {
  final UserInstitution sender;
  final String date;
  final String text;
  final String imgPostUrl;
  final bool isLiked;
  final bool unread;

  StudentsPosts(this.sender, this.date, this.text, this.imgPostUrl, this.isLiked, this.unread);
}

///You as a current User
final UserInstitution wits = UserInstitution(
  0,
  "University of the Witwatersrand",
  'University',
  "Johannesburg",
  "assets/images/schools/wits.jpeg",
);

////Users
final UserInstitution uJ = UserInstitution(
  1,
  "University of Johannesburg",
  'University',
  "Johannesburg",
  "assets/images/schools/uj.jpeg",
);
final UserInstitution uL = UserInstitution(
  2,
  "University of Limpopo",
  'University',
  "Limpopo",
  "assets/images/schools/ul.jpeg",
);
final UserInstitution uP = UserInstitution(
  3,
  "University of Pretoria",
  'University',
  "Pretoria",
  "assets/images/schools/up.jpeg",
);
final UserInstitution uCT = UserInstitution(
  4,
  "University of Capetown",
  'University',
  "Cape Town",
  "assets/images/schools/uct.jpeg",
);
final UserInstitution uKZN = UserInstitution(
  5,
  "University of Kwazulu Natal",
  'University',
  "Kwazulu Natal",
  "assets/images/schools/ukzn.jpeg",
);
final UserInstitution uSB = UserInstitution(
  6,
  "University of Stelenbosch",
  'University',
  "Cape Town",
  "assets/images/schools/ustele.jpg",
);
final UserInstitution uNW = UserInstitution(
  7,
  "University of North West",
  'University',
  "North West",
  "assets/images/schools/unw.jpeg",
);
final UserInstitution uFS = UserInstitution(
  8,
  "University of Free State",
  'University',
  "Free State",
  "assets/images/schools/ufs.jpeg",
);
final UserInstitution eWC = UserInstitution(
  9,
  "Ekurhuleni West Campus",
  'College',
  "Gauteng",
  "assets/images/schools/ewc.jpeg",
);
final UserInstitution tUT = UserInstitution(
  10,
  "Thswane University of Technology",
  'University',
  "Pretoria",
  "assets/images/schools/tut.jpeg",
);

List<UserInstitution> favoriteInstitution = [
  tUT,
  uFS,
  uL,
  eWC,
  wits,
  uNW,
  uSB,
  uCT,
  uJ,
  uKZN,
  uP,
];

List<StudentsPosts> post = [
  StudentsPosts(
    wits,
    "4/5/2020",
    'Last edited on 18/03/2020 Base it s a range of all values from 0 to the value that is less than the base with',
    "assets/images/schools/uct.jpeg",
    false,
    true,
  ),
  StudentsPosts(
    uJ,
    "1/3/2020",
    'Last edited on 18/03/2020 Base it s a range of all values from 0 to the value that is',
    "assets/images/schools/up.jpeg",
    false,
    true,
  ),
  StudentsPosts(
    uL,
    "27/4/2020",
    'Lethabo says Last edited on 18/03/2020 Base it s a range of all',
    "assets/images/vinceFromthGame2015.jpg",
    false,
    true,
  ),
  StudentsPosts(
    uP,
    "16/7/2020",
    'are you really sure you saying that of all values from 0 to the value that is less than the base with one(base-1).',
    "assets/images/vinceFromthGame2015.jpg",
    false,
    true,
  ),
  StudentsPosts(
    uCT,
    "2/6/2020",
    'I guess you are just too smart to evenn see that what you are doing is very stupit',
    "assets/images/vinceFromthGame2015.jpg",
    false,
    true,
  ),
  StudentsPosts(
    uKZN,
    "5/12/2020",
    'Lol dude!! "what the fuck is that....?" I guess you are just too stupid to evenn see that what you are doing is very smart you are just too smart to evenn see that what you are doing is very stupitI guess you are just too smart to evenn see that what you are doing is very stupitI guess you are just too smart to evenn see that what you are doing is very stupit',
    "assets/images/vinceFromthGame2015.jpg",
    false,
    true,
  ),
  StudentsPosts(
    uSB,
    "1/8/2020",
    'Last edited on 18/03/2020 Base it s a range of all values from 0 to the value that is less than the base with',
    "assets/images/vinceFromthGame2015.jpg",
    false,
    true,
  ),
  StudentsPosts(
    uNW,
    "20/5/2020",
    'Last edited on 18/03/2020 Base it s a range of all values from 0 to the value that is',
    "assets/images/vinceFromthGame2015.jpg",
    false,
    true,
  ),
  StudentsPosts(
    uFS,
    "4/11/2020",
    'Lethabo says Last edited on 18/03/2020 Base it s a range of all',
    "assets/images/vinceFromthGame2015.jpg",
    false,
    true,
  ),
  StudentsPosts(
    eWC,
    "30/9/2020",
    'Is this matome on the go....? really man." I thought you was just too intelligent to even recognize that what you are doing is very smart you are just too smart to evenn see that what you are doing is very stupitI guess you are just too smart to evenn see that what you are doing is very stupitI guess you are just too smart to evenn see that what you are doing is very stupit',
    "assets/images/vinceFromthGame2015.jpg",
    false,
    true,
  ),
  StudentsPosts(
    tUT,
    "4/10/2020",
    'are you really sure you saying that of all values from 0 to the value that is less than the base with one(base-1).',
    "assets/images/vinceFromthGame2015.jpg",
    false,
    true,
  ),
  StudentsPosts(
    wits,
    "8/2/2020",
    'I guess you are just too smart to evenn see that what you are doing is very stupit',
    "assets/images/vinceFromthGame2015.jpg",
    false,
    true,
  ),
];
