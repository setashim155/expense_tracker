// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$filterHash() => r'e976a87a5e536d03939e63d5fcad02447800bb20';

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

abstract class _$Filter extends BuildlessAutoDisposeNotifier<FilterOption> {
  late final TransactionType id;

  FilterOption build({
    required TransactionType id,
  });
}

/// See also [Filter].
@ProviderFor(Filter)
const filterProvider = FilterFamily();

/// See also [Filter].
class FilterFamily extends Family<FilterOption> {
  /// See also [Filter].
  const FilterFamily();

  /// See also [Filter].
  FilterProvider call({
    required TransactionType id,
  }) {
    return FilterProvider(
      id: id,
    );
  }

  @override
  FilterProvider getProviderOverride(
    covariant FilterProvider provider,
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
  String? get name => r'filterProvider';
}

/// See also [Filter].
class FilterProvider
    extends AutoDisposeNotifierProviderImpl<Filter, FilterOption> {
  /// See also [Filter].
  FilterProvider({
    required TransactionType id,
  }) : this._internal(
          () => Filter()..id = id,
          from: filterProvider,
          name: r'filterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$filterHash,
          dependencies: FilterFamily._dependencies,
          allTransitiveDependencies: FilterFamily._allTransitiveDependencies,
          id: id,
        );

  FilterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final TransactionType id;

  @override
  FilterOption runNotifierBuild(
    covariant Filter notifier,
  ) {
    return notifier.build(
      id: id,
    );
  }

  @override
  Override overrideWith(Filter Function() create) {
    return ProviderOverride(
      origin: this,
      override: FilterProvider._internal(
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
  AutoDisposeNotifierProviderElement<Filter, FilterOption> createElement() {
    return _FilterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FilterProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FilterRef on AutoDisposeNotifierProviderRef<FilterOption> {
  /// The parameter `id` of this provider.
  TransactionType get id;
}

class _FilterProviderElement
    extends AutoDisposeNotifierProviderElement<Filter, FilterOption>
    with FilterRef {
  _FilterProviderElement(super.provider);

  @override
  TransactionType get id => (origin as FilterProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
