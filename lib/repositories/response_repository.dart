
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_1/Model_Files/login_response.dart';
import 'package:task_1/Model_Files/userdata.dart';
import 'package:task_1/Model_Files/userlist_data.dart';
import 'package:task_1/api/dio.dart';

class UserListRepository {
  final Dio client;

  UserListRepository({required this.client});

  Future<List<UserData>?> getUsersList() async {
    try {
      final response = await client.get("users?page=1");
      print(response);
      if (response.statusCode == 200) {
        print("Inside DIO Get Data 1");
        final jsonData = response.data as Map<String, dynamic>;
        final result = UserListResponse.fromJson(jsonData);
        final resultNew = result.data;
        print("DIO RESPONSE ===== ${result.toString()}");
        return resultNew;
      }
      throw Exception('Failed to load data');
    } catch (e) {
      print("catch block rethrow1 $e ");
      rethrow;
    }
  }

  Future<LoginResponse> login(Map<String, dynamic> data) async {
    try {
      final response = await client.post("/login", data: data);

      if (response.statusCode == 200) {
        final body = response.data;
        return LoginResponse.fromJson(body);
      } else {
        throw Exception("Something went wrong!!");
      }
    } catch (e) {
      throw Exception("Something went wrong!!");
    }
  }

  Future<LoginResponse> register(Map<String, dynamic> data) async {
    try {
      final response = await client.post("/register", data: data);
      if (response.statusCode == 200) {
        final body = response.data;
        return LoginResponse.fromJson(body);
      } else {
        throw Exception("Something went wrong!!");
      }
    } catch (e) {
      throw Exception("Something went wrong!!");
    }
  }
}

final userRepositoryProvider = Provider.autoDispose<UserListRepository>((ref) {
  final registerRepo = UserListRepository(client: ref.watch(dioProvider));
  ref.onDispose(() => registerRepo);
  return registerRepo;
});

final loginRepositoryProvider = Provider.autoDispose<UserListRepository>((ref) {
  final loginRepo = UserListRepository(client: ref.watch(dioProvider));
  ref.onDispose(() => loginRepo);
  return loginRepo;
});
