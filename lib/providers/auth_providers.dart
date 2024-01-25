import 'package:expense_tracker/providers/service_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../services/auth_service.dart';

part 'auth_providers.g.dart';

@riverpod
class LoginStatus extends _$LoginStatus {
  @override
  bool build() => FirebaseAuth.instance.currentUser != null;

  void update() => state = FirebaseAuth.instance.currentUser != null;
}

@riverpod
class Auth extends _$Auth {
  AuthService get _authService => ref.read(authServiceProvider);

  @override
  FutureOr<void> build() {}

  Future<void> signUp({
    required XFile profileImage,
    required Map<String, dynamic> values,
  }) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await _authService.signUp(
        profileImage: profileImage,
        values: values,
      );

      ref.read(loginStatusProvider.notifier).update();
    });
  }

  Future<void> login({required Map<String, dynamic> values}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await _authService.login(values: values);

      ref.read(loginStatusProvider.notifier).update();
    });
  }

  Future<void> logout() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await _authService.logout();

      ref.read(loginStatusProvider.notifier).update();
    });
  }
}
