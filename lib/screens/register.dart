import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_1/Model_Files/login_response.dart';
import 'package:task_1/Providers/register_state.dart';
import 'package:task_1/providers/shared_preference_provider.dart';
import 'package:task_1/router/router.dart';

class Register extends ConsumerStatefulWidget {
  const Register({Key? key}) : super(key: key);

  static const String _title = 'Register';

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Register._title)),
      body: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends ConsumerStatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends ConsumerState<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    passwordController.dispose();
    ref.invalidate(registerStateProvider);
  }

  Widget build(BuildContext context) {
    ref.listen(registerStateProvider, (previous, next) {
      next.when(data: (data) {
        ref
            .read(sharedUtilityProvider)
            .setToken(token: (data as LoginResponse).token ?? "");
        showSnackbar(context, "Registered successfully");
        nameController.clear();
        passwordController.clear();
        context.go(MyAppRouter.dashboard);
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
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Text(
              'Please register here!',
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
                hintText: 'Enter valid mail id',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Confirm Password',
              ),
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              child: Text('Register'),
              onPressed: () {
                FocusScope.of(context).unfocus();
                FocusScope.of(context).unfocus();
                //if (_formKey.currentState!.validate()) {
                final user = {
                  "email": nameController.text,
                  "password": passwordController.text
                };
                ref.read(registerStateProvider.notifier).register(user);
                // }
              },
            ),
          ),
        ],
      ),
    );
  }

  bool isValidate() {
    if (nameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

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
