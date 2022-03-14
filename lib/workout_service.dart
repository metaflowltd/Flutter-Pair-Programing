import 'dart:convert';

import 'package:flutter/services.dart';

class WorkoutsService {
  WorkoutsService() : super();

  Future<List<dynamic>> loadWorkouts() async {
    var jsonText = await rootBundle.loadString('assets/workouts.json');
    return json.decode(jsonText);
  }
}
