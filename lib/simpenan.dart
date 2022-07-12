// child: IconButton(
//                     onPressed: () {},
//                     icon: Image.asset('assets/images/maleButton.png'),
//                     iconSize: _maleGender? 96 : 60,
//                   ),



                    // inputFormatters: [
                    //   FilteringTextInputFormatter.digitsOnly,
                    // ],





// BODY beranda

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tugasakhir_app/styles.dart';

// class HomeBody extends StatelessWidget {
//   const HomeBody({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//           children: [
//             SingleChildScrollView(
//               child: Column(
                
//                 children: [
//                   SizedBox(
//                     // tag: "login_btn",
//                     width: MediaQuery.of(context).size.width * 0.78,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         primary: Styles.buttonAuthBg,
//                         minimumSize: const Size.fromHeight(50),
//                         shape: new RoundedRectangleBorder(
//                           borderRadius: new BorderRadius.circular(5.0),
//                         ),
//                       ),
//                       onPressed: () async {
//                         final SharedPreferences localStorage =
//                             await SharedPreferences.getInstance();
//                         localStorage.remove('email');
//                         Navigator.popAndPushNamed(context, '/sign_in_page');
//                       },
//                       child: Text(
//                         "logout".toUpperCase(),
//                         style: Styles.buttonAuthText,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     "TES 1",
//                     style: TextStyle(fontSize: 180),
//                   ),
//                   Text(
//                     "TES 2",
//                     style: TextStyle(fontSize: 180),
//                   ),
//                   Text(
//                     "TES 3",
//                     style: TextStyle(fontSize: 100),
//                   ),
//                   Text(
//                     "TES 4",
//                     style: TextStyle(fontSize: 100),
//                   ),
//                   Text(
//                     "TES 5",
//                     style: TextStyle(fontSize: 100),
//                   ),
//                   Text(
//                     "TES SCROLL",
//                     style: TextStyle(fontSize: 100),
//                   ),
//                   Text(
//                     "TES SCROLL",
//                     style: TextStyle(fontSize: 100),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//   }
// }










//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Styles.primaryColor,
//       body: SingleChildScrollView(
//         physics: AlwaysScrollableScrollPhysics(),
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Image(
//                 image: AssetImage('assets/images/spoonycal mobile.png'),
//                 // width:
//                 // height:
//               ),
//               SizedBox(height: Styles.defaultPadding * 2),
//               Container(
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 decoration: BoxDecoration(
//                     color: Styles.textFormBg,
//                     borderRadius: BorderRadius.circular(5)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(4.0),
//                   child: TextField(
//                     controller: emailEmail,
//                     keyboardType: TextInputType.emailAddress,
//                     textInputAction: TextInputAction.next,
//                     cursorColor: Styles.cursorColorGreen,
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: "Masukkan Email",
//                       prefixIcon: Icon(
//                         Icons.mail_outline,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.8,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: Styles.defaultPadding),
//                   child: TextFormField(
//                     controller: passwordController,
//                     textInputAction: TextInputAction.done,
//                     obscureText: true,
//                     cursorColor: Styles.cursorColorGreen,
//                     decoration: InputDecoration(
//                       hintText: "Your password",
//                       prefixIcon: Padding(
//                         padding: const EdgeInsets.all(Styles.defaultPadding),
//                         child: Icon(Icons.lock),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: Styles.defaultPadding),
//               Hero(
//                 tag: "login_btn",
//                 child: ElevatedButton(
//                   onPressed: () async {
//                     // login();
//                     setState(() {
//                       Text(emailEmail.text);
//                     });
//                   },
//                   child: Text(
//                     "Login".toUpperCase(),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: Styles.defaultPadding),
//               DontHaveAnAccount(),

//               //   AlreadyHaveAnAccountCheck(
//               //     press: () {
//               //       Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //           builder: (context) {
//               //             return SignUpScreen();
//               //           },
//               //         ),
//               //       );
//               //     },
//               //   ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }





// //** CIRCULAR UTAMA */
                            // Container(
                            //   width: 185,
                            //   height: 185,
                            //   decoration: BoxDecoration(
                            //       color: Styles.offGreySisaKaloriColor
                            //           .withOpacity(0.3),
                            //       shape: BoxShape.circle),
                            // ),

                            // //** BORDER CIRCLE WIDGET - WARNA INTI */
                            // //                         BorderCircleWidget(sweepAngle: ((provider.myList[1].value - 15) * 12.0).clamp(0.0, 180.0),
                            // //   color: getSliderColor(provider.myList[1].value),
                            // // ),

                            // //** CIRCULAR WARNA TENGAH */
                            // Container(
                            //   width: 160,
                            //   height: 160,
                            //   decoration: BoxDecoration(
                            //     color: Colors.white,
                            //     shape: BoxShape.circle,
                            //     boxShadow: [
                            //       BoxShadow(
                            //         color: Colors.black12,
                            //         offset: const Offset(
                            //           0.0,
                            //           3.0,
                            //         ),
                            //         blurRadius: 6.0,
                            //         spreadRadius: 3.0,
                            //       ),
                            //     ],
                            //   ),
                            // ),