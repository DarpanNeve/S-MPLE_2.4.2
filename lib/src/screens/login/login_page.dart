
import 'package:flutter/material.dart';
import 'package:medi_connect/src/feature/fcm/notification_initialiser.dart';
import 'package:medi_connect/src/screens/register/registrations_page.dart';

import '../../feature/login/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  _signIn() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthService().signInWithEmailAndPassword(_email, _password, context);
    }
  }

  @override
  void dispose() {
    _email = '';
    _password = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/Images/logo-remove-bg.png',
                  height: MediaQuery.of(context).size.height * 0.2,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Login for the project',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock),
                          labelText: 'Password',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _signIn,
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: ()async {
                          // await notification().scheduleNotification(DateTime.now().add(Duration(seconds: 5)));
                          await AuthService().signInWithGoogle(context);
                        },
                        icon: Image.asset('assets/Images/google.png'),
                        label: Text(
                          'Sign in with Google',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegistrationsPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Register now',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
