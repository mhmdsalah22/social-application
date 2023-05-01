// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shop_application/auth_feature/controller/verify_email_cubit/verify_email_cubit.dart';
// import 'package:shop_application/auth_feature/controller/verify_email_cubit/verify_email_state.dart';
// import 'package:shop_application/auth_feature/presentation/pages/register_screen.dart';
// import 'package:shop_application/auth_feature/presentation/pages/shop_screen.dart';
// import '../../data/data_sources/remote_data_source.dart';
//
// class VerifyEmailPage extends StatelessWidget {
//   const VerifyEmailPage({super.key});
//
//   @override
//   Widget build(BuildContext context) => RemoteDataSource().isEmailVerified
//       ? const ShopScreen()
//       : BlocProvider(
//           create: (context) => VerifyEmailCubit()..verifyEmail(),
//           child: BlocConsumer<VerifyEmailCubit, VerifyEmailState>(
//             listener: (context, state) {
//               print('verify email $state');
//               if (state is SuccessVerifyEmailState) {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const ShopScreen()),
//                     );
//                 Fluttertoast.showToast(
//                     msg: 'Success Verify Email.',
//                     toastLength: Toast.LENGTH_LONG,
//                     gravity: ToastGravity.BOTTOM,
//                     timeInSecForIosWeb: 5,
//                     backgroundColor: Colors.green,
//                     textColor: Colors.white,
//                     fontSize: 16.0);
//               }
//               if (state is ErrorVerifyEmailState) {
//                 Fluttertoast.showToast(
//                     msg: state.error,
//                     toastLength: Toast.LENGTH_LONG,
//                     gravity: ToastGravity.BOTTOM,
//                     timeInSecForIosWeb: 5,
//                     backgroundColor: Colors.red,
//                     textColor: Colors.white,
//                     fontSize: 16.0);
//               }
//             },
//             builder: (context, state) {
//               var cubit = VerifyEmailCubit.get(context);
//               return Scaffold(
//                 appBar: AppBar(
//                   title: const Text(
//                     'Verify Email',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 body: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         'A verification email has been sent to your email.',
//                         style: TextStyle(
//                           fontSize: 20,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(
//                         height: 24,
//                       ),
//                       ElevatedButton.icon(
//                         onPressed: () {
//                           cubit.verifyEmail();
//                         },
//                         icon: const Icon(
//                           Icons.email,
//                           size: 32,
//                         ),
//                         label: const Text(
//                           'SENT EMAIL',
//                           style: TextStyle(
//                             fontSize: 24,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => RegisterScreen()));
//                         },
//                         child: const Text(
//                           'CANCEL',
//                           style: TextStyle(fontSize: 24),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
// }
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_application/social_layout/presentation/pages/social_layout_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SocialLayout()), (route) => false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Email Successfully Verified")));

      timer?.cancel();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  'Check your \n Email',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'We have sent you a Email ',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets
                    .symmetric(horizontal: 32.0),
                child: Center(
                  child: Text(
                    'Verifying email....',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 57),
              Padding(
                padding: const EdgeInsets
                    .symmetric(horizontal: 32.0),
                child: ElevatedButton(
                  child: const Text('Resend'),
                  onPressed: () {
                    try {
                      FirebaseAuth.instance.currentUser
                          ?.sendEmailVerification();
                    } catch (e) {
                      debugPrint('$e');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}