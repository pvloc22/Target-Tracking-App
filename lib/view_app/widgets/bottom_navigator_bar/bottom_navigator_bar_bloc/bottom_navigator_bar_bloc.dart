import 'package:app/view_app/widgets/bottom_navigator_bar/bottom_navigator_bar_bloc/bottom_navigator_bar_event.dart';
import 'package:app/view_app/widgets/bottom_navigator_bar/bottom_navigator_bar_bloc/bottom_navigator_bar_state.dart' show BottomNavigatorBarCurrentIndexChanged, BottomNavigatorBarInitial, BottomNavigatorBarState;
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigatorBarBloc extends Bloc<BottomNavigatorBarEvent, BottomNavigatorBarState> {
  BottomNavigatorBarBloc() : super(BottomNavigatorBarInitial(currentIndex: 0)) {
    on<BottomNavChanged>(_onCurrentIndexChanged);
  }

  void _onCurrentIndexChanged(BottomNavChanged event, Emitter emit) {
    emit(BottomNavigatorBarCurrentIndexChanged(currentIndex: event.currentIndex));
  }
}

