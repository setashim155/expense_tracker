// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$loginStatusHash() => r'3d402387ad3cf82982204c8fa1b48932d606d90e';

/// See also [LoginStatus].
@ProviderFor(LoginStatus)
final loginStatusProvider =
    AutoDisposeNotifierProvider<LoginStatus, bool>.internal(
  LoginStatus.new,
  name: r'loginStatusProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$loginStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LoginStatus = AutoDisposeNotifier<bool>;
String _$authHash() => r'ad3973eeebedd5f899b6eb4ec2aa613b5d68031d';

/// See also [Auth].
@ProviderFor(Auth)
final authProvider = AutoDisposeAsyncNotifierProvider<Auth, void>.internal(
  Auth.new,
  name: r'authProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Auth = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
