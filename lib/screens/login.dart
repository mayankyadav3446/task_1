import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_1/Model_Files/login_response.dart';
import 'package:task_1/Providers/login_state.dart';
import 'package:task_1/providers/shared_preference_provider.dart';
import 'package:task_1/router/router.dart';

class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  static const String _title = 'Login';

  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(Login._title)),
      body: const MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends ConsumerStatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  ConsumerState<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends ConsumerState<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    ref.invalidate(loginStateProvider);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginStateProvider, (previous, next) {
      next.when(data: (data) {
        print("hhh  ${(data as LoginResponse).token}");
        ref
            .read(sharedUtilityProvider)
            .setToken(token: (data as LoginResponse).token ?? "");
        showSnackbar(context, "Login successfully");
        nameController.clear();
        passwordController.clear();
        GoRouter.of(context).go(MyAppRouter.dashboard);
      }, loading: () {
        showLoader();
      }, error: (msg, s) {
        showSnackbar(context, "Something went wrong!!");
      });
    });
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: Container(
              width: 120,
              height: 120,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/Images/loginIcon.png',
                width: 80,
                height: 80,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Text(
              'Please log in first',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 10,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              //forgot password screen
            },
            child: Text(
              'Forgot Password',
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                FocusScope.of(context).unfocus();
                //if (_formKey.currentState!.validate()) {
                final user = {
                  "email": nameController.text,
                  "password": passwordController.text
                };
                ref.read(loginStateProvider.notifier).login(user);
                // }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Don't have an account?"),
              TextButton(
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 20, color: Colors.orangeAccent),
                ),
                onPressed: () {
                  context.pushNamed(MyAppRouter.register);
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  // bool isValidate() {
  //   if (nameController.text.isNotEmpty &&
  //       passwordController.text.isNotEmpty) {
  //     return true;
  //   }
  //   return false;
  // }
  void showSnackbar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: const Duration(seconds: 5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget showLoader() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
