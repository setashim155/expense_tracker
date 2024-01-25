// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allIncomesHash() => r'67ade9985f20136eca18214fce084f9aa6956391';

/// See also [allIncomes].
@ProviderFor(allIncomes)
final allIncomesProvider = AutoDisposeStreamProvider<List<Income>>.internal(
  allIncomes,
  name: r'allIncomesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allIncomesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllIncomesRef = AutoDisposeStreamProviderRef<List<Income>>;
String _$recentIncomesHash() => r'cf08fcd079af3e0677e0c47a26b334a924755bad';

/// See also [recentIncomes].
@ProviderFor(recentIncomes)
final recentIncomesProvider = AutoDisposeStreamProvider<List<Income>>.internal(
  recentIncomes,
  name: r'recentIncomesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recentIncomesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecentIncomesRef = AutoDisposeStreamProviderRef<List<Income>>;
String _$incomeNotifierHash() => r'ae8275e40546ddb789aaef0fba543c64249b6035';

/// See also [IncomeNotifier].
@ProviderFor(IncomeNotifier)
final incomeNotifierProvider =
    AutoDisposeAsyncNotifierProvider<IncomeNotifier, void>.internal(
  IncomeNotifier.new,
  name: r'incomeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$incomeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IncomeNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
