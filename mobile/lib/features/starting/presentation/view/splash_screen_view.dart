import 'package:app/core/provider/internet_connectivity.dart';
import 'package:app/core/shared_pref/user_shared_prefs.dart';
import 'package:app/features/mentee_dashboard/presentation/view/mentee_dashboard.dart';
import 'package:app/features/mentor/presentation/viewmodel/mentor_view_model.dart';
import 'package:app/features/mentor_dashboard/presentation/view/mentor_dashboard.dart';
import 'package:app/features/starting/presentation/view/get_started.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkBiometric();
    _getAvailableBiometric();
    navigateToNextScreen();
  }

  final auth = LocalAuthentication();
  String authorized = " not authorized";
  bool _canCheckBiometric = false;
  late List<BiometricType> _availableBiometric;

  Future<void> _authenticate(Widget nextScreen) async {
    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
        localizedReason: "Scan your finger to authenticate",
      );
    } on PlatformException catch (e) {
      ref.read(userSharedPrefsProvider).deleteUserDetails();
      ref.read(userSharedPrefsProvider).deleteUserToken();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const GetStarted()));
    }
    if (authenticated) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => nextScreen));
    } else {
      ref.read(userSharedPrefsProvider).deleteUserDetails();
      ref.read(userSharedPrefsProvider).deleteUserToken();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const GetStarted()));
    }
  }

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;

    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future _getAvailableBiometric() async {
    List<BiometricType> availableBiometric = [];

    try {
      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }

    setState(() {
      _availableBiometric = availableBiometric;
    });
  }

  Future<void> navigateToNextScreen() async {
    // Fetch the token
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    // Parse the token if it exists
    final Map<String, dynamic>? decodedToken =
        token != null ? JwtDecoder.decode(token) : null;

    // Ensure a minimum duration by waiting for both the splash screen duration and token retrieval process
    await Future.wait([
      Future.delayed(const Duration(
          seconds:
              5)), // Adjust as needed, this can be your splash screen duration
      Future.microtask(() => decodedToken), // Fetch the token concurrently
    ]);

    // Determine the next screen based on the token
    Widget nextScreen =
        const GetStarted(); // Default to GetStarted screen if token or decoding fails
    if (decodedToken != null && decodedToken['isMentor'] == true) {
      ref.read(mentorViewModelProvider.notifier).setUser(decodedToken);
      nextScreen = const MentorDashboard();
      _authenticate(nextScreen);
      return;
    } else if (decodedToken != null && decodedToken['isMentor'] == false) {
      nextScreen = const MenteeDashboard();
      _authenticate(nextScreen);
      return;
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const GetStarted()));
    }

    // Navigate to the next screen
  }

  @override
  Widget build(BuildContext context) {
    final connectivityStatus = ref.watch(connectivityStatusProvider);

    // Show SnackBar based on connectivity status
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (connectivityStatus == ConnectivityStatus.isConnected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(
              child: Text(
                'Internet Connected',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white, // Set text color to white
                  // Apply bold font weight
                ),
              ),
            ),
            padding: EdgeInsets.all(2),
            backgroundColor: Colors.green, // Set SnackBar background color
            duration: Duration(seconds: 3), // Adjust duration as needed
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Center(
              child: Text(
                'Internet Disconnected',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white, // Set text color to white
                  // Apply bold font weight
                ),
              ),
            ),
            padding: EdgeInsets.all(2),
            backgroundColor: Colors.red, // Set SnackBar background color
            duration: Duration(seconds: 3), // Adjust duration as needed
          ),
        );
      }
    });

    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mentorship",
                        style: TextStyle(
                          color: Color(0xff87429E),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Personalized learning \n with experts",
                        style: TextStyle(
                          color: Color(0xffEEA025),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
