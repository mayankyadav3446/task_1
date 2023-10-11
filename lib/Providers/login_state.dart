import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_1/Model_Files/login_response.dart';
import 'package:task_1/repositories/response_repository.dart';

part 'login_state.g.dart';

@riverpod
class LoginState extends _$LoginState {
  @override
  FutureOr<LoginResponse?> build() {
    return null;
  }

  Future<LoginResponse?> login(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      var result = await ref.read(loginRepositoryProvider).login(data);

      state = AsyncValue.data(result);
      return result;
    } catch (e, s) {
      state = AsyncValue.error("$e", s);
      return null;
    }
  }
}
