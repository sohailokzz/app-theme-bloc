import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc()..add(InitialThemeSetEvent()),
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            theme: state,
            debugShowCheckedModeBanner: false,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dark/Ligt Theme'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Theme changing app"),
            BlocBuilder<ThemeBloc, ThemeData>(
              builder: (context, themeData) {
                return Switch.adaptive(
                  value: themeData == ThemeData.dark(),
                  onChanged: (bool val) {
                    context.read<ThemeBloc>().add(
                          ThemeSwitchEvent(),
                        );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
