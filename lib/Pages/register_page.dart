import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/Pages/login_page.dart';
import 'package:login_page/widgets/main_bottom.dart';
import 'package:login_page/widgets/text_form_field.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Create your account',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 50),
                CustomTextFormField(
                  textInputAction: TextInputAction.next,
                  hintText: 'Enter email',
                  text: 'Email',
                  controller: _emailController,
                ),
                const SizedBox(height: 12.0),
                CustomTextFormField(
                  hintText: 'Enter password',
                  text: 'Password',
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 30),
                MainBottom(
                  text: 'Register',
                  onTap: () async {
                    // Validate form before proceeding
                    if (_formKey.currentState!.validate()) {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        debugPrint(
                            'User registered: ${credential.user?.email}');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          debugPrint('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          debugPrint(
                              'The account already exists for that email.');
                        }
                      }
                    }
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account?',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginPage()));
                      },
                      child: Text(
                        ' Login',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: const Color.fromARGB(255, 81, 11, 94)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
