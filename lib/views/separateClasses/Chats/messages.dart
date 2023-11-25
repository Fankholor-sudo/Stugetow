import 'package:stugetow/views/separateClasses/Chats/Users.dart';
import 'package:stugetow/views/separateClasses/Institution/posts.dart';

class MessageChats {
  final User sender;
  final String date;
  final String text;
  final String imgPostUrl;
  final bool isLiked;
  final bool isOpen;

  MessageChats(this.sender, this.imgPostUrl,this.date, this.text, this.isLiked, this.isOpen);
}

///You as a current User
final User currentUser = User(
  0,
  "Fankholor",
  'student',
  "assets/images/people/people_10.jpg",
  "Accounting Science",
  "Accounting",
  "fullstack Software Developer",
  wits,
);

////Users
final User vince = User(
  1,
  "Vince",
  'student',
  "assets/images/people/people_20.jpg",
  "Computer Science",
  "Science",
  "fullstack Website Developer",
  uCT,
);
final User lethabo = User(
  2,
  "Lethabo",
  'student',
  "assets/images/people/people_9.jpg",
  "Mathematical Science",
  "Science",
  "Manager in Stugetow",
  uP,
);
final User minah = User(
  3,
  "Minah",
  'student',
  "assets/images/people/people_19.jpg",
  "Applied Mathematics",
  "Science",
  "Unemployed",
  uSB,
);
final User letswalo = User(
  4,
  "Letswalo",
  'student',
  "assets/images/people/people_8.jpg",
  "Mathematics and Information System",
  "Science and Economics",
  "Self Employed",
  uL,
);
final User sebothoma = User(
  5,
  "Sebothoma",
  'student',
  "assets/images/people/people_18.png",
  "Economic Science",
  "Economics",
  "Self Employed",
  uCT,
);
final User vincent = User(
  6,
  "Vincent coder",
  'student',
  "assets/images/people/people_7.jpg",
  "Electrical Engineering",
  "Engineering",
  "@Stugetow CEO",
  uFS,
);
final User fank = User(
  7,
  "Fankholoro",
  'student',
  "assets/images/people/people_17.jpg",
  "Social Worker",
  "Humanity",
  "Social Worker @Career and Counselling Development Unit",
  eWC,
);
final User johannah = User(
  8,
  "Johannah Sebothoma",
  'student',
  "assets/images/people/people_6.jpg",
  "Nursing",
  "Health Science",
  "Nurse @Tembisa Hospital",
  wits,
);
final User kedibone = User(
  9,
  "Kedibone Letswalo",
  'student',
  "assets/images/people/people_16.jpg",
  "Medicine",
  "Health Science",
  "Doctor @NetCare Hospital",
  uKZN,
);
final User mmabale = User(
  10,
  "Mmabale Sebothoma",
  'student',
  "assets/images/people/people_5.jpg",
  "Business Law",
  "Law",
  "Lawyer @Legal Wise",
  uNW,
);

List<User> favorite = [
  johannah,
  kedibone,
  mmabale,
  vincent,
  fank,
  minah,
  letswalo,
  sebothoma,
  currentUser
];

List<MessageChats> postByUser = [
  MessageChats(
    currentUser,
    "assets/images/schools/uct.jpeg",
    "4/5/2020",
    'Last edited on 18/03/2020 Base it s a range of all values from 0 to the value that is less than the base with',
    false,
    true,
  ),
  MessageChats(
    vince,
    "assets/images/schools/up.jpeg",
    "1/3/2020",
    'Last edited on 18/03/2020 Base it s a range of all values from 0 to the value that is',
    false,
    false,
  ),
  MessageChats(
    lethabo,
    "",
    "27/4/2020",
    'Lethabo says Last edited on 18/03/2020 Base it s a range of all',
    false,
    false,
  ),
  MessageChats(
    minah,
    "",
    "16/7/2020",
    'are you really sure you saying that of all values from 0 to the value that is less than the base with one(base-1).',
    false,
    true,
  ),
  MessageChats(
    letswalo,
    "assets/images/company/walmart.jpeg",
    "2/6/2020",
    'I guess you are just too smart to evenn see that what you are doing is very stupit',
    false,
    true,
  ),
  MessageChats(
    sebothoma,
    "assets/images/company/total.jpeg",
    "5/12/2020",
    'Lol dude!! "what the fuck is that....?" I guess you are just too stupid to evenn see that what you are doing is very smart you are just too smart to evenn see that what you are doing is very stupitI guess you are just too smart to evenn see that what you are doing is very stupitI guess you are just too smart to evenn see that what you are doing is very stupit',
    false,
    true,
  ),
  MessageChats(
    vincent,
    "assets/images/company/standardBank.jpeg",
    "1/8/2020",
    'Last edited on 18/03/2020 Base it s a range of all values from 0 to the value that is less than the base with',
    false,
    true,
  ),
  MessageChats(
    fank,
    "",
    "20/5/2020",
    'Last edited on 18/03/2020 Base it s a range of all values from 0 to the value that is',
    false,
    false,
  ),
  MessageChats(
    johannah,
    "",
    "4/11/2020",
    'Lethabo says Last edited on 18/03/2020 Base it s a range of all',
    false,
    true,
  ),
  MessageChats(
    kedibone,
    "assets/images/company/moody's.jpeg",
    "30/9/2020",
    'Is this matome on the go....? really man." I thought you was just too intelligent to even recognize that what you are doing is very smart you are just too smart to evenn see that what you are doing is very stupitI guess you are just too smart to evenn see that what you are doing is very stupitI guess you are just too smart to evenn see that what you are doing is very stupit',
    false,
    false,
  ),
  MessageChats(
    currentUser,
    "assets/images/company/sabc.jpeg",
    "4/10/2020",
    'are you really sure you saying that of all values from 0 to the value that is less than the base with one(base-1).',
    false,
    false,
  ),
  MessageChats(
    mmabale,
    "",
    "8/2/2020",
    'I guess you are just too smart to evenn see that what you are doing is very stupit',
    false,
    true,
  ),
];
