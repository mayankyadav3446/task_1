import 'package:go_router/go_router.dart';
import 'package:task_1/screens/dashboard.dart';
import 'package:task_1/screens/login.dart';
import 'package:task_1/screens/register.dart';
import 'package:task_1/screens/splash.dart';

class MyAppRouter {
  // static var _isLogin = false;

  //MyAppRouter({required bool isLogin}){
  // _isLogin = isLogin;
  //   // _isDashboard = isDashboard;
  // }

  static String splash = "/";
  static String register = '/register';
  static String login = '/login';
  static String dashboard = '/dashboard';

  final router = GoRouter(
    routes: [
      GoRoute(
        name: splash,
        path: splash,
        builder: (context, state) => const Splash(),
      ),
      GoRoute(
        name: register,
        path: register,
        builder: (context, state) => const Register(),
      ),
      GoRoute(
        name: login,
        path: login,
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        name: dashboard,
        path: dashboard,
        builder: (context, state) => const Dashboard(),
      ),
    ],
    // redirect: (context, state){
    //   if(!_isLogin) {
    //     return MyAppRouter.dashboard;
    //   }
    //   return null;
    // }
  );
}
