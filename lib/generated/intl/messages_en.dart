// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(count) =>
      "${count} ${Intl.plural(count, one: 'day', other: 'days')} ago";

  static String m1(count) =>
      "${count} ${Intl.plural(count, one: 'hour', other: 'hours')} ago";

  static String m2(count) => "${count} Messages";

  static String m3(count) =>
      "${count} ${Intl.plural(count, one: 'minute', other: 'minutes')} ago";

  static String m4(count) =>
      "${count} ${Intl.plural(count, one: 'week', other: 'weeks')} ago";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "accountInformation": MessageLookupByLibrary.simpleMessage(
      "Account information",
    ),
    "achievement": MessageLookupByLibrary.simpleMessage("Achievement"),
    "active": MessageLookupByLibrary.simpleMessage("Active"),
    "addCommentHint": MessageLookupByLibrary.simpleMessage(
      "Add a reply or a new inquiry...",
    ),
    "addCommentLabel": MessageLookupByLibrary.simpleMessage("Add Comment"),
    "addPhoto": MessageLookupByLibrary.simpleMessage("Add Photo"),
    "addReport": MessageLookupByLibrary.simpleMessage("Add Report"),
    "address": MessageLookupByLibrary.simpleMessage("Address"),
    "address2": MessageLookupByLibrary.simpleMessage("Address"),
    "age": MessageLookupByLibrary.simpleMessage("Age"),
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "appTitle": MessageLookupByLibrary.simpleMessage("CitiFix"),
    "arabic": MessageLookupByLibrary.simpleMessage("Arabic"),
    "assigned": MessageLookupByLibrary.simpleMessage("Assigned"),
    "camera": MessageLookupByLibrary.simpleMessage("Camera"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "caughtUpMessage": MessageLookupByLibrary.simpleMessage(
      "You are all caught up! Check back later.",
    ),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change Password"),
    "choosePreferredLanguage": MessageLookupByLibrary.simpleMessage(
      "Choose your preferred language",
    ),
    "citizen": MessageLookupByLibrary.simpleMessage("Citizen"),
    "citizenIdentity": MessageLookupByLibrary.simpleMessage("Citizen Identity"),
    "citizenResponsibilityDesc": MessageLookupByLibrary.simpleMessage(
      "1. Reports must be truthful and accurate.\n2. Photos must be clear and related to the issue.\n3. Misuse of the platform (fake reports) leads to a permanent ban.",
    ),
    "citizenResponsibilityTitle": MessageLookupByLibrary.simpleMessage(
      "Citizen Responsibilities",
    ),
    "civix": MessageLookupByLibrary.simpleMessage("Civix"),
    "comments": MessageLookupByLibrary.simpleMessage("Comments"),
    "completed": MessageLookupByLibrary.simpleMessage("Resolved"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "confirmDelete": MessageLookupByLibrary.simpleMessage("Confirm Delete"),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm Password"),
    "confirmPasswordRequired": MessageLookupByLibrary.simpleMessage(
      "Please confirm your password",
    ),
    "contactSupport": MessageLookupByLibrary.simpleMessage(
      "Still have questions? Contact Support",
    ),
    "dataSecurityNote": MessageLookupByLibrary.simpleMessage(
      "Your data is securely stored and encrypted.",
    ),
    "dateBirth": MessageLookupByLibrary.simpleMessage("Date Brith"),
    "dateOfBirth": MessageLookupByLibrary.simpleMessage("Date of Birth"),
    "dateRequired": MessageLookupByLibrary.simpleMessage(
      "Please choose date of birth",
    ),
    "daysAgo": m0,
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to delete this report?",
    ),
    "deleteall": MessageLookupByLibrary.simpleMessage("Delete all"),
    "describeIssue": MessageLookupByLibrary.simpleMessage(
      "Describe the issue...",
    ),
    "description": MessageLookupByLibrary.simpleMessage("Description"),
    "descriptionHint": MessageLookupByLibrary.simpleMessage(
      "Write a detailed description...",
    ),
    "descriptionIsRequired": MessageLookupByLibrary.simpleMessage(
      "Description is required",
    ),
    "descriptionLabel": MessageLookupByLibrary.simpleMessage("Description"),
    "descriptionTooShort": MessageLookupByLibrary.simpleMessage(
      "Description must be at least 10 characters",
    ),
    "details": MessageLookupByLibrary.simpleMessage("Details"),
    "dontHaveAccount": MessageLookupByLibrary.simpleMessage(
      "Don’t have an account?",
    ),
    "editProfile": MessageLookupByLibrary.simpleMessage("Edit Profile"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emailAlreadyExists": MessageLookupByLibrary.simpleMessage(
      "Email already exists or database error",
    ),
    "emailRequired": MessageLookupByLibrary.simpleMessage("Email is required"),
    "emptyReportsSubtitle": MessageLookupByLibrary.simpleMessage(
      "Any new reports you create will appear here.",
    ),
    "english": MessageLookupByLibrary.simpleMessage("English"),
    "enterConfirmPassword": MessageLookupByLibrary.simpleMessage(
      "Enter confirm password",
    ),
    "enterNewPassword": MessageLookupByLibrary.simpleMessage(
      "Enter new password",
    ),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "errorOccurred": MessageLookupByLibrary.simpleMessage(
      "Something went wrong",
    ),
    "errorTitle": MessageLookupByLibrary.simpleMessage(
      "Oops! Something went wrong.",
    ),
    "failedToLoadCategories": MessageLookupByLibrary.simpleMessage(
      "Failed to load categories",
    ),
    "faqCategory": MessageLookupByLibrary.simpleMessage(
      "Frequently Asked Questions",
    ),
    "fcm": MessageLookupByLibrary.simpleMessage("FCM"),
    "finish": MessageLookupByLibrary.simpleMessage("Get Started"),
    "firstName": MessageLookupByLibrary.simpleMessage("First Name"),
    "firstNameRequired": MessageLookupByLibrary.simpleMessage(
      "First name is required",
    ),
    "fixTimeAnswer": MessageLookupByLibrary.simpleMessage(
      "Repair time depends on the issue\'s severity. You can track the real-time progress in the \'My Reports\' section.",
    ),
    "fixTimeQuestion": MessageLookupByLibrary.simpleMessage(
      "How long does it take to fix a problem?",
    ),
    "forgetPassword": MessageLookupByLibrary.simpleMessage(
      "Forget Password....?",
    ),
    "forgetPasswordDesc": MessageLookupByLibrary.simpleMessage(
      "Please enter the email address associated with your account, and we\'ll send you an OTP to reset your password.",
    ),
    "forgetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Forgot Password",
    ),
    "forgotPassword": MessageLookupByLibrary.simpleMessage("Forgot Password"),
    "fullName": MessageLookupByLibrary.simpleMessage("Full Name"),
    "gender": MessageLookupByLibrary.simpleMessage("Gender"),
    "haveAccount": MessageLookupByLibrary.simpleMessage(
      "Have an account already?",
    ),
    "help": MessageLookupByLibrary.simpleMessage("Help & Terms"),
    "helpAndLegal": MessageLookupByLibrary.simpleMessage("Help & Legal"),
    "hintAddress": MessageLookupByLibrary.simpleMessage("Enter your address"),
    "hintEmail": MessageLookupByLibrary.simpleMessage(
      "Enter your email address",
    ),
    "hintFirstName": MessageLookupByLibrary.simpleMessage(
      "Enter your First Name",
    ),
    "hintLastName": MessageLookupByLibrary.simpleMessage(
      "Enter your Last Name",
    ),
    "hintNationalNumber": MessageLookupByLibrary.simpleMessage(
      "Enter National number",
    ),
    "hintPassword": MessageLookupByLibrary.simpleMessage("********"),
    "hintPhone": MessageLookupByLibrary.simpleMessage("Enter your Phone"),
    "home": MessageLookupByLibrary.simpleMessage("Home"),
    "hoursAgo": m1,
    "howToReportAnswer": MessageLookupByLibrary.simpleMessage(
      "Open the app, tap the \'+\' button, take a photo, and pin the location. Our system will automatically notify the nearest worker.",
    ),
    "howToReportQuestion": MessageLookupByLibrary.simpleMessage(
      "How do I report a maintenance issue?",
    ),
    "identity": MessageLookupByLibrary.simpleMessage("Identity"),
    "imageRequired": MessageLookupByLibrary.simpleMessage("Image is required"),
    "inProgress": MessageLookupByLibrary.simpleMessage("In Progress"),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
    "invalidPassword": MessageLookupByLibrary.simpleMessage(
      "Password must be at least 6 characters and include letters and numbers and special characters",
    ),
    "invalidPhone": MessageLookupByLibrary.simpleMessage("Invalid phone"),
    "isOnboardingViewed": MessageLookupByLibrary.simpleMessage(
      "is_show_on_board",
    ),
    "job": MessageLookupByLibrary.simpleMessage("Job"),
    "justNow": MessageLookupByLibrary.simpleMessage("Just now"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "lastName": MessageLookupByLibrary.simpleMessage("Last Name"),
    "lastNameRequired": MessageLookupByLibrary.simpleMessage(
      "Last name is required",
    ),
    "legalCategory": MessageLookupByLibrary.simpleMessage("Legal & Privacy"),
    "loadingCategories": MessageLookupByLibrary.simpleMessage(
      "Loading Categories...",
    ),
    "location": MessageLookupByLibrary.simpleMessage("Location"),
    "logIn": MessageLookupByLibrary.simpleMessage("log in"),
    "login": MessageLookupByLibrary.simpleMessage("Log in"),
    "logout": MessageLookupByLibrary.simpleMessage("Log out"),
    "logoutConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to log out of your account?",
    ),
    "markAllRead": MessageLookupByLibrary.simpleMessage("Mark all read"),
    "messagesCount": m2,
    "minutesAgo": m3,
    "msgRegister": MessageLookupByLibrary.simpleMessage(
      "we have sent a 6-digit code to your registered email address/phone number",
    ),
    "msgResetPassword": MessageLookupByLibrary.simpleMessage(
      "We’ve sent you a code to reset your password. Please check your email.",
    ),
    "msgResettingPass": MessageLookupByLibrary.simpleMessage(
      "Code verified successfully. Please set your new password.",
    ),
    "msgResettingPassword": MessageLookupByLibrary.simpleMessage(
      "Resetting password...",
    ),
    "nationalID": MessageLookupByLibrary.simpleMessage("National ID"),
    "nationalIdDigits": MessageLookupByLibrary.simpleMessage(
      "National ID must contain only digits",
    ),
    "nationalIdLength": MessageLookupByLibrary.simpleMessage(
      "National ID must be exactly 14 digits",
    ),
    "nationalIdRequired": MessageLookupByLibrary.simpleMessage(
      "Please enter national ID",
    ),
    "nationalNumber": MessageLookupByLibrary.simpleMessage("National number"),
    "newPassword": MessageLookupByLibrary.simpleMessage("New Password"),
    "next": MessageLookupByLibrary.simpleMessage("Next"),
    "noCommentsYet": MessageLookupByLibrary.simpleMessage(
      "No comments yet. Be the first to reply!",
    ),
    "noData": MessageLookupByLibrary.simpleMessage(
      "No data available at the moment",
    ),
    "noInternet": MessageLookupByLibrary.simpleMessage(
      "No internet connection",
    ),
    "noNotifications": MessageLookupByLibrary.simpleMessage(
      "No new notifications",
    ),
    "noRecentReports": MessageLookupByLibrary.simpleMessage(
      "No recent reports",
    ),
    "noReportsAvailable": MessageLookupByLibrary.simpleMessage(
      "No reports available currently",
    ),
    "noResult": MessageLookupByLibrary.simpleMessage("No results found"),
    "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
    "oldPassword": MessageLookupByLibrary.simpleMessage("Old Password"),
    "otpMsgRegister": MessageLookupByLibrary.simpleMessage(
      "Enter the code sent to your email",
    ),
    "otpMsgResetPassword": MessageLookupByLibrary.simpleMessage(
      "Enter the code to reset your password",
    ),
    "otpVerification": MessageLookupByLibrary.simpleMessage("OTP Verification"),
    "overview": MessageLookupByLibrary.simpleMessage("OverView"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordLowercase": MessageLookupByLibrary.simpleMessage(
      "One lowercase character",
    ),
    "passwordMinLength": MessageLookupByLibrary.simpleMessage(
      "Minimum 12 characters",
    ),
    "passwordNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "passwordNumber": MessageLookupByLibrary.simpleMessage("One number"),
    "passwordRequired": MessageLookupByLibrary.simpleMessage(
      "Password is required",
    ),
    "passwordRulesTitle": MessageLookupByLibrary.simpleMessage(
      "Please add all necessary characters to create safe password.",
    ),
    "passwordSpecialChar": MessageLookupByLibrary.simpleMessage(
      "One special character",
    ),
    "passwordUppercase": MessageLookupByLibrary.simpleMessage(
      "One uppercase character",
    ),
    "passwordsDoNotMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords do not match",
    ),
    "pending": MessageLookupByLibrary.simpleMessage("Pending"),
    "phone": MessageLookupByLibrary.simpleMessage("Phone"),
    "phoneRequired": MessageLookupByLibrary.simpleMessage("Phone is required"),
    "photoGallery": MessageLookupByLibrary.simpleMessage("Photo Gallery"),
    "privacyPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Citifix protects your privacy. Citizen contact details are hidden from workers; they only receive the location and issue description.",
    ),
    "privacyPolicyTitle": MessageLookupByLibrary.simpleMessage(
      "Data Protection Policy",
    ),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileUpdatedSuccess": MessageLookupByLibrary.simpleMessage(
      "Profile updated successfully",
    ),
    "progressTracking": MessageLookupByLibrary.simpleMessage(
      "Progress Tracking",
    ),
    "recentReport": MessageLookupByLibrary.simpleMessage("My Recent Reports"),
    "reference": MessageLookupByLibrary.simpleMessage("Reference:"),
    "rememberMe": MessageLookupByLibrary.simpleMessage("Remember me"),
    "reportDescription": MessageLookupByLibrary.simpleMessage(
      "Report Description",
    ),
    "reportDescriptionHint": MessageLookupByLibrary.simpleMessage(
      "Describe the details of the Report",
    ),
    "reportDetails": MessageLookupByLibrary.simpleMessage("Report Details"),
    "reportSentSuccess": MessageLookupByLibrary.simpleMessage(
      "Report sent successfully",
    ),
    "reportTitle": MessageLookupByLibrary.simpleMessage("Street hole"),
    "reportTitleHint": MessageLookupByLibrary.simpleMessage("Report title"),
    "reportTitleLabel": MessageLookupByLibrary.simpleMessage("Report Title"),
    "reportedBy": MessageLookupByLibrary.simpleMessage("Reported by"),
    "reporter": MessageLookupByLibrary.simpleMessage("Reporter"),
    "reports": MessageLookupByLibrary.simpleMessage("Reports"),
    "resendCode": MessageLookupByLibrary.simpleMessage("Resend Code"),
    "resendCodeIn": MessageLookupByLibrary.simpleMessage("Resend Code In"),
    "resetPasswordPurpose": MessageLookupByLibrary.simpleMessage(
      "reset your password",
    ),
    "resolved": MessageLookupByLibrary.simpleMessage("Resolved"),
    "resolvedReports": MessageLookupByLibrary.simpleMessage("Resolved Reports"),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("Save Changes"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "searchHint": MessageLookupByLibrary.simpleMessage("Search for report..."),
    "searchHint1": MessageLookupByLibrary.simpleMessage(
      "Search for \"Water leak\"",
    ),
    "searchHint2": MessageLookupByLibrary.simpleMessage(
      "Search for \"Broken streetlight\"",
    ),
    "searchHint3": MessageLookupByLibrary.simpleMessage(
      "Search for \"Waste accumulation\"",
    ),
    "searchHint4": MessageLookupByLibrary.simpleMessage(
      "Search for \"Pothole repair\"",
    ),
    "searchHint5": MessageLookupByLibrary.simpleMessage(
      "Describe the issue...",
    ),
    "searchMyReports": MessageLookupByLibrary.simpleMessage(
      "Search my reports",
    ),
    "searchPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Search reports...",
    ),
    "searchPothole": MessageLookupByLibrary.simpleMessage(
      "Search for \"Pothole repair\"",
    ),
    "searchStreetlight": MessageLookupByLibrary.simpleMessage(
      "Search for \"Broken streetlight\"",
    ),
    "searchWaste": MessageLookupByLibrary.simpleMessage(
      "Search for \"Waste accumulation\"",
    ),
    "searchWaterLeak": MessageLookupByLibrary.simpleMessage(
      "Search for \"Water leak\"",
    ),
    "seeAll": MessageLookupByLibrary.simpleMessage("See all"),
    "selectCategory": MessageLookupByLibrary.simpleMessage("Select Category"),
    "selectCategoryHint": MessageLookupByLibrary.simpleMessage(
      "Select Category",
    ),
    "selectLanguage": MessageLookupByLibrary.simpleMessage("Select Language"),
    "selectRole": MessageLookupByLibrary.simpleMessage("Select a role"),
    "selectRoleError": MessageLookupByLibrary.simpleMessage(
      "Please select a role",
    ),
    "sendCode": MessageLookupByLibrary.simpleMessage("Send Code"),
    "sendReport": MessageLookupByLibrary.simpleMessage("Submit Report"),
    "settings": MessageLookupByLibrary.simpleMessage("SETTINGS"),
    "signUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "signUpNow": MessageLookupByLibrary.simpleMessage("Sign up now"),
    "skip": MessageLookupByLibrary.simpleMessage("Skip"),
    "submit": MessageLookupByLibrary.simpleMessage("Submit"),
    "submitted": MessageLookupByLibrary.simpleMessage("Submitted:"),
    "success": MessageLookupByLibrary.simpleMessage("Success"),
    "support": MessageLookupByLibrary.simpleMessage("Support"),
    "termsCitizenCategory": MessageLookupByLibrary.simpleMessage(
      "Terms for Citizens",
    ),
    "termsWorkerCategory": MessageLookupByLibrary.simpleMessage(
      "Terms for Workers",
    ),
    "titleIsRequired": MessageLookupByLibrary.simpleMessage(
      "Title is required",
    ),
    "titleTooShort": MessageLookupByLibrary.simpleMessage(
      "Title must be at least 3 characters",
    ),
    "topAchievements": MessageLookupByLibrary.simpleMessage(
      "Top Achievement Reports",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Try Again"),
    "unknownLocation": MessageLookupByLibrary.simpleMessage("Unknown Location"),
    "unknownStatus": MessageLookupByLibrary.simpleMessage("Unknown"),
    "unread": MessageLookupByLibrary.simpleMessage("unread"),
    "weeksAgo": m4,
    "worker": MessageLookupByLibrary.simpleMessage("Worker"),
    "workerConductDesc": MessageLookupByLibrary.simpleMessage(
      "1. Workers must upload \'Before\' and \'After\' photos for every task.\n2. Tasks must be completed within the assigned timeframe.\n3. Professional behavior is mandatory during site visits.",
    ),
    "workerConductTitle": MessageLookupByLibrary.simpleMessage(
      "Worker Standards & Conduct",
    ),
  };
}
