import 'dart:async';

import 'package:onboarding/OnboardingStep.dart';
import 'package:onboarding/StepEvent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepBloc {
  StepBloc() {
    _stepEventController.stream.listen(_eventToState);
  }

  final _stepStateController = StreamController<OnboardingStep>();

  StreamSink<OnboardingStep> get _inStep => _stepStateController.sink;

  Stream<OnboardingStep> get step => _stepStateController.stream;
  final _stepEventController = StreamController<StepEvent>();

  Sink<StepEvent> get stepEventSink => _stepEventController.sink;

  void _eventToState(StepEvent event) async {
    final prefs = await SharedPreferences.getInstance();
    if (event is LoadStepEvent) {
        for (OnboardingStep step in OnboardingStep.values) {
          if (prefs.getBool(step.toString()) != null &&
              prefs.getBool(step.toString())) {
            _inStep.add(step);
            await prefs.setBool(step.toString(), false);
            return;
          }
        }
    }
  }

  void dispose() {
    _stepEventController.close();
    _stepStateController.close();
  }
}
