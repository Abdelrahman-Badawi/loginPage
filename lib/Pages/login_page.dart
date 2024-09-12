import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/Pages/home_page.dart';
import 'package:login_page/Pages/register_page.dart';
import 'package:login_page/widgets/main_bottom.dart';
import 'package:login_page/widgets/text_form_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                  'Welcome Back',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Enter your credentials to login',
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
                  text: 'Login',
                  onTap: () async {
                  
                    if (_formKey.currentState!.validate()) {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      try {
                        final credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        debugPrint('User logged in: ${credential.user?.email}');
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomePage()));
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          debugPrint('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          debugPrint('Wrong password provided.');
                        }
                      }
                    }
                  },
                ),
                const SizedBox(height: 25),
                InkWell(
                  onTap: () {
               
                  },
                  child: Text(
                    'Forgot Password?',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                      },
                      child: Text(
                        ' SignUp',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: const Color.fromARGB(255, 81, 11, 94)),
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
