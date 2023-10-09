
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_1/Model_Files/login_response.dart';
import 'package:task_1/Model_Files/userdata.dart';
import 'package:task_1/Model_Files/userlist_data.dart';
import 'package:task_1/api/dio.dart';



class UserListRepository {
  final Dio client;

  UserListRepository({required this.client});

  Future<UserListResponse> getUsersList() async {
    try {
      final response = await client.get("users?page=1");
      print(response);
      if (response.statusCode == 200) {
        print("Inside DIO Get Data 1");
        final jsonData = response.data as Map<String, dynamic>;
        final result = UserListResponse.fromJson(jsonData);

        print("DIO RESPONSE === ${result.toString()}");
        return result;
      }
      throw Exception('Failed to load data');
    } catch (e) {
      print("catch block rethrow $e ");
      rethrow;
    }
  }

  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await client.post(
        "login",
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = response.data as Map<String, dynamic>;
        final token = jsonData['token'] as String;
        final id = jsonData['id'] as int;
        return LoginResponse(token: token, id: id); // Return a LoginResponse object
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("catch block rethrow $e");
      rethrow;
    }
  }

  Future<LoginResponse> register(String email, String password) async {
    try {
      final response = await client.post(
        "register",
        data: {
          "email": email,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final jsonData = response.data as Map<String, dynamic>;
        final token = jsonData['token'] as String;
        final id = jsonData['id'] as int;
        return LoginResponse(token: token, id: id); // Return a LoginResponse object
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("catch block rethrow $e");
      rethrow;
    }
  }


// List<UserDataModel> getFilteredData(String searchTerm, List<UserDataModel> users) {
  //   final filteredUserData = users.where((user) {
  //     final fullName = '${user.firstName} ${user.lastName}'.toLowerCase();
  //     return fullName.contains(searchTerm);
  //   }).toList();
  //   return filteredUserData;
  // }

}
final loginRepositoryProvider = Provider.autoDispose<UserListRepository>((ref) {
  final loginRepo = UserListRepository(client: ref.watch(dioProvider));
  ref.onDispose(() => loginRepo);
  return loginRepo;
});

final userRepositoryProvider = Provider.autoDispose<UserListRepository>((ref) {
  final registerRepo = UserListRepository(client: ref.watch(dioProvider));
  ref.onDispose(() => registerRepo);
  return registerRepo;
});

final dashboardRepositoryProvider = Provider.autoDispose<UserListRepository>((ref) {
  final dashboardRepo = UserListRepository(client: ref.watch(dioProvider));
  ref.onDispose(() => dashboardRepo);
  return dashboardRepo;
});