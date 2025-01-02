import 'package:app/features/articles/presentation/view/add_article_view.dart';
import 'package:app/features/articles/presentation/view/article_list_view.dart';
import 'package:app/features/forgot_password/presentation/view/mentee_forgot_password.dart';
import 'package:app/features/forgot_password/presentation/view/mentor_forgot_password.dart';
import 'package:app/features/mentee/presentation/view/mentee_login.dart';
import 'package:app/features/mentee/presentation/view/mentee_signup.dart';
import 'package:app/features/mentee_dashboard/presentation/view/mentee_dashboard.dart';
import 'package:app/features/mentee_dashboard/presentation/view/mentee_session_list.dart';
import 'package:app/features/mentor/presentation/view/mentor_form.dart';
import 'package:app/features/mentor/presentation/view/mentor_login.dart';
import 'package:app/features/mentor/presentation/view/mentor_signup.dart';
import 'package:app/features/mentor_dashboard/presentation/view/create_session.dart';
import 'package:app/features/mentor_dashboard/presentation/view/mentor_dashboard.dart';
import 'package:app/features/starting/presentation/view/choose_role.dart';
import 'package:app/features/starting/presentation/view/get_started.dart';
import 'package:app/features/starting/presentation/view/splash_screen_view.dart';

class AppRoutes {
  AppRoutes._();

  static const String landing = './landing';
  static const String menteeSignup = './menteeSignup';
  static const String mentorSignup = './mentorSignup';
  static const String mentorForm = './mentorForm';
  static const String menteeLoginPage = './menteeLoginPage';
  static const String mentorLoginPage = './mentorLoginPage';
  static const String chooseRole = './chooseRole';
  static const String splashScreen = './splashScreen';
  static const menteeDashboard = './menteeDahboard';
  static const mentorDashboard = './mentorDashboard';

  static const String splasj = './splash';

  static const String createSession = './createSession';
  static const String menteeSessionList = './menteeSessionList';
  static const String popup = './popup';
  static const String menteeForgotPassword = './menteeForgotPassword';
  static const String mentorForgotPassword = './mentorForgotPassword';
  static const String menteeMentorProfile = './menteeMentorProfile';

  static const String articleList = './articles';
  static const String addArticle = "./addArticle";
  static const String start = './start';

  static getApplicationRoute() {
    return {
      landing: (context) => const GetStarted(),
      menteeSignup: (context) => const MenteeSignUp(),
      mentorSignup: (context) => const MentroSignUp(),
      mentorForm: (context) => const MentorForm(),
      menteeLoginPage: (context) => const MenteeLogin(),
      mentorLoginPage: (context) => const MentorLogin(),
      chooseRole: (context) => const ChooseRole(),
      splashScreen: (context) => const SplashScreen(),
      menteeDashboard: (context) => const MenteeDashboard(),
      mentorDashboard: (context) => const MentorDashboard(),
      createSession: (context) => const CreateSession(),
      menteeSessionList: (context) => const MenteeSessionList(),
      menteeForgotPassword: (context) => const MenteeForgotPassword(),
      mentorForgotPassword: (context) => const MentorForgotPassword(),
      addArticle :(context) => const AddArticleView(),
      articleList: (context) => const ArticleList()
    };
  }
}
