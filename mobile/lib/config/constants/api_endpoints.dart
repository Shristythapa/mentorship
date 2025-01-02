class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 8000);
  static const Duration receiveTimeout = Duration(seconds: 8000);
//   "http://192.168.56.1:5000/api/session/getAllSessions"
  // static const String baseUrl = "http://10.0.2.2:5000/api/";
  static const String baseUrl = "http://192.168.137.1:5000/api/";

// auth routes
  static const String menteeRegister = "mentee/signup";
  static const String menteeLogin = "mentee/login";
  static const String mentorRegister = "mentor/signup";
  static const String mentorLogin = "mentor/login";

  // session routes
  static const String getAllSessions = "session/getAllSessions";
  static const String createSession = "session/create";
  static const String getSessionById = "session/getSessionById/";
  static const String deleteSession = "session/deleteSession/";
  static const String joinSession = "session/joinSession/";
  static const String getSessionByMentorId = "session/mentorSessions/";

  // mentor routes
  static const String getMentorById = "mentor/getMentorById/";
  static const String getAllMentors = "mentor/getAllMentors";

  //forgot password
  static const String forgotPasswordMentee = "mentee/forgotPassword";

  //article routes
  static const String addArticle = "article/createArticle";
  static const String getArticle = "article/findAllArticles";
  static const String deleteArticle = "article/deleteArticle/";
}
