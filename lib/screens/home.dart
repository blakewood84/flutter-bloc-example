import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_example/bloc/counter_bloc.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

enum CounterType { increment, decrement }

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final ValueNotifier<CounterType> counterType = ValueNotifier(CounterType.increment);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CounterBloc, CounterState>(
        // Optional: I can choose when the BlocConsumer or Builder should build.
        // That means I can exclude it from building on certain values.
        buildWhen: (previous, current) {
          return current.status == CounterStatus.loading || current.status == CounterStatus.success;
        },
        // This Listener listen's for changes to the Bloc.
        // Currently if an increment is successful, it display's a snackbar.
        listener: (context, state) {
          switch (state.status) {
            case CounterStatus.initial:
              {
                // TODO: Handle this case.
                break;
              }
            case CounterStatus.error:
              {
                // TODO: Handle this case.
                break;
              }

            case CounterStatus.loading:
              {
                // TODO: Handle this case.
                break;
              }

            case CounterStatus.success:
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Count has been changed',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    duration: Duration(seconds: 1),
                    backgroundColor: Colors.black,
                  ),
                );
                break;
              }
          }
        },
        // Builder detects state changes of Bloc and acts accordingly
        builder: (context, state) {
          // For logging state changes in debug console;
          state.log();

          // Whenever CounterLoading occurs, the bloc is fetching. Show Loading Indiciator.
          if (state.status == CounterStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orangeAccent,
              ),
            );
          }

          // Display current state of Bloc by accessing state.counter
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Counter value:',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  state.count.toString(),
                  style: const TextStyle(color: Colors.amberAccent, fontSize: 24),
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder<CounterType>(
                    valueListenable: counterType,
                    builder: (context, CounterType value, widget) {
                      return ElevatedButton(
                        onPressed: () {
                          if (value == CounterType.increment) counterType.value = CounterType.decrement;
                          if (value == CounterType.decrement) counterType.value = CounterType.increment;
                        },
                        child: Text(
                          value == CounterType.increment ? 'Change to Decrement' : 'Change to Increment',
                        ),
                      );
                    })
              ],
            ),
          );
        },
      ),
      floatingActionButton: ValueListenableBuilder<CounterType>(
        valueListenable: counterType,
        builder: (context, CounterType value, widget) {
          return FloatingActionButton(
            onPressed: () {
              final loading = context.read<CounterBloc>().state.status == CounterStatus.loading;

              // Don't allow button to be pressed unless loading is finished
              if (!loading) {
                // Send action here by .add() to the CounterBloc
                context.read<CounterBloc>().add(
                      value == CounterType.increment ? const Increment() : const Decrement(),
                    );
              }
            },
            child: Icon(
              // Change icon here depending on counter type
              value == CounterType.increment ? Icons.add : Icons.remove,
            ),
          );
        },
      ),
    );
  }
}
