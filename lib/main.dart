import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:games_app/providers/videogames_provider.dart';
import 'package:games_app/screens/index.dart';
import 'package:games_app/screens/splash.dart';
import 'package:google_fonts/google_fonts.dart';

import 'l10n/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const ProviderScope(child: GamesApp()));
}

class GamesApp extends ConsumerStatefulWidget {
  const GamesApp({super.key});

  @override
  ConsumerState<GamesApp> createState() => _GamesAppState();
}

class _GamesAppState extends ConsumerState<GamesApp> {
  final _lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF334E58),
      primary: const Color(0xFFE3D8F1),
      secondary: const Color(0xFFF5DFBB),
      background: const Color(0xFF1C1C1C),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFE01A4F),
      foregroundColor: Color(0xFFFAFAFF),
      elevation: 0,
    ),
    scaffoldBackgroundColor: const Color(0xFF1C1C1C),
    iconTheme: const IconThemeData(color: Color(0xFFFAFAFF)),
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.latoTextTheme(
      ThemeData.light().textTheme,
    ),
  );

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(videogamesProvider.notifier).loadVideogames());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rawg.io Games App',
      theme: _lightTheme,
      supportedLocales: L10n.all,
      locale: const Locale('es', 'ES'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const InitialScreen(),
    );
  }
}

class InitialScreen extends ConsumerWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videogames = ref.watch(videogamesProvider);

    return videogames.isNotEmpty ? const IndexScreen() : const SplashScreen();
  }
}
