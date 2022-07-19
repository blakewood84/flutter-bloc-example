import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(status: CounterStatus.initial, count: 0)) {
    on<Increment>(_incrementHandler);
    on<Decrement>(_decrementHandler);
  }

  void _incrementHandler(CounterEvent event, Emitter<CounterState?> emit) async {
    final currentStateValue = state.count;
    emit(const CounterState(status: CounterStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    emit(CounterState(status: CounterStatus.success, count: currentStateValue! + 1));
  }

  void _decrementHandler(CounterEvent event, Emitter<CounterState?> emit) async {
    final currentStateValue = state.count;
    emit(const CounterState(status: CounterStatus.loading));
    await Future.delayed(const Duration(seconds: 2));
    emit(CounterState(status: CounterStatus.success, count: currentStateValue! - 1));
  }
}
