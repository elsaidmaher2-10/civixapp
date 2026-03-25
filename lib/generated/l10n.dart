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
