import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_state.dart';
import 'package:pantry_ai/features/auth/presentation/bloc/auth_event.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthEvent.checkAuthStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        Future.delayed(const Duration(seconds: 2), () {
          state.mapOrNull(
            authenticated: (_) => context.go('/home'),
            unauthenticated: (_) => context.go('/onboarding'),
            error: (_) => context.go('/onboarding'),
          );
        });
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF0FD656), Colors.black],
              stops: [0.20, 0.7],
            ),
          ),
          child: const Center(
            child: Text(
              'Pantry AI.',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
