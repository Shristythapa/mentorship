import 'package:app/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChooseRole extends StatefulWidget {
  const ChooseRole({super.key});

  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {
  bool showError = false;
  String selectedRole = '';

  void _handleRoleSelection(String role) {
    setState(() {
      selectedRole = role;
      showError = false; // Reset error state when a role is selected
    });
  }

  @override
  Widget build(BuildContext context) {
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
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
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
                              // bottomLeft: Radius.circular(70.0),
                              // bottomRight: Radius.circular(70.0),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        "Choose role",
                                        style: TextStyle(
                                            color: Color(0xff474747),
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    RoleCard(
                                      isError: showError,
                                      label: "Mentor",
                                      onPressed: () {
                                        _handleRoleSelection("Mentor");
                                      },
                                      isSelected: selectedRole == "Mentor",
                                    ),
                                    showError
                                        ? const Text(
                                            "Please select a role.",
                                            style: TextStyle(color: Colors.red),
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    RoleCard(
                                      isError: showError,
                                      label: "Mentee",
                                      onPressed: () {
                                        _handleRoleSelection("Mentee");
                                      },
                                      isSelected: selectedRole == "Mentee",
                                    ),
                                    showError
                                        ? const Text(
                                            "Please select a role.",
                                            style: TextStyle(color: Colors.red),
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    SizedBox(
                                      height: 60,
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            if (selectedRole == "Mentee") {
                                              Navigator.pushNamed(context,
                                                  AppRoutes.menteeSignup);
                                            } else if (selectedRole == '') {
                                              setState(() {
                                                showError = true;
                                              });
                                            } else {
                                              Navigator.pushNamed(context,
                                                  AppRoutes.mentorSignup);
                                            }
                                          },
                                          child: const Text(
                                            "Choose Role",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: 'roboto',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )),
                                    )
                                  ]),
                            ),
                          )),
                    ),
                  )
                ])),
      ),
    );
  }
}

class RoleCard extends StatefulWidget {
  final String label;
  final Function() onPressed;
  final bool isSelected;
  final bool isError;

  const RoleCard({
    required this.isError,
    super.key,
    required this.label,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  _RoleCardState createState() => _RoleCardState();
}

class _RoleCardState extends State<RoleCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Card(
        color: Colors.white,
        elevation: widget.isSelected ? 12 : 2,
        shadowColor: widget.isSelected
            ? const Color(0xFFa48394)
            : const Color(0xFFa48394),
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width * 0.8,
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(
              color: widget.isSelected
                  ? const Color(0xFFE7CEFF)
                  : widget.isError
                      ? Colors.red
                      : const Color(0xFFEFEFEF),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 30),
                  child: widget.label == "Mentee"
                      ? const Icon(
                          FontAwesomeIcons.chalkboardTeacher,
                          size: 35,
                          color: Color.fromARGB(255, 107, 75, 136),
                        )
                      : const Icon(
                          FontAwesomeIcons.child,
                          size: 35,
                          color: Color.fromARGB(255, 107, 75, 136),
                        )),
              SizedBox(
                width: 150,
                child: ListTile(
                  title: Text(
                    widget.label,
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 146, 114, 174)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
