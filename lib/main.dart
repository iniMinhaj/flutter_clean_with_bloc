import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_with_bloc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_clean_with_bloc/features/auth/presentation/pages/login_page.dart';
import 'package:get_storage/get_storage.dart';
import 'injection_container.dart' as servicelocator;

GetStorage storage = GetStorage();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await storage.initStorage;
  await servicelocator.init(); // Initialize service locator

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
          create: (context) => servicelocator.sl<AuthBloc>(),
          child: const LoginPage()),
    );
  }
}
