import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_1/Model_Files/login_response.dart';
import 'package:task_1/repositories/response_repository.dart';

part 'register_state.g.dart';

@riverpod
class RegisterState extends _$RegisterState {
  @override
  FutureOr<LoginResponse?> build() {
    return null;
  }

  Future<LoginResponse?> register(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      var result = await ref.read(userRepositoryProvider).register(data);

      state = AsyncValue.data(result);
      return result;
    } catch (e, stackTrace) {
      state = AsyncValue.error("$e", stackTrace);
      return null;
    }
  }
}
