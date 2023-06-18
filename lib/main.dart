import 'package:communication_lataihan/bloc/color/color_bloc.dart';
import 'package:communication_lataihan/bloc/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorBloc>(
          create: (context) => ColorBloc(),
        ),
        BlocProvider<CounterBloc>(
          create: (context) =>
              CounterBloc(colorBloc: context.read<ColorBloc>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bloc to Cubit Communication',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ColorBloc>().state.color,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<ColorBloc>(context).add(ChangeColorEvent());
              },
              child: const Text(
                'Change Color',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              '${context.watch<CounterBloc>().state.counter}',
              style: const TextStyle(
                  fontSize: 52.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<CounterBloc>().add(ChangeCounter());
                },
                child: const Text(
                  'Increment Counter',
                  style: TextStyle(fontSize: 24.0),
                ))
          ],
        ),
      ),
    );
  }
}
