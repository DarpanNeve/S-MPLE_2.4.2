import 'package:flutter/material.dart';
import '../../widget/snackbar.dart';
import '../../feature/login/auth_service.dart';

class RegistrationsPage extends StatefulWidget {
  const RegistrationsPage({Key? key});

  @override
  State<RegistrationsPage> createState() => _RegistrationsPageState();
}

class _RegistrationsPageState extends State<RegistrationsPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  void _signUp() async {
    _formKey.currentState!.validate();
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    if (_password == _confirmPassword) {
      await AuthService().createUserWithEmailAndPassword(_name, _email, _password, context);
      if (context.mounted) {
        Navigator.pop(context);
      }
    } else if (_password.isEmpty) {
      showSnackBar("Password can't be empty", context, Icons.error, Colors.red);
    } else {
      showSnackBar("Password do not match", context, Icons.error, Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/Images/logo-remove-bg.png',height: MediaQuery.of(context).size.height*0.2,
                  color: Theme.of(context).colorScheme.inverseSurface,),
                Text(
                  'Registration',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                            icon: const Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _name = value!;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            icon: const Icon(Icons.email),
                          ),
                          onSaved: (value) {
                            _email = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            icon: const Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _password = value!;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            icon: const Icon(Icons.lock),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _password) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _confirmPassword = value!;
                          },
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _signUp,
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Login'),
                    ),
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
