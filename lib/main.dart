import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_pair_programming/blocs/workout_search_bloc.dart';
import 'package:office_pair_programming/widgets/workout_search_list.dart';
import 'package:office_pair_programming/workout_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter pair programming',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WorkoutsScreen(title: 'Workouts Home Page'),
    );
  }
}

class WorkoutsScreen extends StatelessWidget {
  final String title;

  const WorkoutsScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocProvider(
          create: (_) => WorkoutSearchBloc(WorkoutsService()),
          child: WorkoutSearchList()),
    );
  }
}



