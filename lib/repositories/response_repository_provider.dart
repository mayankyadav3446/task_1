
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:task_1/api/dio.dart';
import 'package:task_1/repositories/response_repository.dart';

part 'response_repository_provider.g.dart';

@riverpod
UserListRepository userListRepository(UserListRepositoryRef ref) =>
    UserListRepository(
      client: ref.watch(dioProvider), // the provider we defined above
    );