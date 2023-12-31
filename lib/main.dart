import 'dart:io';

import 'package:buddy/config/routes/app_route.dart';
import 'package:buddy/config/theme/app_theme.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_bloc.dart';
import 'package:buddy/features/dog/presentation/bloc/dog/remote/remote_dog_event.dart';
import 'package:buddy/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize dependency injections
  initializeDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RemoteDogBloc>()..add(RemoteDogFetch()),
      child: MaterialApp.router(
        theme: theme,
        routerConfig: sl<AppRouter>().config(),
      ),
    );
  }
}
