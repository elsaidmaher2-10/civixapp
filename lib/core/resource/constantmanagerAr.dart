import 'package:citifix/feature/citzenFeature/reports/data/Models/timelinestep/timelinestep.dart';
import 'package:citifix/feature/citzenFeature/onbroading/model/onbroadingmodel.dart';

class Constantmanagerar {
  Constantmanagerar._();

  static const String isOnboardingViewed = "is_show_on_board";
  static const String skip = "تخطي";

  static const String civix = "Civix";
  static String nointernet = "لا يوجد اتصال بالإنترنت";

  static final List<Onbroadingmodel> pages = [
    Onbroadingmodel(
      title: "الإبلاغ عن المشكلات",
      subtitle:
          "هل لاحظت مشكلة في منطقتك؟ يمكنك الإبلاغ عنها بسهولة مع صورة ووصف بسيط ليتم حلها بسرعة.",
      image: "assets/onbroadingimage/1.svg",
    ),
    Onbroadingmodel(
      title: "الجهات المختصة تعمل",
      subtitle: "جارٍ العمل على حل المشكلة",
      image: "assets/onbroadingimage/2.svg",
    ),
    Onbroadingmodel(
      title: "حسّن مدينتك",
      subtitle: "شارك مجتمعك في جعل مدينتك مكانًا أفضل للجميع. كل بلاغ مهم!",
      image: "assets/onbroadingimage/3.svg",
    ),
  ];

  static const String logIn = "تسجيل الدخول";
  static const String sinup = "إنشاء حساب";
  static const String donthaveaccount = "ليس لديك حساب؟";
  static const String Signup = "سجل الآن";
  static const String forgetPassword = "نسيت كلمة المرور؟";
  static const String datebrith = "تاريخ الميلاد";

  static const String email = "البريد الإلكتروني";
  static const String pass = "كلمة المرور";
  static const String phone = "رقم الهاتف";
  static const String fname = "الاسم الأول";
  static const String lname = "الاسم الأخير";
  static const String confirmPassword = "تأكيد كلمة المرور";
  static const String addressT = "العنوان";

  static const String hinytextemail = "أدخل بريدك الإلكتروني";
  static const String hinytextpass = "********";
  static const String fnamehint = "أدخل اسمك الأول";
  static const String flnamehint = "أدخل اسمك الأخير";
  static const String address = "أدخل عنوانك";
  static const String phonehint = "أدخل رقم هاتفك";

  static const String firstnamerequired = "الاسم الأول مطلوب";
  static const String lastnamerequired = "الاسم الأخير مطلوب";
  static const String emailrequired = "البريد الإلكتروني مطلوب";
  static const String passwordrequired = "كلمة المرور مطلوبة";
  static const String phonerequired = "رقم الهاتف مطلوب";
  static const String imagerequired = "الصورة مطلوبة";

  static const String invalidEmail = "بريد إلكتروني غير صالح";
  static const String invalidPhone = "رقم هاتف غير صالح";
  static const String invalidPassword =
      "كلمة المرور يجب أن تكون 6 أحرف على الأقل وتحتوي على أرقام وحروف ورموز";
  static const String emailAlreadyExists =
      "البريد الإلكتروني موجود بالفعل أو يوجد خطأ في قاعدة البيانات";

  static const String passwordRulestitle =
      "يرجى إضافة جميع الشروط لإنشاء كلمة مرور آمنة.";

  static List<Map<String, dynamic>> passwordRules = [
    {"title": "12 حرف على الأقل", "status": false},
    {"title": "حرف كبير واحد", "status": false},
    {"title": "حرف صغير واحد", "status": false},
    {"title": "رمز خاص واحد", "status": false},
    {"title": "رقم واحد", "status": false},
  ];

  static const String photoGallery = "معرض الصور";
  static const String camera = "الكاميرا";
  static const String cancel = "إلغاء";
  static String submit = "إرسال";

  static String nationalnumber = "الرقم القومي";
  static String hintnationalnumber = "أدخل الرقم القومي";

  static String msgforResetpassword =
      "لقد أرسلنا لك كود لإعادة تعيين كلمة المرور. يرجى التحقق من بريدك الإلكتروني.";

  static String msgforregister =
      "لقد أرسلنا كود مكون من 6 أرقام إلى بريدك الإلكتروني / رقم الهاتف";

  static String msgresetingpass =
      "تم التحقق من الكود بنجاح. يرجى تعيين كلمة مرور جديدة.";

  static String apptitle = "CitiFix";
  static String kActive = "نشط";
  static String kPending = "قيد المعالجة";
  static String kCompleted = "تم الحل";
  static String finish = "ابدأ الآن";
  static String next = "التالي";

  static String sendReport = "إرسال البلاغ";
  static String location = "الموقع";
  static String selectcategory = "اختر الفئة";

  static String hintReportDescription = "اكتب تفاصيل البلاغ";

  static String labeldescription = "وصف البلاغ";
  static String descriptionTitle = "وصف البلاغ";

  static String ReportTitle = "حفرة في الشارع";
  static String ReportTitle1 = "عنوان البلاغ";

  static String addreport = "إضافة بلاغ";

  static String language = "اللغة";
  static String settings = "الإعدادات";
  static String profile = "الملف الشخصي";

  static String search = "بحث";
  static String logout = "تسجيل الخروج";

  static String reports = 'البلاغات';
  static String reportDetails = "تفاصيل البلاغ";

  static List<TimelineStep> mySteps = [
    TimelineStep(index: 0, title: "تم استلام البلاغ", isDone: true),
    TimelineStep(index: 1, title: "جاري معالجة البلاغ", isDone: false),
    TimelineStep(index: 2, title: "تم حل البلاغ", isDone: false),
    TimelineStep(index: 3, title: "تم رفض البلاغ", isDone: false),
  ];

  static const selectLanguage = "اختار اللغة";
  static const choosePreferredLanguage = "اختر اللغة المفضلة";
  static const english = "الإنجليزية";
  static const arabic = "العربية";

  static String editProfile = 'تعديل الملف الشخصي';

  static String stayfocus = 'Stay focused and keep delivering';
}
