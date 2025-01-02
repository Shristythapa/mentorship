import 'dart:io';
import 'package:app/core/utils/custom_choose.dart';
import 'package:app/core/utils/snackbar.dart';
import 'package:app/features/mentor/domain/entity/mentor_entity.dart';
import 'package:app/features/mentor/presentation/viewmodel/mentor_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class MentorForm extends ConsumerStatefulWidget {
  final File? img;
  final String? username;
  final String? email;
  final String? password;

  const MentorForm({
    Key? key,
    this.img,
    this.username,
    this.email,
    this.password,
  }) : super(key: key);

  @override
  ConsumerState<MentorForm> createState() => _MentorFormState();
}

class _MentorFormState extends ConsumerState<MentorForm> {
  bool buttonPressed = false;
  String firstName = '';
  String lastName = '';
  bool showPassword = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController datePickerController = TextEditingController();
  onTapFunction({required BuildContext context}) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime(1950),
      initialDate: DateTime.now(),
    );
    if (pickedDate == null) return;
    datePickerController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<String> selectedSkills = [];

  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
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
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Mentor information",
                  style: TextStyle(
                      color: Color(0xFF6D3F83),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(15),
                  color: Colors.white,
                  child: Stack(
                    children: [
                      Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "  First Name",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: myFocusNode.hasFocus
                                              ? const Color.fromARGB(
                                                  255, 136, 117, 163)
                                              : const Color.fromARGB(
                                                  255, 139, 117, 169),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                          keyboardType: TextInputType.text,
                                          controller: firstNameController,
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "First name is required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 15,
                                                    horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          onChanged: (value) => setState(() {
                                            firstName = value;
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "  Last Name",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: myFocusNode.hasFocus
                                              ? const Color.fromARGB(
                                                  255, 136, 117, 163)
                                              : const Color.fromARGB(
                                                  255, 139, 117, 169),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                          keyboardType: TextInputType.text,
                                          controller: secondNameController,
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "Second name is required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 15,
                                                    horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          onChanged: (value) => setState(() {
                                            firstName = value;
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "  Date of Birth ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: myFocusNode.hasFocus
                                              ? const Color.fromARGB(
                                                  255, 136, 117, 163)
                                              : const Color.fromARGB(
                                                  255, 139, 117, 169),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                          keyboardType: TextInputType.datetime,
                                          controller: datePickerController,
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return " Date of birth is required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 15,
                                                    horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          onTap: () =>
                                              onTapFunction(context: context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "  Location ",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          color: myFocusNode.hasFocus
                                              ? const Color.fromARGB(
                                                  255, 136, 117, 163)
                                              : const Color.fromARGB(
                                                  255, 139, 117, 169),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: TextFormField(
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                          keyboardType: TextInputType.text,
                                          controller: locationController,
                                          validator: (String? value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return " Location  is required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 15,
                                                    horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black),
                                            ),
                                          ),
                                          onChanged: (value) => setState(() {
                                            firstName = value;
                                          }),
                                        ),
                                      ),
                                      LableFeild(
                                        lable: "Skills",
                                        selectedItems: selectedSkills,
                                        onSelectionChanged: (selectedItems) {
                                          setState(() {
                                            selectedSkills = selectedItems;
                                          });
                                        },
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Center(
                                          child: SizedBox(
                                            width: 150,
                                            height: 50,
                                            child: ElevatedButton(
                                              onHover: (value) {
                                                setState(() {
                                                  !buttonPressed;
                                                  ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xFF6D3F83),
                                                      foregroundColor:
                                                          const Color.fromARGB(
                                                              255,
                                                              146,
                                                              114,
                                                              174));
                                                });
                                              },
                                              onPressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  MentorEntity mentorEntity = MentorEntity(
                                                      userName:
                                                          widget.username!,
                                                      email: widget.email!,
                                                      password:
                                                          widget.password!,
                                                      firstName:
                                                          firstNameController
                                                              .text,
                                                      lastName:
                                                          secondNameController
                                                              .text,
                                                      dateOfBirth:
                                                          datePickerController
                                                              .text,
                                                      address:
                                                          locationController
                                                              .text,
                                                      skills: selectedSkills);
                                                  ref
                                                      .read(
                                                          mentorViewModelProvider
                                                              .notifier)
                                                      .registerMentor(
                                                          context,
                                                          widget.img!,
                                                          mentorEntity);
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 146, 114, 174),
                                                foregroundColor:
                                                    const Color.fromARGB(
                                                        255, 230, 211, 239),
                                              ),
                                              child: const Text(
                                                "Done",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: 'roboto',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
              ),
            ]),
      ),
    );
  }
}
