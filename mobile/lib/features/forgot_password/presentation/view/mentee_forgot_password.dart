import 'package:app/config/routes/app_routes.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:app/features/forgot_password/presentation/viewmodel/forgot_password_view_model.dart';
import 'package:app/features/mentee/presentation/viewmodel/mentee_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenteeForgotPassword extends ConsumerStatefulWidget {
  const MenteeForgotPassword({super.key});

  @override
  ConsumerState<MenteeForgotPassword> createState() =>
      _MenteeForgotPasswordState();
}

class _MenteeForgotPasswordState extends ConsumerState<MenteeForgotPassword> {
  bool buttonPressed = false;
  String email = '';
  TextEditingController emailController =
      TextEditingController(text: "dontrinrin@gmail.com");
  FocusNode myFocusNode = FocusNode();

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final forgotPasswordState = ref.watch(forgotPasswordViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (forgotPasswordState.showMessage!) {
        Color? snackBarColor;
        if (forgotPasswordState.isError!) {
          snackBarColor = Colors.green;
        }
        String message = forgotPasswordState.message!;

        SnackBarManager.showSnackBar(message: message, context: context, isError: forgotPasswordState.isError!);

        ref.read(menteeViewModelProvider.notifier).resetMessage();
      }
    });

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            // color: Color(0xFFC48EEA),
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover)),
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              foregroundColor: const Color(0xFF6D3F83),
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Color(0xFF6D3F83),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                Form(
                  key: form,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7,
                      padding: const EdgeInsets.all(40),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70.0),
                          topRight: Radius.circular(70.0),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Forgot Password",
                                  style: TextStyle(
                                      color: Color(0xff474747),
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              //
                              TextFormField(
                                style: const TextStyle(fontSize: 20),
                                controller: emailController,
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email is invalid";
                                  } else if (!value.contains('@gmail.com')) {
                                    return 'Email is invalid';
                                  } else {
                                    return null;
                                  }
                                },
                                focusNode: myFocusNode,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(color: Colors.red[900]),
                                  prefixIcon: const Icon(Icons.mail,
                                      color: Color(0xFF6D3F83)),
                                  labelText: "email",
                                  labelStyle: TextStyle(
                                      fontFamily: 'roboto',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: myFocusNode.hasFocus
                                          ? const Color.fromARGB(
                                              255, 136, 117, 163)
                                          : const Color.fromARGB(
                                              255, 139, 117, 169)),
                                  border: const UnderlineInputBorder(),
                                  focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) => setState(() {
                                  email = value;
                                }),
                              ),

                              const SizedBox(
                                height: 80,
                              ),
                              SizedBox(
                                width: 150,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: (() {
                                    buttonPressed = !buttonPressed;
                                    if (form.currentState!.validate()) {
                                      ref
                                          .read(forgotPasswordViewModelProvider
                                              .notifier)
                                          .menteeForgotPassword(
                                              emailController.text, context);
                                    }
                                  }),
                                  child: const Text(
                                    "Send Mail",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Center(
                                    child: InkWell(
                                  child: const Text(
                                    "Go to login?",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 141, 125, 164),
                                      fontFamily: 'roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.popAndPushNamed(
                                        context, AppRoutes.menteeLoginPage);
                                  },
                                )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (forgotPasswordState.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            )),
      ),
    );
  }
}
