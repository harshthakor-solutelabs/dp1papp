import 'package:flutter_deriv_api/api/common/tick/tick.dart';

abstract class TickSubState{}

class TicksInitial extends TickSubState {}

class TicksLoading extends TickSubState {
  @override
  String toString() => 'TicksLoading...';
}

class TicksLoaded extends TickSubState {
  TicksLoaded({
    this.tick,
  });

  final Tick? tick;
}

class TicksError extends TickSubState {
  TicksError(this.message);

  final String? message;

  @override
  String toString() => 'TicksError';
}

