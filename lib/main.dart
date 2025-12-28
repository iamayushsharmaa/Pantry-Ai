import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/app_settings/app_settings_bloc.dart';
import 'core/di/injections.dart';
import 'core/router/router.dart';
import 'core/theme/theme.dart';
import 'features/analytics/presentation/bloc/analytics_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/favorites/presentation/bloc/favorites_bloc.dart';
import 'features/home/presentation/bloc/quick_bloc/quick_recipe_bloc.dart';
import 'features/home/presentation/bloc/recent_bloc/home_bloc.dart';
import 'features/save_recipe/presentation/bloc/saved_bloc.dart';
import 'features/settings/presentation/bloc/settings_bloc.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  try {
    await dotenv.load(fileName: ".env");
  } catch (_) {
    throw Exception('.env file not lfound');
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<HomeBloc>()..add(const LoadRecentRecipes()),
        ),
        BlocProvider(
          create: (_) => sl<QuickRecipesBloc>()..add(const LoadQuickRecipes()),
        ),
        BlocProvider(create: (_) => sl<AnalyticsBloc>()..add(LoadAnalytics())),
        BlocProvider(create: (_) => sl<SettingsBloc>()..add(SettingsStarted())),
        BlocProvider(create: (_) => sl<AuthBloc>()),
        BlocProvider(create: (_) => sl<FavoritesBloc>()),
        BlocProvider(create: (_) => sl<SavedBloc>()),
        BlocProvider(create: (_) => sl<AppSettingsBloc>()),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    final themeMode = context.select<AppSettingsBloc, ThemeMode>(
      (b) => b.state.themeMode,
    );

    final locale = context.select<AppSettingsBloc, Locale>(
      (b) => b.state.locale,
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,

      locale: locale,
      supportedLocales: const [Locale('en'), Locale('hi'), Locale('es')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
