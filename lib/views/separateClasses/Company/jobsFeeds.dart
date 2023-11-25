import 'package:stugetow/views/separateClasses/Company/UserCompany.dart';

class CompanyJobFeeds {
  final UserCompany sender;
  final String date;
  final String text;
  final String imgPostUrl;
  final bool isLiked;
  final bool isOpen;

  CompanyJobFeeds(
    this.sender, 
    this.date, 
    this.text, 
    this.imgPostUrl, 
    this.isLiked,
    this.isOpen
  );
}

///You as a current User
final UserCompany currentUser = UserCompany(
  0, 
  "Amazon", 
  "assets/images/company/amazonTop.jpeg", 
  'Science'
);

////Users
final UserCompany civilers = UserCompany(
  1, 
  "Eskom", 
  "assets/images/company/eskom.jpeg", 
  'Engineering'
);
final UserCompany artistsArt = UserCompany(
  2, 
  "JSE", 
  "assets/images/company/jseTop.jpeg", 
  'Arts'
);
final UserCompany minahNoshmedias = UserCompany(
  3, 
  "KPMG", 
  "assets/images/company/kpmg.jpeg", 
  'Mathematics'
);
final UserCompany letswaFarms = UserCompany(
  4, 
  "Limak", 
  "assets/images/company/limak.jpeg", 
  'Arts'
);
final UserCompany sebotology = UserCompany(
  5,
  "Microsoft",
  "assets/images/company/microsoft.jpeg",
  'Accounting',
);
final UserCompany vinceMediaArt = UserCompany(
  6,
  "Moody's",
  "assets/images/company/moody's.jpeg",
  'Humanity',
);
final UserCompany fankLawyers = UserCompany(
  7,
  "MTN",
  "assets/images/company/mtn.png",
  'Agriculture',
);
final UserCompany johannahVision = UserCompany(
  8,
  "Naspers",
  "assets/images/company/naspers.jpeg",
  'Construction',
);
final UserCompany kediboneMedArt = UserCompany(
  9,
  "PWC",
  "assets/images/company/pwc.jpeg",
  'Law',
);
final UserCompany theAcountants = UserCompany(
  10,
  "SAA",
  "assets/images/company/saa.jpeg",
  'Media',
);
final UserCompany acScie = UserCompany(
  11, 
  "SABC", 
  "assets/images/company/sabc.jpeg", 
  'Science'
);
final UserCompany stbnk = UserCompany(
  12, 
  "Standard Bank", 
  "assets/images/company/standardBank.jpeg", 
  'Accounting'
);
final UserCompany sthoff = UserCompany(
  13, 
  "Steinhoff", 
  "assets/images/company/steinhoff.jpeg", 
  'Account'
);
final UserCompany ttlot = UserCompany(
  14, 
  "Takealot", 
  "assets/images/company/takealot.jpeg", 
  'Economics'
);
final UserCompany total = UserCompany(
  15, 
  "Total", 
  "assets/images/company/total.jpeg", 
  'Law'
);
final UserCompany vedanta = UserCompany(
  16, 
  "Vedanta", 
  "assets/images/company/vedanta.jpeg", 
  'Law'
);
final UserCompany walmart = UserCompany(
  14, 
  "Walmart", 
  "assets/images/company/walmart.jpeg", 
  'Arts'
);


List<UserCompany> favoriteJobFeeds = [
  johannahVision,
  kediboneMedArt,
  theAcountants,
  sebotology,
  vinceMediaArt,
  fankLawyers,
  minahNoshmedias,
  letswaFarms,
];

List<CompanyJobFeeds> allJobPosts = [
  CompanyJobFeeds(
    currentUser,
    "4/5/2020",
    'Last edited on 18/03/2020 Base it s a range of all values from 0 to the value that is less than the base with',
    "assets/images/company/vedanta.jpeg",
    false,
    true,
  ),
  CompanyJobFeeds(
    civilers,
    "1/3/2020",
    'Last edited on 18/03/2020 Base it s a range of all values from 0 to the value that is',
    "assets/images/company/naspers.jpeg",
    false,
    false,
  ),
  CompanyJobFeeds(
    artistsArt,
    "27/4/2020",
    'Lethabo says Last edited on 18/03/2020 Base it s a range of all',
    "assets/images/company/pwc.jpeg",
    false,
    true,
  ),
  CompanyJobFeeds(
    minahNoshmedias,
    "16/7/2020",
    'are you really sure you saying that of all values from 0 to the value that is less than the base with one(base-1).',
    "assets/images/company/microsoft.jpeg",
    false,
    true,
  ),
  CompanyJobFeeds(
    acScie,
    "27/6/2020",
    'Last edited on 18/03/2020 Base it s a range of all values from 0 to the value that is less than the base with',
    "assets/images/company/panicBuying.jpeg",
    false,
    false,
  ),
  CompanyJobFeeds(
    letswaFarms,
    "2/6/2020",
    'I guess you are just too smart to evenn see that what you are doing is very stupit',
    "assets/images/company/vedanta.jpeg",
    false,
    false,
  ),
  CompanyJobFeeds(
    sebotology,
    "5/12/2020",
    'Lol dude!! "what the fuck is that....?" I guess you are just too stupid to evenn see that what you are doing is very smart you are just too smart to evenn see that what you are doing is very stupitI guess you are just too smart to evenn see that what you are doing is very stupitI guess you are just too smart to evenn see that what you are doing is very stupit',
    "assets/images/company/steinhoff.jpeg",
    false,
    true,
  ),
  CompanyJobFeeds(
    vinceMediaArt,
    "1/8/2020",
    'Last edited on 18/03/2020 Base it s a range of all values from 0 to the value that is less than the base with',
    "assets/images/company/saa.jpeg",
    false,
    true,
  ),
  CompanyJobFeeds(
    fankLawyers,
    "20/5/2020",
    'Last edited on 18/03/2020 Base it s a range of all values from 0 to the value that is',
    "assets/images/company/sabc.jpeg",
    false,
    true,
  ),
  CompanyJobFeeds(
    johannahVision,
    "4/11/2020",
    'Lethabo says Last edited on 18/03/2020 Base it s a range of all',
    "assets/images/company/moody's.jpeg",
    false,
    true,
  ),
  CompanyJobFeeds(
    kediboneMedArt,
    "30/9/2020",
    'Is this matome on the go....? really man." I thought you was just too intelligent to even recognize that what you are doing is very smart you are just too smart to evenn see that what you are doing is very stupitI guess you are just too smart to evenn see that what you are doing is very stupitI guess you are just too smart to evenn see that what you are doing is very stupit',
    "assets/images/company/standardBank.jpeg",
    false,
    false,
  ),
  CompanyJobFeeds(
    currentUser,
    "4/10/2020",
    'are you really sure you saying that of all values from 0 to the value that is less than the base with one(base-1).',
    "assets/images/company/total.jpeg",
    false,
    true,
  ),
  CompanyJobFeeds(
    theAcountants,
    "8/2/2020",
    'I guess you are just too smart to evenn see that what you are doing is very stupit',
    "assets/images/company/walmart.jpeg",
    false,
    true,
  ),
];
