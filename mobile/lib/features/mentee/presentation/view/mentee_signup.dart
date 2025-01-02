import 'dart:io';
import 'package:app/config/routes/app_routes.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:app/features/mentee/domain/entity/mentee_entity.dart';
import 'package:app/features/mentee/presentation/viewmodel/mentee_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MenteeSignUp extends ConsumerStatefulWidget {
  const MenteeSignUp({super.key});

  @override
  ConsumerState<MenteeSignUp> createState() => _MenteeSignUpState();
}

class _MenteeSignUpState extends ConsumerState<MenteeSignUp> {
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
      if (image == null) {
        // Set a default image path here
        const defaultImagePath = 'assets/images/default_image.jpg';
        _img = File(defaultImagePath);
      } else {
        _img = File(image.path);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
 

    final menteeState = ref.watch(menteeViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (menteeState.error != null && menteeState.showMessage!) {
        SnackBarManager.showSnackBar(
            isError: true,
            message: ref.read(menteeViewModelProvider).error!,
            context: context);
        ref.read(menteeViewModelProvider.notifier).resetMessage();
      }
    });

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover),
        ),
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
                          // bottomLeft: Radius.circular(70.0),
                          // bottomRight: Radius.circular(70.0),
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
                                  "Sign up as mentee",
                                  style: TextStyle(
                                      color: Color(0xff474747),
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700),
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
                                    prefixIcon: const Icon(
                                        Icons.account_circle,
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
                                    border: const UnderlineInputBorder(),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black))),
                                onChanged: (value) => setState(() {
                                  name = value;
                                }),
                              ),
                              const SizedBox(height: 10),
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
                              const SizedBox(height: 10),
                              TextFormField(
                                style: const TextStyle(fontSize: 20),
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
                                  border: const UnderlineInputBorder(),
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
                                              const Color(0xFF6D3F83),
                                          foregroundColor:
                                              const Color.fromARGB(
                                                  255, 146, 114, 174));
                                    });
                                  },
                                  onPressed: (() {
                                    buttonPressed = !buttonPressed;
                                    // if (true) {
                                    if (form.currentState!.validate()) {
                                      MenteeEntity menteeEntity =
                                          MenteeEntity(
                                              userName:
                                                  usernameController.text,
                                              email: emailController.text,
                                              password:
                                                  passwordController.text);
            
                                      ref
                                          .read(menteeViewModelProvider
                                              .notifier)
                                          .registerMentee(
                                              context, _img!, menteeEntity);
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
                                    Navigator.pushNamed(
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
                if (menteeState.isLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  ),
              ],
            )),
      ),
    );
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  onTap: () {
                    _browseImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(
                  width: 80,
                ),
                InkWell(
                  onTap: (() {
                    checkCameraPermission();
                    _browseImage(ImageSource.camera);
                    Navigator.pop(context);
                  }),
                  child: const Column(
                    children: [
                      Icon(Icons.camera),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Camera",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
