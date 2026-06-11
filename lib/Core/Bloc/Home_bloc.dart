import 'package:flutter_bloc/flutter_bloc.dart';

abstract class HomeEvent {}
class LoadHome extends HomeEvent {}

class HomeState {
  final bool isLoading;
  HomeState({this.isLoading = true});

  HomeState copyWith({bool? isLoading}) {
    return HomeState(isLoading: isLoading ?? this.isLoading);
  }
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<LoadHome>((event, emit) async {
      await Future.delayed(Duration(milliseconds: 800));
      emit(HomeState(isLoading: false));
    });
  }
}