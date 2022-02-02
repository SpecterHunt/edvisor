import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              const Image(
                image: AssetImage('assets/images/Background_Slice.png'),
                fit: BoxFit.cover,
              ),
              Positioned(
                  top: height * 0.04,
                  left: width * 0.05,
                  child: Image(
                    height: height * 0.04,
                    image: const AssetImage('assets/images/Logo2-4.png'),
                  )),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.1,
                      ),
                      const Text(
                        'Hi There!',
                        style: TextStyle(
                            //color: Colors.black,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 25),
                      ),
                      const Text(
                        'Please login to continue',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 19),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 2.0),
                        child: Text(
                          'Email',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.004,
                      ),
                      Container(
                        height: height * 0.065,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(colors: [
                              Color(0xff0E46EB),
                              Color(0xff5776CF)
                            ])),
                        child: TextFormField(
                          controller: usernameController,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 17),
                          cursorColor: Colors.white,
                          decoration: const InputDecoration(
                              focusColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              filled: true,
                              fillColor: Colors.transparent),
                        ),
                      ),
                      SizedBox(height: height * 0.05),
                      const Padding(
                        padding: EdgeInsets.only(left: 2.0),
                        child: Text(
                          'Password',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.004,
                      ),
                      Container(
                        height: height * 0.065,
                        decoration: const BoxDecoration(
                          color: Color(0xffECECEC),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          style: const TextStyle(
                              color: Colors.blueGrey, fontSize: 17),
                          cursorColor: Colors.blueGrey,
                          decoration: const InputDecoration(
                              focusColor: Colors.white,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              filled: true,
                              fillColor: Colors.transparent),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.06,
                      ),
                      Center(
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff0E46EB))),
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('isLoggedIn', true);
                              Get.offNamed('/newHome');
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 35.0, right: 35.0),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                    fontSize: 17),
                              ),
                            )),
                      ),
                      SizedBox(
                        height: height * 0.1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'are you a new user?',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400),
                          ),
                          Text(' Create Account',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ))
                        ],
                      )
                    ],
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
