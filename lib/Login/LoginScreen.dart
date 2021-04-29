import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hrw_textscanner/firebase/Authentification.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            RaisedButton(
              onPressed: () {
                context.read<Authentification>().signIn(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim(),
                    );
              },
              child: Text("Sign in"),
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:hrw_textscanner/Styles/RadientGradientMask.dart';
// import 'package:hrw_textscanner/firebase/Authentification.dart';
// import 'package:provider/provider.dart';
//
// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController passwordController2 = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScopeNode currentFocus = FocusScope.of(context);
//         if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
//           FocusManager.instance.primaryFocus.unfocus();
//         }
//       },
//       child: Container(
//         color: Colors.blue,
//         child: Padding(
//           padding: const EdgeInsets.all(50),
//           child: Center(
//             child: Container(
//               child: SingleChildScrollView(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.scanner,
//                       color: Colors.white,
//                       size: 100,
//                     ),
//                     Text(
//                       "HRW-Textscanner",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(fontSize: 40, color: Colors.white),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Material(
//                       color: Colors.white.withOpacity(0.5),
//                       elevation: 2,
//                       borderRadius: BorderRadius.circular(5),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: Colors.white.withOpacity(0.05),
//                         ),
//                         child: TextField(
//                           keyboardType: TextInputType.emailAddress,
//                           style: TextStyle(color: Colors.black),
//                           controller: emailController,
//                           decoration: new InputDecoration(
//                             border: new OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(5),
//                               borderSide: BorderSide(),
//                             ),
//                             labelText: 'Email-Adresse',
//                             labelStyle: TextStyle(fontSize: 15, color: Colors.black),
//                             prefixIcon: RadiantGradientMask(
//                               child: const Icon(
//                                 Icons.person,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Material(
//                       color: Colors.white.withOpacity(0.5),
//                       elevation: 2,
//                       borderRadius: BorderRadius.circular(5),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(5),
//                           color: Colors.white.withOpacity(0.05),
//                         ),
//                         child: TextField(
//                           keyboardType: TextInputType.visiblePassword,
//                           style: TextStyle(color: Colors.black),
//                           obscureText: true,
//                           controller: passwordController2,
//                           decoration: new InputDecoration(
//                             border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.teal)),
//                             labelText: 'Passwort',
//                             labelStyle: TextStyle(fontSize: 15, color: Colors.black),
//                             prefixIcon: RadiantGradientMask(
//                               child: const Icon(
//                                 Icons.vpn_key,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Material(
//                       elevation: 3,
//                       borderRadius: BorderRadius.circular(5),
//                       child: GestureDetector(
//                         onTap: () {
//                           context.read<Authentification>().signIn(
//                                 email: emailController.text.trim(),
//                                 password: passwordController2.text.trim(),
//                               );
//                         },
//                         child: Container(
//                           height: 55,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             gradient: LinearGradient(
//                               begin: Alignment.bottomLeft,
//                               end: Alignment.topRight,
//                               //stops: [0.2, 1],
//                               colors: [
//                                 Color(0xff06B88B),
//                                 Color(0xff00C2B0),
//                                 Color(0xff009CA8),
//                                 Color(0xff0098C2),
//                                 //Color(0xff064AB8),
//                                 Color(0xff0676B8),
//                                 Color(0xff06B88B),
//                               ],
//                             ),
//                           ),
//                           child: Center(
//                             child: Text(
//                               "Login",
//                               style: TextStyle(fontSize: 25, color: Colors.white),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(
//                           "Passwort vergessen?",
//                           textAlign: TextAlign.end,
//                           style: TextStyle(color: Colors.white, fontSize: 14),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 40,
//                     ),
//                     Text(
//                       "oder einloggen mit",
//                       style: TextStyle(fontSize: 14, color: Colors.white),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Material(
//                           elevation: 3,
//                           borderRadius: BorderRadius.circular(5),
//                           child: GestureDetector(
//                             // onTap: () {
//                             //   context.read<Authentification>().signInWithFacebook();
//                             // },
//                             child: Container(
//                               width: 45,
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: Color(0xFF3B5998),
//                               ),
//                               //padding: const EdgeInsets.all(10.0),
//                               child: Center(
//                                 child: FaIcon(
//                                   FontAwesomeIcons.facebookF,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 25,
//                         ),
//                         Material(
//                           elevation: 3,
//                           borderRadius: BorderRadius.circular(5),
//                           child: GestureDetector(
//                             // onTap: () {
//                             //   context.read<Authentification>().signInWithGoogle();
//                             // },
//                             child: Container(
//                               width: 45,
//                               height: 45,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(5),
//                                 color: Colors.red,
//                               ),
//                               child: Center(
//                                 child: FaIcon(
//                                   FontAwesomeIcons.google,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         RichText(
//                           text: TextSpan(
//                             style: DefaultTextStyle.of(context).style,
//                             children: <TextSpan>[
//                               TextSpan(
//                                 text: 'Neu Hier? ',
//                                 style: TextStyle(fontSize: 14, color: Colors.white),
//                               ),
//                             ],
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               //loginExists = false;
//                             });
//                           },
//                           child: Text(
//                             'Registrieren',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
