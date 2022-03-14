import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_pair_programming/workout_service.dart';

abstract class SearchEvent {}

class InitEvent extends SearchEvent {}

class SearchWorkoutEvent extends SearchEvent {
  final String query;

  SearchWorkoutEvent(this.query);
}

class ResultState extends Equatable {
  final List<dynamic> result;

  const ResultState(this.result);

  @override
  List<Object> get props => [result];
}

class WorkoutSearchBloc extends Bloc<SearchEvent, ResultState> {
  List<dynamic> items = <dynamic>[];
  final WorkoutsService workoutsService;

  WorkoutSearchBloc(this.workoutsService) : super(const ResultState(<dynamic>[])) {
    on<InitEvent>((event, emit) => _initState(emit));
    on<SearchWorkoutEvent>((event, emit) => _onSearchState(event.query, emit));
    add(InitEvent());
  }

  void _onSearchState(String query, Emitter<ResultState> emit) {
    final List<dynamic> filteredList = <dynamic>[];
    if (query.isNotEmpty) {
      filteredList.clear();
      for (var item in items) {
        if (item['name'].contains(query)) {
          filteredList.add(item);
        }
      }
      emit(ResultState(filteredList));
    } else {
      filteredList.clear();
      filteredList.addAll(items);
      emit(ResultState(filteredList));
    }
  }

  Future<void> _initState(Emitter<ResultState> emit) async {
    items = await workoutsService.loadWorkouts();
    emit(ResultState(items));
  }
}
