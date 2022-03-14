import 'dart:convert';
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:office_pair_programming/blocs/workout_search_bloc.dart';
import 'package:office_pair_programming/workout_service.dart';
import 'dart:async';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockWorkoutService extends Mock implements WorkoutsService {}

var service = MockWorkoutService();

void main() {
  group("Workout search bloc tests", () {
    final jsonFile = File('${Directory.current.path}/assets/workouts.json');
    List<dynamic> list = json.decode(jsonFile.readAsStringSync()).toList();
    when(() => service.loadWorkouts()).thenAnswer((_) => Future.value(list));
    _verifyInitialState(list);
    _verifyFilter(list);
  });
}

void _verifyInitialState(List<dynamic> list) {
  blocTest<WorkoutSearchBloc, ResultState>("WorkoutSearchBloc init event",
      build: () {
        return WorkoutSearchBloc(service);
      },
      act: (bloc) => bloc.add(InitEvent()),
      verify: (bloc) {
        expect(
          bloc.state,
          ResultState(list),
        );
      },
      errors: () => []);
}

void _verifyFilter(List<dynamic> list) {
  blocTest<WorkoutSearchBloc, ResultState>(
    "WorkoutSearchBloc filter event baseball",
    build: () {
      return WorkoutSearchBloc(service);
    },
    act: (bloc) => bloc.add(SearchWorkoutEvent("base")),
    verify: (bloc) {
      expect(
          bloc.state,
          const ResultState([
            {"name": "baseball", "image": "assets/images/types/baseball.png"}
          ]));
    },
  );
}
