import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'counter_actions.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(status: CounterStatus.initial, count: 0)) {
    // Do something for each action sent to the Bloc
    on<Increment>(_incrementHandler);
    on<Decrement>(_decrementHandler);
  }

  void _incrementHandler(CounterEvent event, Emitter<CounterState?> emit) async {
    final newCountValue = state.count! + 1;
    // emits a new state change
    emit(const CounterState(status: CounterStatus.loading));
    // Future.delayed to mimic an API request
    await Future.delayed(const Duration(seconds: 2));
    // emits a new state change
    emit(CounterState(status: CounterStatus.success, count: newCountValue));
  }

  void _decrementHandler(CounterEvent event, Emitter<CounterState?> emit) async {
    final newCountValue = state.count! - 1;
    emit(const CounterState(status: CounterStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    emit(CounterState(status: CounterStatus.success, count: newCountValue));
  }
}
