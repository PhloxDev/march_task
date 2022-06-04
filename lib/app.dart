import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/home/view/admin_page.dart';
import 'features/authentication/bloc/authentication_bloc.dart';
import 'features/home/view/home_page.dart';
import 'features/landing/view/landing_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const BlocNavigate(),
        title: 'March health task',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ));
  }
}

class BlocNavigate extends StatelessWidget {
  const BlocNavigate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          if (state.email == 'mary@gmail.com') {
            return const AdminPage();
          }
          return const HomePage();
        } else {
          return const LandingPage();
        }
      },
    );
  }
}
