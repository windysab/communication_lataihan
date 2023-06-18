// ignore_for_file: unused_element

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:communication_lataihan/bloc/color/color_bloc.dart';
import 'package:flutter/material.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int incrementSize = 1;
  final ColorBloc colorBloc;
  late final StreamSubscription colorSubscription;
  CounterBloc({
    required this.colorBloc,
  }) : super(CounterState.initial()) {
    colorSubscription = colorBloc.stream.listen(
      (ColorState state) {
        if (state.color == Colors.red) {
          incrementSize = 1;
        } else if (state.color == Colors.green) {
          incrementSize = 10;
        } else if (state.color == Colors.blue) {
          incrementSize = 100;
        } else if (state.color == Colors.black) {
          incrementSize = -100;
        }
      },
    );
    on<ChangeCounter>((event, emit) {
      emit(state.copyWith(counter: state.counter + incrementSize));
    });

    
    @override
    Future<void> close() {
      colorSubscription.cancel();
      return super.close();
    }
  }
}
