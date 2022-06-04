import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march_task/features/home/blocs/admin/admin_bloc.dart';
import 'package:march_task/features/home/blocs/home/home_bloc.dart';
import 'package:march_task/features/home/data/badge_system_repository.dart';

import 'app.dart';
import 'app_bloc_observer.dart';
import 'features/authentication/bloc/authentication_bloc.dart';
import 'features/authentication/data/authentication_repository.dart';
import 'features/sign-in-up/bloc/form_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Hive.initFlutter();

  BlocOverrides.runZoned(
    () => runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
              AuthenticationRepositoryImpl(), BadgeSystemRepositoryImpl())
            ..add(AuthenticationStarted()),
        ),
        BlocProvider(
          create: (context) => FormBloc(AuthenticationRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => HomeBloc(
              AuthenticationRepositoryImpl(), BadgeSystemRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => AdminBloc(
              AuthenticationRepositoryImpl(), BadgeSystemRepositoryImpl()),
        )
      ],
      child: const App(),
    )),
    blocObserver: AppBlocObserver(),
  );
}
