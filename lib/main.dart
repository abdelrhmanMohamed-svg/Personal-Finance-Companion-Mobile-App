import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'core/services/dependency_injection.dart';
import 'core/cubits/app_cubit_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies();

  Bloc.observer = AppCubitObserver();

  runApp(const PersonalFinanceApp());
}
