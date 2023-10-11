import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_1/Providers/dashboard_state.dart';
import 'package:task_1/router/router.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  static const String _title = 'Dashboard';

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  @override
  void dispose() {
    super.dispose();
    ref.invalidate(dashboardStateProvider);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(dashboardStateProvider.notifier).getUsersList();
    });
  }

  void _handleLogout(BuildContext context) async {
    var getSharedPrefData = await SharedPreferences.getInstance();
    await getSharedPrefData.remove('token');
    if (context.mounted) {
      GoRouter.of(context).go(MyAppRouter.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Dashboard._title,
        ),
        backgroundColor: Colors.orangeAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout), // You can change the icon as needed
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
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
  @override
  Widget build(BuildContext context) {
    final response = ref.watch(dashboardStateProvider);
    return response.when(
      data: (finalData) {
        if (finalData != null) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: finalData.length,
              itemBuilder: (context, index) {
                final item = finalData[index];
                return ListTile(
                  title: Text(item.firstName ?? ""),
                  subtitle: Text(item.email ?? ""),
                  leading: Image.network(item.avatar ??
                      "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif"),
                  onTap: () {},
                );
              },
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
      loading: () {
        return Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        return Center(child: Text("Error: $error"));
      },
    );
  }
}
