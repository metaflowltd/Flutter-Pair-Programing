import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:office_pair_programming/blocs/workout_search_bloc.dart';

class WorkoutSearchList extends StatelessWidget {
  WorkoutSearchList({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value) {
              context.read<WorkoutSearchBloc>().add(SearchWorkoutEvent(value));
            },
            controller: _controller,
            decoration: const InputDecoration(
                labelText: "Search",
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
        ),
        Expanded(
          child: BlocBuilder<WorkoutSearchBloc, ResultState>(
              builder: (context, state) {
            return ListView.builder(
              itemCount: state.result.length,
              itemBuilder: (context, index) {
                final item = state.result[index];
                return ListTile(
                  title: Text(item['name']),
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(item['image']),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
