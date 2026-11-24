import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const _supabaseUrl = String.fromEnvironment('SUPABASE_URL');
const _supabaseAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (_supabaseUrl.isEmpty || _supabaseAnonKey.isEmpty) {
    runApp(const ConfigurationMissingApp());
    return;
  }

  try {
    await Supabase.initialize(url: _supabaseUrl, anonKey: _supabaseAnonKey);
    runApp(const StrideApp(isSupabaseConfigured: true));
  } catch (error) {
    runApp(ConfigurationErrorApp(error: error));
  }
}

class StrideApp extends StatelessWidget {
  const StrideApp({super.key, required this.isSupabaseConfigured});

  final bool isSupabaseConfigured;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Stride',
        theme: ThemeData(colorSchemeSeed: const Color(0xff285943), useMaterial3: true),
        darkTheme: ThemeData(
          colorSchemeSeed: const Color(0xff285943),
          brightness: Brightness.dark,
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(title: const Text('Stride')),
          body: Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Icon(Icons.directions_run, size: 64, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 16),
              const Text('Stride', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text(isSupabaseConfigured ? 'Supabase configuration loaded.' : 'Supabase is not configured.'),
            ]),
          ),
        ),
      );
}

class ConfigurationMissingApp extends StatelessWidget {
  const ConfigurationMissingApp({super.key});

  @override
  Widget build(BuildContext context) => const _ConfigurationApp(
        title: 'Stride needs configuration',
        message: 'Launch Stride with SUPABASE_URL and SUPABASE_ANON_KEY using --dart-define.',
      );
}

class ConfigurationErrorApp extends StatelessWidget {
  const ConfigurationErrorApp({super.key, required this.error});
  final Object error;

  @override
  Widget build(BuildContext context) => _ConfigurationApp(
        title: 'Stride could not start',
        message: 'Supabase could not be initialized. Check the launch configuration.\n$error',
      );
}

class _ConfigurationApp extends StatelessWidget {
  const _ConfigurationApp({required this.title, required this.message});
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Stride',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xff285943)),
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.settings_alert_outlined, size: 48),
                const SizedBox(height: 16),
                Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(message, textAlign: TextAlign.center),
              ]),
            ),
          ),
        ),
      );
}
