part of 'counter_bloc.dart';

class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}

// These empty classes are events. These are the same as Action Types in Redux.
class Increment extends CounterEvent {}

class Decrement extends CounterEvent {}
