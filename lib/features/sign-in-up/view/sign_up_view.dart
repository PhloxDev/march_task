import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:march_task/features/home/view/home_page.dart';
import 'package:march_task/core/utils/constants.dart';

import '../../authentication/authentication.dart';
import '../../landing/view/landing_page.dart';
import '../bloc/form_bloc.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MultiBlocListener(
        listeners: [
          BlocListener<FormBloc, FormsValidate>(
            listener: (context, state) {
              if (state.errorMessage.isNotEmpty) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        ErrorDialog(errorMessage: state.errorMessage));
              } else if (state.isFormValid && !state.isLoading) {
                context.read<AuthenticationBloc>().add(AuthenticationStarted());
                context.read<FormBloc>().add(const FormSucceeded());
              } else if (state.isFormValidateFailed) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Please fill data correctly')));
              }
            },
          ),
          BlocListener<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationSuccess) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (Route<dynamic> route) => false);
              }
            },
          ),
        ],
        child: Scaffold(
            backgroundColor: Constants.kPrimaryColor,
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(bottom: size.height * 0.02)),
                      const _EmailField(),
                      SizedBox(height: size.height * 0.01),
                      const _PasswordField(),
                      SizedBox(height: size.height * 0.01),
                      const _DisplayNameField(),
                      SizedBox(height: size.height * 0.01),
                      const _SubmitButton()
                    ]),
              ),
            )));
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
              onChanged: (value) {
                context.read<FormBloc>().add(EmailChanged(value));
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                helperText: 'e.g. mary@gmail.com',
                errorText: !state.isEmailValid
                    ? 'Please ensure the email entered is valid'
                    : null,
                hintText: 'Email',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 10.0),
              )),
        );
      },
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              helperText:
                  '''Password should be at least 8 characters with at least one letter and number''',
              helperMaxLines: 2,
              labelText: 'Password',
              errorMaxLines: 2,
              errorText: !state.isPasswordValid
                  ? '''Password must be at least 8 characters and contain at least one letter and number'''
                  : null,
            ),
            onChanged: (value) {
              context.read<FormBloc>().add(PasswordChanged(value));
            },
          ),
        );
      },
    );
  }
}

class _DisplayNameField extends StatelessWidget {
  const _DisplayNameField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return SizedBox(
          width: size.width * 0.8,
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              helperText: '''Name must be valid!''',
              helperMaxLines: 2,
              labelText: 'Name',
              errorMaxLines: 2,
              errorText:
                  !state.isNameValid ? '''Name cannot be empty!''' : null,
            ),
            onChanged: (value) {
              context.read<FormBloc>().add(NameChanged(value));
            },
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<FormBloc, FormsValidate>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                width: size.width * 0.8,
                child: OutlinedButton(
                  onPressed: !state.isFormValid
                      ? () => context
                          .read<FormBloc>()
                          .add(const FormSubmitted(value: Status.signUp))
                      : null,
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Constants.kPrimaryColor),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Constants.kBlackColor),
                      side: MaterialStateProperty.all<BorderSide>(
                          BorderSide.none)),
                  child: const Text('sign up'),
                ),
              );
      },
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String? errorMessage;
  const ErrorDialog({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(errorMessage!),
      actions: [
        TextButton(
          child: const Text("Ok"),
          onPressed: () => errorMessage!.contains("Please Verify your email")
              ? Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                  (Route<dynamic> route) => false)
              : Navigator.of(context).pop(),
        )
      ],
    );
  }
}
