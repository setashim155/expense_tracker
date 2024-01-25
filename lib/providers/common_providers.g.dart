// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$passwordVisibilityHash() =>
    r'0497d63d25094d18d2962ad9105876918887fc25';

/// See also [PasswordVisibility].
@ProviderFor(PasswordVisibility)
final passwordVisibilityProvider =
    AutoDisposeNotifierProvider<PasswordVisibility, bool>.internal(
  PasswordVisibility.new,
  name: r'passwordVisibilityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$passwordVisibilityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PasswordVisibility = AutoDisposeNotifier<bool>;
String _$imageNotifierHash() => r'ef195a4151888e620d570da0706f16ff24d39cac';

/// See also [ImageNotifier].
@ProviderFor(ImageNotifier)
final imageNotifierProvider =
    AutoDisposeNotifierProvider<ImageNotifier, XFile?>.internal(
  ImageNotifier.new,
  name: r'imageNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$imageNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ImageNotifier = AutoDisposeNotifier<XFile?>;
String _$editStatusHash() => r'8ac96ed83244fdbbdddda37e75015e3b99082529';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$EditStatus extends BuildlessAutoDisposeNotifier<bool> {
  late final String id;

  bool build({
    required String id,
  });
}

/// See also [EditStatus].
@ProviderFor(EditStatus)
const editStatusProvider = EditStatusFamily();

/// See also [EditStatus].
class EditStatusFamily extends Family<bool> {
  /// See also [EditStatus].
  const EditStatusFamily();

  /// See also [EditStatus].
  EditStatusProvider call({
    required String id,
  }) {
    return EditStatusProvider(
      id: id,
    );
  }

  @override
  EditStatusProvider getProviderOverride(
    covariant EditStatusProvider provider,
  ) {
    return call(
      id: provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'editStatusProvider';
}

/// See also [EditStatus].
class EditStatusProvider
    extends AutoDisposeNotifierProviderImpl<EditStatus, bool> {
  /// See also [EditStatus].
  EditStatusProvider({
    required String id,
  }) : this._internal(
          () => EditStatus()..id = id,
          from: editStatusProvider,
          name: r'editStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$editStatusHash,
          dependencies: EditStatusFamily._dependencies,
          allTransitiveDependencies:
              EditStatusFamily._allTransitiveDependencies,
          id: id,
        );

  EditStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  bool runNotifierBuild(
    covariant EditStatus notifier,
  ) {
    return notifier.build(
      id: id,
    );
  }

  @override
  Override overrideWith(EditStatus Function() create) {
    return ProviderOverride(
      origin: this,
      override: EditStatusProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<EditStatus, bool> createElement() {
    return _EditStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EditStatusProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EditStatusRef on AutoDisposeNotifierProviderRef<bool> {
  /// The parameter `id` of this provider.
  String get id;
}

class _EditStatusProviderElement
    extends AutoDisposeNotifierProviderElement<EditStatus, bool>
    with EditStatusRef {
  _EditStatusProviderElement(super.provider);

  @override
  String get id => (origin as EditStatusProvider).id;
}

String _$chartPeriodNotifierHash() =>
    r'f825f420a16f70b03a17bc742878ffcf87ead9c3';

/// See also [ChartPeriodNotifier].
@ProviderFor(ChartPeriodNotifier)
final chartPeriodNotifierProvider =
    AutoDisposeNotifierProvider<ChartPeriodNotifier, ChartPeriod?>.internal(
  ChartPeriodNotifier.new,
  name: r'chartPeriodNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chartPeriodNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChartPeriodNotifier = AutoDisposeNotifier<ChartPeriod?>;
String _$chartBuildStatusHash() => r'aa069b2a84bf047b9b1755cdb7526e2cc4ce0dfe';

/// See also [ChartBuildStatus].
@ProviderFor(ChartBuildStatus)
final chartBuildStatusProvider =
    AutoDisposeNotifierProvider<ChartBuildStatus, bool?>.internal(
  ChartBuildStatus.new,
  name: r'chartBuildStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$chartBuildStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChartBuildStatus = AutoDisposeNotifier<bool?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
