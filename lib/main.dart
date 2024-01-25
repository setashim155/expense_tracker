import 'package:expense_tracker/providers/auth_providers.dart';
import 'package:expense_tracker/shared/router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

void main() async {
  // ------------ Initialization -----------
  WidgetsFlutterBinding.ensureInitialized();

  // For Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // -------------------------------------

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // For user auth state changes
    ref.listen(loginStatusProvider, (_, next) => router.refresh());

    return MaterialApp.router(
      title: 'Expense Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
