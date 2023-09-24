import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import 'home_page.dart';
import 'signin_page.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.authStatus == AuthStatus.unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            SigninPage.routeName,
            (route) {
              return route.settings.name ==
                  ModalRoute.of(context)!.settings.name;
            },
          );
        } else if (state.authStatus == AuthStatus.authenticated) {
          Navigator.pushNamed(context, HomePage.routeName);
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
