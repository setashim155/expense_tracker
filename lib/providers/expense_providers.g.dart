// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allExpensesHash() => r'3340a03ba7d030bce7c81deac4e8dd8a19108c5b';

/// See also [allExpenses].
@ProviderFor(allExpenses)
final allExpensesProvider = AutoDisposeStreamProvider<List<Expense>>.internal(
  allExpenses,
  name: r'allExpensesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allExpensesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllExpensesRef = AutoDisposeStreamProviderRef<List<Expense>>;
String _$recentExpensesHash() => r'9fda886d1439f7b449e0decf3b21af7e54397940';

/// See also [recentExpenses].
@ProviderFor(recentExpenses)
final recentExpensesProvider =
    AutoDisposeStreamProvider<List<Expense>>.internal(
  recentExpenses,
  name: r'recentExpensesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recentExpensesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecentExpensesRef = AutoDisposeStreamProviderRef<List<Expense>>;
String _$expenseNotifierHash() => r'9798ffa04e2df3af356e6ebaaa6982c96781aa60';

/// See also [ExpenseNotifier].
@ProviderFor(ExpenseNotifier)
final expenseNotifierProvider =
    AutoDisposeAsyncNotifierProvider<ExpenseNotifier, void>.internal(
  ExpenseNotifier.new,
  name: r'expenseNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$expenseNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ExpenseNotifier = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
