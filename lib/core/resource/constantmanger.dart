import 'package:citifix/feature/citzenFeature/reports/data/Models/timelinestep/timelinestep.dart';
import 'package:citifix/feature/citzenFeature/onbroading/model/onbroadingmodel.dart';

class Constantmanger {
  static const String isOnboardingViewed = "is_show_on_board";
  static const String skip = "Skip";
  Constantmanger._();
  static final List<Onbroadingmodel> pages = [
    Onbroadingmodel(
      title: "Report Problems",
      subtitle:
          "Spot an issue in your neighborhood? Easily report it with a photo and a brief description to get it fixed quickly.",
      image: "assets/onbroadingimage/1.svg",
    ),
    Onbroadingmodel(
      title: "Officials Are Acting",
      subtitle: "Work is underway to fix the problem",
      image: "assets/onbroadingimage/2.svg",
    ),
    Onbroadingmodel(
      title: "Improve Your City",
      subtitle:
          "Join your community in making your city a better place for everyone. Every report counts! ",
      image: "assets/4794867_51838.svg",
    ),
  ];
  static const String civix = "Civix";
  static String nointernet = "No internet connection";

  // ================== Auth ==================
  static const String logIn = "log in";
  static const String sinup = "Sign Up";
  static const String donthaveaccount = "Don’t have an account?";
  static const String Signup = "Sign up now";
  static const String forgetPassword = "Forget Password....?";
  static const String datebrith = "Date Brith";
  // ================== Fields ==================
  static const String email = "Email";
  static const String pass = "Password";
  static const String phone = "Phone";
  static const String fname = "First Name";
  static const String lname = "Last Name";
  static const String confirmPassword = "Confirm Password";
  static const String addressT = "Address";

  // ================== Hints ==================
  static const String hinytextemail = "Enter your email address";
  static const String hinytextpass = "********";
  static const String fnamehint = "Enter your First Name";
  static const String flnamehint = "Enter your Last Name";
  static const String address = "Enter your address";
  static const String phonehint = "Enter your Phone";

  // ================== Required Errors ==================
  static const String firstnamerequired = "First name is required";
  static const String lastnamerequired = "Last name is required";
  static const String emailrequired = "Email is required";
  static const String passwordrequired = "Password is required";
  static const String phonerequired = "Phone is required";
  static const String imagerequired = "Image is required";

  // ================== Invalid Errors (API) ==================
  static const String invalidEmail = "Invalid email";
  static const String invalidPhone = "Invalid phone";
  static const String invalidPassword =
      "Password must be at least 6 characters and include letters and numbers and special characters";
  static const String emailAlreadyExists =
      "Email already exists or database error";
  static const String passwordRulestitle =
      "Please add all necessary characters to create safe password.";

  static List<Map<String, dynamic>> passwordRules = [
    {"title": "Minimum characters 12", "status": false},
    {"title": "One uppercase character", "status": false},
    {"title": "One lowercase character", "status": false},
    {"title": "One special character", "status": false},
    {"title": "One number", "status": false},
  ];
  static const String photoGallery = "Photo Gallery";
  static const String camera = "Camera";
  static const String cancel = "Cancel";
  static String submit = "Submit";

  static String nationalnumber = "National number";
  static String hintnationalnumber = "Enter National number";
  static String Address = "address";

  static String msgforResetpassword =
      "We’ve sent you a code to reset your password. Please check your email.";
  static String msgforregister =
      "we have sent a 6-digit code to your registered  email address/phone number";
  static String screen = "screen";
  static String msgresetingpass =
      "Code verified successfully. Please set your new password.";
  static String token = "token";
  static var otp = "otp";
  static String apptitle = "CitiFix";
  static String kActive = "Active";
  static String kPending = "Pending";
  static String kCompleted = "Resolved";
  static String finish = " Get Started";
  static String next = "Next";

  static String sendReport = "Submit Report";

  static String location = "Location";

  static String selectcategory = "Select Category";

  static String hintReportDescription = "Describe the details of the Report";

  static String labeldescription = "Report Description";

  static String descriptionTitle = "Report Description";

  static String ReportTitle = "Street hole";

  static String ReportTitle1 = "Report title";

  static String addreport = "Add Report";

  static String language = "Language";

  static String identity = "Identity";

  static String support = "Support";

  static String accouninormation = "Account information";

  static String settings = "SETTINGS";

  static const String proile = "Profile";

  static String overview = "OverView";

  static String recenreport = "My Recent Reports";

  static String seeall = "See all";

  static String hsearch = 'Search my reports';

  static String search = "Search";
  static String accessToken = "accessToken";

  static var refreshToken = "refreshToken";

  static var refreshTokenExpiration = "refreshTokenExpiration";

  static String updateImage = "Profile image updated successfully";

  static String logout = "Log out";

  static String userid = "userID";

  static String defualtImage =
      "https://www.shutterstock.com/shutterstock/photos/298199573/display_1500/stock-vector-business-report-paper-on-blue-background-with-long-shadow-modern-vector-illustration-flat-style-298199573.jpg";

  static String reports = 'Reports';

  static String dateformate = 'dd MMM yyyy - hh:mm a';

  static String reportDetails = "Report Details";

  static List<TimelineStep> mySteps = [
    TimelineStep(index: 0, title: "Report Received", isDone: true),
    TimelineStep(index: 1, title: "Report Processed", isDone: false),
    TimelineStep(index: 2, title: "Report Resolved", isDone: false),
  ];
  static const selectLanguage = "Select Language";
  static const choosePreferredLanguage = "Choose your preferred language";
  static const english = "English";
  static const arabic = "العربية";
  static var role = "role";
  static const citizenIdentity = "Citizen Identity";
  static const fullName = "Full Name";
  static const nationalID = "National ID";
  static const address2 = "Address";
  static const job = "Job";
  static const gender = "Gender";
  static const age = "Age";

  static String editProfile = 'Edit Profile';
  static String fcm = "FCM";

  // Worker
  static const String daSHBOARD = "DASHBOARD";

  static const String tasks = 'TASKS';
  static String welceommsg = 'Good Morning, ';

  static String verificationPage = 'Verification Page';
  static const String mainTitle = "Verify Your\nCredentials";
  static const String subTitle =
      "Complete these steps to access the secure network.";
  static const String step1Title = "Identity Documents";
  static const String step1Label = "Step 1 of 4";
  static const String step2Title = "Workspace";
  static const String step2Label = "Step 3 of 4";
  static const String step3Title = "Service Category";
  static const String step3Label = "Step 2 of 4";
  static const String step4Label = "Step 4 of 4";
  static const String dropdownHint = "Select your service category";
  static const String verifyButtonText = "Verify Now";

  static String VERIFIED = 'VERIFIED';

  static String Pending = 'PENDING ⚠️';

  static String verifynow = 'Verify Now';

  static String Online = 'Online & Ready';

  static String alertrequired = 'Verification required';

  static String updateYourID = 'Update your ID by EOD to keep access.';

    static const String cacheKey = "user_profile_data";

}
