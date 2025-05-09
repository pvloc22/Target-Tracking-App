import 'package:app/view_app/screens/home/bloc/home_event.dart';
import 'package:app/view_app/screens/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(InitHomeScreen()) {
    on<FetchData>(_onInitHomeScreen);
  }

  void _onInitHomeScreen(FetchData event, Emitter<HomeState> emit) {
    emit(LoadingHomeScreen());
    Future.delayed(const Duration(seconds: 2));
    emit(SuccessHomeScreen(taskToday: [], goals: [], goalsCompleted: [], goalsArchived: []));
  }
}
