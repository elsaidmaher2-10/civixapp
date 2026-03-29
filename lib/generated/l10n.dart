// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `is_show_on_board`
  String get isOnboardingViewed {
    return Intl.message(
      'is_show_on_board',
      name: 'isOnboardingViewed',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Civix`
  String get civix {
    return Intl.message('Civix', name: 'civix', desc: '', args: []);
  }

  /// `No internet connection`
  String get noInternet {
    return Intl.message(
      'No internet connection',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `log in`
  String get logIn {
    return Intl.message('log in', name: 'logIn', desc: '', args: []);
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Don’t have an account?`
  String get dontHaveAccount {
    return Intl.message(
      'Don’t have an account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up now`
  String get signUpNow {
    return Intl.message('Sign up now', name: 'signUpNow', desc: '', args: []);
  }

  /// `Forget Password....?`
  String get forgetPassword {
    return Intl.message(
      'Forget Password....?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Date Brith`
  String get dateBirth {
    return Intl.message('Date Brith', name: 'dateBirth', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Phone`
  String get phone {
    return Intl.message('Phone', name: 'phone', desc: '', args: []);
  }

  /// `First Name`
  String get firstName {
    return Intl.message('First Name', name: 'firstName', desc: '', args: []);
  }

  /// `Last Name`
  String get lastName {
    return Intl.message('Last Name', name: 'lastName', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Enter your email address`
  String get hintEmail {
    return Intl.message(
      'Enter your email address',
      name: 'hintEmail',
      desc: '',
      args: [],
    );
  }

  /// `********`
  String get hintPassword {
    return Intl.message('********', name: 'hintPassword', desc: '', args: []);
  }

  /// `Enter your First Name`
  String get hintFirstName {
    return Intl.message(
      'Enter your First Name',
      name: 'hintFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Last Name`
  String get hintLastName {
    return Intl.message(
      'Enter your Last Name',
      name: 'hintLastName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your address`
  String get hintAddress {
    return Intl.message(
      'Enter your address',
      name: 'hintAddress',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Phone`
  String get hintPhone {
    return Intl.message(
      'Enter your Phone',
      name: 'hintPhone',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message('Remember me', name: 'rememberMe', desc: '', args: []);
  }

  /// `First name is required`
  String get firstNameRequired {
    return Intl.message(
      'First name is required',
      name: 'firstNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Last name is required`
  String get lastNameRequired {
    return Intl.message(
      'Last name is required',
      name: 'lastNameRequired',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailRequired {
    return Intl.message(
      'Email is required',
      name: 'emailRequired',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordRequired {
    return Intl.message(
      'Password is required',
      name: 'passwordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Phone is required`
  String get phoneRequired {
    return Intl.message(
      'Phone is required',
      name: 'phoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Image is required`
  String get imageRequired {
    return Intl.message(
      'Image is required',
      name: 'imageRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone`
  String get invalidPhone {
    return Intl.message(
      'Invalid phone',
      name: 'invalidPhone',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters and include letters and numbers and special characters`
  String get invalidPassword {
    return Intl.message(
      'Password must be at least 6 characters and include letters and numbers and special characters',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email already exists or database error`
  String get emailAlreadyExists {
    return Intl.message(
      'Email already exists or database error',
      name: 'emailAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `Please add all necessary characters to create safe password.`
  String get passwordRulesTitle {
    return Intl.message(
      'Please add all necessary characters to create safe password.',
      name: 'passwordRulesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Photo Gallery`
  String get photoGallery {
    return Intl.message(
      'Photo Gallery',
      name: 'photoGallery',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Submit`
  String get submit {
    return Intl.message('Submit', name: 'submit', desc: '', args: []);
  }

  /// `National number`
  String get nationalNumber {
    return Intl.message(
      'National number',
      name: 'nationalNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter National number`
  String get hintNationalNumber {
    return Intl.message(
      'Enter National number',
      name: 'hintNationalNumber',
      desc: '',
      args: [],
    );
  }

  /// `We’ve sent you a code to reset your password. Please check your email.`
  String get msgResetPassword {
    return Intl.message(
      'We’ve sent you a code to reset your password. Please check your email.',
      name: 'msgResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `we have sent a 6-digit code to your registered email address/phone number`
  String get msgRegister {
    return Intl.message(
      'we have sent a 6-digit code to your registered email address/phone number',
      name: 'msgRegister',
      desc: '',
      args: [],
    );
  }

  /// `Code verified successfully. Please set your new password.`
  String get msgResettingPass {
    return Intl.message(
      'Code verified successfully. Please set your new password.',
      name: 'msgResettingPass',
      desc: '',
      args: [],
    );
  }

  /// `CitiFix`
  String get appTitle {
    return Intl.message('CitiFix', name: 'appTitle', desc: '', args: []);
  }

  /// `Active`
  String get active {
    return Intl.message('Active', name: 'active', desc: '', args: []);
  }

  /// `Pending`
  String get pending {
    return Intl.message('Pending', name: 'pending', desc: '', args: []);
  }

  /// `Resolved`
  String get completed {
    return Intl.message('Resolved', name: 'completed', desc: '', args: []);
  }

  /// `Get Started`
  String get finish {
    return Intl.message('Get Started', name: 'finish', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Submit Report`
  String get sendReport {
    return Intl.message(
      'Submit Report',
      name: 'sendReport',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Select Category`
  String get selectCategory {
    return Intl.message(
      'Select Category',
      name: 'selectCategory',
      desc: '',
      args: [],
    );
  }

  /// `Describe the details of the Report`
  String get reportDescriptionHint {
    return Intl.message(
      'Describe the details of the Report',
      name: 'reportDescriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Report Description`
  String get reportDescription {
    return Intl.message(
      'Report Description',
      name: 'reportDescription',
      desc: '',
      args: [],
    );
  }

  /// `Street hole`
  String get reportTitle {
    return Intl.message('Street hole', name: 'reportTitle', desc: '', args: []);
  }

  /// `Report title`
  String get reportTitleHint {
    return Intl.message(
      'Report title',
      name: 'reportTitleHint',
      desc: '',
      args: [],
    );
  }

  /// `Add Report`
  String get addReport {
    return Intl.message('Add Report', name: 'addReport', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Identity`
  String get identity {
    return Intl.message('Identity', name: 'identity', desc: '', args: []);
  }

  /// `Support`
  String get support {
    return Intl.message('Support', name: 'support', desc: '', args: []);
  }

  /// `Account information`
  String get accountInformation {
    return Intl.message(
      'Account information',
      name: 'accountInformation',
      desc: '',
      args: [],
    );
  }

  /// `SETTINGS`
  String get settings {
    return Intl.message('SETTINGS', name: 'settings', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `OverView`
  String get overview {
    return Intl.message('OverView', name: 'overview', desc: '', args: []);
  }

  /// `My Recent Reports`
  String get recentReport {
    return Intl.message(
      'My Recent Reports',
      name: 'recentReport',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get seeAll {
    return Intl.message('See all', name: 'seeAll', desc: '', args: []);
  }

  /// `Search my reports`
  String get searchMyReports {
    return Intl.message(
      'Search my reports',
      name: 'searchMyReports',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Log out`
  String get logout {
    return Intl.message('Log out', name: 'logout', desc: '', args: []);
  }

  /// `Reports`
  String get reports {
    return Intl.message('Reports', name: 'reports', desc: '', args: []);
  }

  /// `Report Details`
  String get reportDetails {
    return Intl.message(
      'Report Details',
      name: 'reportDetails',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Choose your preferred language`
  String get choosePreferredLanguage {
    return Intl.message(
      'Choose your preferred language',
      name: 'choosePreferredLanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Citizen Identity`
  String get citizenIdentity {
    return Intl.message(
      'Citizen Identity',
      name: 'citizenIdentity',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `National ID`
  String get nationalID {
    return Intl.message('National ID', name: 'nationalID', desc: '', args: []);
  }

  /// `Address`
  String get address2 {
    return Intl.message('Address', name: 'address2', desc: '', args: []);
  }

  /// `Job`
  String get job {
    return Intl.message('Job', name: 'job', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Age`
  String get age {
    return Intl.message('Age', name: 'age', desc: '', args: []);
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `FCM`
  String get fcm {
    return Intl.message('FCM', name: 'fcm', desc: '', args: []);
  }

  /// `Please confirm your password`
  String get confirmPasswordRequired {
    return Intl.message(
      'Please confirm your password',
      name: 'confirmPasswordRequired',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Please enter national ID`
  String get nationalIdRequired {
    return Intl.message(
      'Please enter national ID',
      name: 'nationalIdRequired',
      desc: '',
      args: [],
    );
  }

  /// `National ID must be exactly 14 digits`
  String get nationalIdLength {
    return Intl.message(
      'National ID must be exactly 14 digits',
      name: 'nationalIdLength',
      desc: '',
      args: [],
    );
  }

  /// `National ID must contain only digits`
  String get nationalIdDigits {
    return Intl.message(
      'National ID must contain only digits',
      name: 'nationalIdDigits',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of Birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Please choose date of birth`
  String get dateRequired {
    return Intl.message(
      'Please choose date of birth',
      name: 'dateRequired',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter new password`
  String get enterNewPassword {
    return Intl.message(
      'Enter new password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Minimum 12 characters`
  String get passwordMinLength {
    return Intl.message(
      'Minimum 12 characters',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `One uppercase character`
  String get passwordUppercase {
    return Intl.message(
      'One uppercase character',
      name: 'passwordUppercase',
      desc: '',
      args: [],
    );
  }

  /// `One lowercase character`
  String get passwordLowercase {
    return Intl.message(
      'One lowercase character',
      name: 'passwordLowercase',
      desc: '',
      args: [],
    );
  }

  /// `One special character`
  String get passwordSpecialChar {
    return Intl.message(
      'One special character',
      name: 'passwordSpecialChar',
      desc: '',
      args: [],
    );
  }

  /// `One number`
  String get passwordNumber {
    return Intl.message(
      'One number',
      name: 'passwordNumber',
      desc: '',
      args: [],
    );
  }

  /// `Select a role`
  String get selectRole {
    return Intl.message(
      'Select a role',
      name: 'selectRole',
      desc: '',
      args: [],
    );
  }

  /// `Worker`
  String get worker {
    return Intl.message('Worker', name: 'worker', desc: '', args: []);
  }

  /// `Citizen`
  String get citizen {
    return Intl.message('Citizen', name: 'citizen', desc: '', args: []);
  }

  /// `Please select a role`
  String get selectRoleError {
    return Intl.message(
      'Please select a role',
      name: 'selectRoleError',
      desc: '',
      args: [],
    );
  }

  /// `Have an account already?`
  String get haveAccount {
    return Intl.message(
      'Have an account already?',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message('Log in', name: 'login', desc: '', args: []);
  }

  /// `Forgot Password`
  String get forgetPasswordTitle {
    return Intl.message(
      'Forgot Password',
      name: 'forgetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the email address associated with your account, and we'll send you an OTP to reset your password.`
  String get forgetPasswordDesc {
    return Intl.message(
      'Please enter the email address associated with your account, and we\'ll send you an OTP to reset your password.',
      name: 'forgetPasswordDesc',
      desc: '',
      args: [],
    );
  }

  /// `Send Code`
  String get sendCode {
    return Intl.message('Send Code', name: 'sendCode', desc: '', args: []);
  }

  /// `reset your password`
  String get resetPasswordPurpose {
    return Intl.message(
      'reset your password',
      name: 'resetPasswordPurpose',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Enter the code sent to your email`
  String get otpMsgRegister {
    return Intl.message(
      'Enter the code sent to your email',
      name: 'otpMsgRegister',
      desc: '',
      args: [],
    );
  }

  /// `Enter the code to reset your password`
  String get otpMsgResetPassword {
    return Intl.message(
      'Enter the code to reset your password',
      name: 'otpMsgResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Resetting password...`
  String get msgResettingPassword {
    return Intl.message(
      'Resetting password...',
      name: 'msgResettingPassword',
      desc: '',
      args: [],
    );
  }

  /// `OTP Verification`
  String get otpVerification {
    return Intl.message(
      'OTP Verification',
      name: 'otpVerification',
      desc: '',
      args: [],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message('Resend Code', name: 'resendCode', desc: '', args: []);
  }

  /// `Resend Code In`
  String get resendCodeIn {
    return Intl.message(
      'Resend Code In',
      name: 'resendCodeIn',
      desc: '',
      args: [],
    );
  }

  /// `Enter confirm password`
  String get enterConfirmPassword {
    return Intl.message(
      'Enter confirm password',
      name: 'enterConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message('Success', name: 'success', desc: '', args: []);
  }

  /// `Error`
  String get error {
    return Intl.message('Error', name: 'error', desc: '', args: []);
  }

  /// `Forgot Password`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldPassword {
    return Intl.message(
      'Old Password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Achievement`
  String get achievement {
    return Intl.message('Achievement', name: 'achievement', desc: '', args: []);
  }

  /// `No recent reports`
  String get noRecentReports {
    return Intl.message(
      'No recent reports',
      name: 'noRecentReports',
      desc: '',
      args: [],
    );
  }

  /// `Any new reports you create will appear here.`
  String get emptyReportsSubtitle {
    return Intl.message(
      'Any new reports you create will appear here.',
      name: 'emptyReportsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Unknown Location`
  String get unknownLocation {
    return Intl.message(
      'Unknown Location',
      name: 'unknownLocation',
      desc: '',
      args: [],
    );
  }

  /// `Report sent successfully`
  String get reportSentSuccess {
    return Intl.message(
      'Report sent successfully',
      name: 'reportSentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get errorOccurred {
    return Intl.message(
      'Something went wrong',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Title is required`
  String get titleIsRequired {
    return Intl.message(
      'Title is required',
      name: 'titleIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Title must be at least 3 characters`
  String get titleTooShort {
    return Intl.message(
      'Title must be at least 3 characters',
      name: 'titleTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Description is required`
  String get descriptionIsRequired {
    return Intl.message(
      'Description is required',
      name: 'descriptionIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Description must be at least 10 characters`
  String get descriptionTooShort {
    return Intl.message(
      'Description must be at least 10 characters',
      name: 'descriptionTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Report Title`
  String get reportTitleLabel {
    return Intl.message(
      'Report Title',
      name: 'reportTitleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get descriptionLabel {
    return Intl.message(
      'Description',
      name: 'descriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Write a detailed description...`
  String get descriptionHint {
    return Intl.message(
      'Write a detailed description...',
      name: 'descriptionHint',
      desc: '',
      args: [],
    );
  }

  /// `Add Photo`
  String get addPhoto {
    return Intl.message('Add Photo', name: 'addPhoto', desc: '', args: []);
  }

  /// `Loading Categories...`
  String get loadingCategories {
    return Intl.message(
      'Loading Categories...',
      name: 'loadingCategories',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load categories`
  String get failedToLoadCategories {
    return Intl.message(
      'Failed to load categories',
      name: 'failedToLoadCategories',
      desc: '',
      args: [],
    );
  }

  /// `Select Category`
  String get selectCategoryHint {
    return Intl.message(
      'Select Category',
      name: 'selectCategoryHint',
      desc: '',
      args: [],
    );
  }

  /// `No results found`
  String get noResult {
    return Intl.message(
      'No results found',
      name: 'noResult',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknownStatus {
    return Intl.message('Unknown', name: 'unknownStatus', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `In Progress`
  String get inProgress {
    return Intl.message('In Progress', name: 'inProgress', desc: '', args: []);
  }

  /// `No reports available currently`
  String get noReportsAvailable {
    return Intl.message(
      'No reports available currently',
      name: 'noReportsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Resolved`
  String get resolved {
    return Intl.message('Resolved', name: 'resolved', desc: '', args: []);
  }

  /// `Submitted:`
  String get submitted {
    return Intl.message('Submitted:', name: 'submitted', desc: '', args: []);
  }

  /// `Reference:`
  String get reference {
    return Intl.message('Reference:', name: 'reference', desc: '', args: []);
  }

  /// `Details`
  String get details {
    return Intl.message('Details', name: 'details', desc: '', args: []);
  }

  /// `Search for report...`
  String get searchHint {
    return Intl.message(
      'Search for report...',
      name: 'searchHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Delete`
  String get confirmDelete {
    return Intl.message(
      'Confirm Delete',
      name: 'confirmDelete',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this report?`
  String get deleteConfirmationMessage {
    return Intl.message(
      'Are you sure you want to delete this report?',
      name: 'deleteConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Just now`
  String get justNow {
    return Intl.message('Just now', name: 'justNow', desc: '', args: []);
  }

  /// `{count} {count, plural, =1{minute} other{minutes}} ago`
  String minutesAgo(num count) {
    return Intl.message(
      '$count ${Intl.plural(count, one: 'minute', other: 'minutes')} ago',
      name: 'minutesAgo',
      desc: '',
      args: [count],
    );
  }

  /// `{count} {count, plural, =1{hour} other{hours}} ago`
  String hoursAgo(num count) {
    return Intl.message(
      '$count ${Intl.plural(count, one: 'hour', other: 'hours')} ago',
      name: 'hoursAgo',
      desc: '',
      args: [count],
    );
  }

  /// `{count} {count, plural, =1{day} other{days}} ago`
  String daysAgo(num count) {
    return Intl.message(
      '$count ${Intl.plural(count, one: 'day', other: 'days')} ago',
      name: 'daysAgo',
      desc: '',
      args: [count],
    );
  }

  /// `{count} {count, plural, =1{week} other{weeks}} ago`
  String weeksAgo(num count) {
    return Intl.message(
      '$count ${Intl.plural(count, one: 'week', other: 'weeks')} ago',
      name: 'weeksAgo',
      desc: '',
      args: [count],
    );
  }

  /// `Search for "Water leak"`
  String get searchHint1 {
    return Intl.message(
      'Search for "Water leak"',
      name: 'searchHint1',
      desc: '',
      args: [],
    );
  }

  /// `Search for "Broken streetlight"`
  String get searchHint2 {
    return Intl.message(
      'Search for "Broken streetlight"',
      name: 'searchHint2',
      desc: '',
      args: [],
    );
  }

  /// `Search for "Waste accumulation"`
  String get searchHint3 {
    return Intl.message(
      'Search for "Waste accumulation"',
      name: 'searchHint3',
      desc: '',
      args: [],
    );
  }

  /// `Search for "Pothole repair"`
  String get searchHint4 {
    return Intl.message(
      'Search for "Pothole repair"',
      name: 'searchHint4',
      desc: '',
      args: [],
    );
  }

  /// `Describe the issue...`
  String get searchHint5 {
    return Intl.message(
      'Describe the issue...',
      name: 'searchHint5',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Progress Tracking`
  String get progressTracking {
    return Intl.message(
      'Progress Tracking',
      name: 'progressTracking',
      desc: '',
      args: [],
    );
  }

  /// `Reported by`
  String get reportedBy {
    return Intl.message('Reported by', name: 'reportedBy', desc: '', args: []);
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message('Try Again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Are you sure you want to log out of your account?`
  String get logoutConfirmationMessage {
    return Intl.message(
      'Are you sure you want to log out of your account?',
      name: 'logoutConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdatedSuccess {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Your data is securely stored and encrypted.`
  String get dataSecurityNote {
    return Intl.message(
      'Your data is securely stored and encrypted.',
      name: 'dataSecurityNote',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Mark all read`
  String get markAllRead {
    return Intl.message(
      'Mark all read',
      name: 'markAllRead',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong.`
  String get errorTitle {
    return Intl.message(
      'Oops! Something went wrong.',
      name: 'errorTitle',
      desc: '',
      args: [],
    );
  }

  /// `No new notifications`
  String get noNotifications {
    return Intl.message(
      'No new notifications',
      name: 'noNotifications',
      desc: '',
      args: [],
    );
  }

  /// `You are all caught up! Check back later.`
  String get caughtUpMessage {
    return Intl.message(
      'You are all caught up! Check back later.',
      name: 'caughtUpMessage',
      desc: '',
      args: [],
    );
  }

  /// `Search for "Water leak"`
  String get searchWaterLeak {
    return Intl.message(
      'Search for "Water leak"',
      name: 'searchWaterLeak',
      desc: '',
      args: [],
    );
  }

  /// `Search for "Broken streetlight"`
  String get searchStreetlight {
    return Intl.message(
      'Search for "Broken streetlight"',
      name: 'searchStreetlight',
      desc: '',
      args: [],
    );
  }

  /// `Search for "Waste accumulation"`
  String get searchWaste {
    return Intl.message(
      'Search for "Waste accumulation"',
      name: 'searchWaste',
      desc: '',
      args: [],
    );
  }

  /// `Search for "Pothole repair"`
  String get searchPothole {
    return Intl.message(
      'Search for "Pothole repair"',
      name: 'searchPothole',
      desc: '',
      args: [],
    );
  }

  /// `Describe the issue...`
  String get describeIssue {
    return Intl.message(
      'Describe the issue...',
      name: 'describeIssue',
      desc: '',
      args: [],
    );
  }

  /// `Help & Terms`
  String get help {
    return Intl.message('Help & Terms', name: 'help', desc: '', args: []);
  }

  /// `Help & Legal`
  String get helpAndLegal {
    return Intl.message(
      'Help & Legal',
      name: 'helpAndLegal',
      desc: '',
      args: [],
    );
  }

  /// `Still have questions? Contact Support`
  String get contactSupport {
    return Intl.message(
      'Still have questions? Contact Support',
      name: 'contactSupport',
      desc: '',
      args: [],
    );
  }

  /// `Frequently Asked Questions`
  String get faqCategory {
    return Intl.message(
      'Frequently Asked Questions',
      name: 'faqCategory',
      desc: '',
      args: [],
    );
  }

  /// `How do I report a maintenance issue?`
  String get howToReportQuestion {
    return Intl.message(
      'How do I report a maintenance issue?',
      name: 'howToReportQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Open the app, tap the '+' button, take a photo, and pin the location. Our system will automatically notify the nearest worker.`
  String get howToReportAnswer {
    return Intl.message(
      'Open the app, tap the \'+\' button, take a photo, and pin the location. Our system will automatically notify the nearest worker.',
      name: 'howToReportAnswer',
      desc: '',
      args: [],
    );
  }

  /// `How long does it take to fix a problem?`
  String get fixTimeQuestion {
    return Intl.message(
      'How long does it take to fix a problem?',
      name: 'fixTimeQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Repair time depends on the issue's severity. You can track the real-time progress in the 'My Reports' section.`
  String get fixTimeAnswer {
    return Intl.message(
      'Repair time depends on the issue\'s severity. You can track the real-time progress in the \'My Reports\' section.',
      name: 'fixTimeAnswer',
      desc: '',
      args: [],
    );
  }

  /// `Terms for Citizens`
  String get termsCitizenCategory {
    return Intl.message(
      'Terms for Citizens',
      name: 'termsCitizenCategory',
      desc: '',
      args: [],
    );
  }

  /// `Citizen Responsibilities`
  String get citizenResponsibilityTitle {
    return Intl.message(
      'Citizen Responsibilities',
      name: 'citizenResponsibilityTitle',
      desc: '',
      args: [],
    );
  }

  /// `1. Reports must be truthful and accurate.\n2. Photos must be clear and related to the issue.\n3. Misuse of the platform (fake reports) leads to a permanent ban.`
  String get citizenResponsibilityDesc {
    return Intl.message(
      '1. Reports must be truthful and accurate.\n2. Photos must be clear and related to the issue.\n3. Misuse of the platform (fake reports) leads to a permanent ban.',
      name: 'citizenResponsibilityDesc',
      desc: '',
      args: [],
    );
  }

  /// `Terms for Workers`
  String get termsWorkerCategory {
    return Intl.message(
      'Terms for Workers',
      name: 'termsWorkerCategory',
      desc: '',
      args: [],
    );
  }

  /// `Worker Standards & Conduct`
  String get workerConductTitle {
    return Intl.message(
      'Worker Standards & Conduct',
      name: 'workerConductTitle',
      desc: '',
      args: [],
    );
  }

  /// `1. Workers must upload 'Before' and 'After' photos for every task.\n2. Tasks must be completed within the assigned timeframe.\n3. Professional behavior is mandatory during site visits.`
  String get workerConductDesc {
    return Intl.message(
      '1. Workers must upload \'Before\' and \'After\' photos for every task.\n2. Tasks must be completed within the assigned timeframe.\n3. Professional behavior is mandatory during site visits.',
      name: 'workerConductDesc',
      desc: '',
      args: [],
    );
  }

  /// `Legal & Privacy`
  String get legalCategory {
    return Intl.message(
      'Legal & Privacy',
      name: 'legalCategory',
      desc: '',
      args: [],
    );
  }

  /// `Data Protection Policy`
  String get privacyPolicyTitle {
    return Intl.message(
      'Data Protection Policy',
      name: 'privacyPolicyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Citifix protects your privacy. Citizen contact details are hidden from workers; they only receive the location and issue description.`
  String get privacyPolicyDesc {
    return Intl.message(
      'Citifix protects your privacy. Citizen contact details are hidden from workers; they only receive the location and issue description.',
      name: 'privacyPolicyDesc',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
