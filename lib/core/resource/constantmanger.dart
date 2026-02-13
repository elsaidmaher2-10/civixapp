import 'package:civixapp/feature/onbroading/model/onbroadingmodel.dart';

class Constantmanger {
  static const String isOnboardingViewed = "is_show_on_board";
  static const String skip = "Skip";

  static final List<Onbroadingmodel> pages = [
    Onbroadingmodel(
      title: "Help Community",
      subtitle: "Report your problem as soon as possible",
      image: "assets/onbroadingimage/1.png",
    ),
    Onbroadingmodel(
      title: "Officials Are Acting",
      subtitle: "Work is underway to fix the problem",
      image: "assets/onbroadingimage/2.png",
    ),
    Onbroadingmodel(
      title: "Civilized City",
      subtitle: "Stable city with no problems",
      image: "assets/onbroadingimage/3.png",
    ),
  ];
  static const String civix = "Civix";

  // ================== Auth ==================
  static const String logIn = "Log In";
  static const String sinup = "Sign Up";
  static const String donthaveaccount = "Don’t have an account?";
  static const String Signup = "Sign up now";
  static const String forgetPassword = "Forget Password....?";

  // ================== Fields ==================
  static const String email = "Email";
  static const String pass = "Password";
  static const String phone = "Phone";
  static const String fname = "First Name";
  static const String lname = "Last Name";
  static const String confirmPassword = "Confirm Password";

  // ================== Hints ==================
  static const String hinytextemail = "Enter your email address";
  static const String hinytextpass = "********";
  static const String fnamehint = "Enter your First Name";
  static const String flnamehint = "Enter your Last Name";
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
  // ================== Password Rules ==================
  static const String passwordRulestitle =
      "Please add all necessary characters to create safe password.";

  static List<Map<String, dynamic>> passwordRules = [
    {"title": "Minimum characters 12", "status": false},
    {"title": "One uppercase character", "status": false},
    {"title": "One lowercase character", "status": false},
    {"title": "One special character", "status": false},
    {"title": "One number", "status": false},
  ];

  // ================== Media ==================
  static const String photoGallery = "Photo Gallery";
  static const String camera = "Camera";
  static const String cancel = "Cancel";
  static String submit = "Submit";

  static String nationalnumber = "National number";
}
