import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_1/Model_Files/userdata.dart';
import 'package:task_1/repositories/response_repository_provider.dart';

part 'dashboard_state.g.dart';

@riverpod
class DashboardState extends _$DashboardState {
  @override
  FutureOr<List<UserData>?> build() {
    return null;
  }

  Future<List<UserData>?> getUsersList() async {
    try {
      final userData =
          await ref.read(userListRepositoryProvider).getUsersList();
      state = AsyncValue.data(userData);
    } on DioException catch (e) {
      print('Error searching User Response due to DIO EXCEPTION: $e');
      state = AsyncValue.error(
          'Error searching User Response: $e', StackTrace.current);
    } catch (e) {
      print('Error searching User Response : $e');
      state =
          AsyncValue.error('Error searching products: $e', StackTrace.current);
    }
  }
}
