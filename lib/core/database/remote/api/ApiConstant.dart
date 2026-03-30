class Apiconstant {
  static String baseurl = "https://citifix.runasp.net/api/";
  static String signupendpoint = "Account/signup";
  static String confirmemaillogin = "Account/confirm-email-login";
  static String sendotp = "Account/send-otp";
  static String loginendpoint = "Account/login";
  static String createnewpassowrdAPIEndpoint = "Account/reset-password";
  static String verifyotp = "Account/verify-otp";
  static String getUserProfile = "Account/profile";
  static String newAccessToken = "Account/refresh-token";
  static String updateiamge = "Account/update-image";
  static String report = "/Reports";
  static String editUserProfile = "Account/edit";
  static String changePasswordAPIEndpoint = "Account/change-password";
  static String notificationRegister = "notifications/register-device";
  static String notification = "notifications";

  static String clearallnotification = "notifications/clear";

  static String workerdashboard = "Worker/dashboard";
  static String workertasks = "Worker/my-reports";

  static String markallread = "notifications/mark-all-read";
  static String getcomments(int reportId) => "/reports/$reportId/comments";
}
