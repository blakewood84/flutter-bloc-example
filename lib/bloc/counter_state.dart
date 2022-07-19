part of 'counter_bloc.dart';

enum CounterStatus { initial, loading, success, error }

@immutable
class CounterState extends Equatable {
  const CounterState({
    this.count,
    required this.status,
  });

  final int? count;
  final CounterStatus status;

  @override
  // TODO: implement props
  List<Object?> get props => [count, status];

  @override
  String toString() => 'CounterState(count: $count, status: $status)';
}
