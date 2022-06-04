import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march_task/features/authentication/bloc/authentication_bloc.dart';
import 'package:march_task/features/landing/view/landing_page.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LandingPage()),
              (Route<dynamic> route) => false);
        }
      },
      buildWhen: ((previous, current) {
        if (current is AuthenticationFailure) {
          return false;
        }
        return true;
      }),
      builder: (context, authenticationState) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              actions: const <Widget>[
                _LogoutButton()
              ],
              systemOverlayStyle:
                  const SystemUiOverlayStyle(statusBarColor: Colors.blue),
              title: Text((authenticationState as AuthenticationSuccess).email),
            ),
            body: child);
      },
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
        onPressed: () async {
          context.read<AuthenticationBloc>().add(AuthenticationSignedOut());
        });
  }
}
