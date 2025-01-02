import 'package:app/config/routes/app_routes.dart';
import 'package:flutter/material.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mentorship",
                      style: TextStyle(
                          color: Color(0xff87429E),
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Personilized learning \n with experts",
                      style: TextStyle(
                          color: Color(0xffEEA025),
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              Image(
                width: MediaQuery.of(context)
                    .size
                    .width, // Adjust this value as needed
                image: const AssetImage("assets/images/learning.png"),
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.chooseRole);
                    },
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'roboto',
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
