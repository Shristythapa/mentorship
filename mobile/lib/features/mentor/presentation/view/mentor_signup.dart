import 'dart:io';
import 'package:app/config/routes/app_routes.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:app/features/mentor/presentation/view/mentor_form.dart';
import 'package:app/features/mentor/presentation/viewmodel/mentor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MentroSignUp extends ConsumerStatefulWidget {
  const MentroSignUp({super.key});

  @override
  ConsumerState<MentroSignUp> createState() => _MentroSignUpState();
}

class _MentroSignUpState extends ConsumerState<MentroSignUp> {
  bool buttonPressed = false;
  String name = '';
  String password = '';
  String email = '';
  bool showPassword = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode myFocusNode = FocusNode();
  File? image;
  String? imagePath;
  String? imageUrl;
  final form = GlobalKey<FormState>();
  // Check for the camera permission
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        _img = File(image.path);

        //  ref.read(authViewModelProvider.notifier).uploadImage(_img!);
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final mentorState = ref.watch(mentorViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mentorState.error != null && mentorState.showMessage!) {
        SnackBarManager.showSnackBar(
            isError: true, message: mentorState.error!, context: context);
        ref.read(mentorViewModelProvider.notifier).reset();
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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Stack(
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
                                topLeft: Radius.circular(50.0),
                                topRight: Radius.circular(50.0),
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
                                        "Sign up as Mentor",
                                        style: TextStyle(
                                            color: Color(0xff87429E),
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          backgroundColor: const Color(0xFF6D3F83),
                                          context: context,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                          ),
                                          builder: (context) => Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    checkCameraPermission();
                                                    _browseImage(
                                                        ImageSource.camera);
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons.camera),
                                                  label: const Text('Camera'),
                                                ),
                                                ElevatedButton.icon(
                                                  onPressed: () {
                                                    _browseImage(
                                                        ImageSource.gallery);
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(Icons.image),
                                                  label: const Text('Gallery'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        height: 200,
                                        width: 200,
                                        child: CircleAvatar(
                                          radius: 50,
                                          // backgroundImage:
                                          //     AssetImage('assets/images/profile.png'),
                                          backgroundImage: _img != null
                                              ? FileImage(_img!)
                                              : const AssetImage(
                                                      'assets/images/dummyProfileImage.jfif')
                                                  as ImageProvider,
                                        ),
                                      ),
                                    ),
                                    TextFormField(
                                      style: const TextStyle(color: Colors.black),
                                      keyboardType: TextInputType.text,
                                      controller: usernameController,
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return "username is required";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        errorStyle:
                                            TextStyle(color: Colors.red[900]),
                                        prefixIcon: const Icon(Icons.account_circle,
                                            color: Color(0xFF6D3F83)),
                                        labelText: "username",
                                        labelStyle: TextStyle(
                                            fontFamily: 'roboto',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: myFocusNode.hasFocus
                                                ? const Color.fromARGB(
                                                    255, 136, 117, 163)
                                                : const Color.fromARGB(
                                                    255, 139, 117, 169)),
                                        border: const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black)),
                                        focusedBorder: const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black)),
                                      ),
                                      onChanged: (value) => setState(() {
                                        name = value;
                                      }),
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20),
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
                                        errorStyle:
                                            TextStyle(color: Colors.red[900]),
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
                                        border: const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black)),
                                        focusedBorder: const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black)),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                      onChanged: (value) => setState(() {
                                        email = value;
                                      }),
                                    ),
                                    const SizedBox(height: 10),
                                    TextFormField(
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 20),
                                      controller: passwordController,
                                      validator: (String? value) {
                                        if (value == null || value.isEmpty) {
                                          return "password is required";
                                        } else if (value.length < 4) {
                                          return 'password must be higher than four character';
                                        } else {
                                          return null;
                                        }
                                      },
                                      obscureText: !showPassword,
                                      obscuringCharacter: '*',
                                      decoration: InputDecoration(
                                        errorStyle:
                                            TextStyle(color: Colors.red[900]),
                                        labelText: "password",
                                        labelStyle: TextStyle(
                                            fontFamily: 'roboto',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: myFocusNode.hasFocus
                                                ? const Color.fromARGB(
                                                    255, 136, 117, 163)
                                                : const Color.fromARGB(
                                                    255, 139, 117, 169)),
                                        prefixIcon: const Icon(Icons.lock,
                                            color: Color(0xFF6D3F83)),
                                        suffixIcon: showPassword
                                            ? InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    showPassword = !showPassword;
                                                  });
                                                },
                                                child: const Icon(Icons.visibility,
                                                    color: Color(0xFF6D3F83)))
                                            : InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    showPassword = !showPassword;
                                                  });
                                                },
                                                child: const Icon(
                                                    Icons.visibility_off,
                                                    color: Color(0xFF6D3F83)),
                                              ),
                                        border: const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black)),
                                        focusedBorder: const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black)),
                                        focusColor: const Color.fromARGB(
                                            255, 141, 125, 164),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      height: 50,
                                      child: ElevatedButton(
                                        onHover: (value) {
                                          setState(() {
                                            !buttonPressed;
                                            ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFF3c1c3c),
                                                foregroundColor:
                                                    const Color.fromARGB(
                                                        255, 146, 114, 174));
                                          });
                                        },
                                        onPressed: (() {
                                          buttonPressed = !buttonPressed;
                      
                                          if (form.currentState!.validate()) {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MentorForm(
                                                        img: _img,
                                                        username:
                                                            usernameController.text,
                                                        email: emailController.text,
                                                        password:
                                                            passwordController.text,
                                                      )),
                                            );
                                          }
                                        }),
                                        child: const Text(
                                          "Sign up",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'roboto',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 20),
                                      child: Center(
                                          child: InkWell(
                                        child: const Text(
                                          "Already have an account?",
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 141, 125, 164),
                                            fontFamily: 'roboto',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.popAndPushNamed(
                                              context, AppRoutes.mentorLoginPage);
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
                         if (mentorState.isLoading)
                        const Center(
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

Widget bottomSheet(BuildContext context) {
  Size size = MediaQuery.of(context).size;

  return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      width: double.infinity,
      height: size.height * 0.2,
      child: Column(
        children: [
          const Text("Choose Profile Photo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                child: const Column(
                  children: [
                    Icon(Icons.image),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Gallary",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                onTap: () {},
              ),
              const SizedBox(
                width: 80,
              ),
              InkWell(
                onTap: (() {}),
                child: const Column(
                  children: [
                    Icon(Icons.camera),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Camera",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ));
}
