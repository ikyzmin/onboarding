import 'dart:async';

import 'package:onboarding/CheckSettingsEvent.dart';
import 'package:onboarding/OnboardingStep.dart';
import 'package:onboarding/SettingsState.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBloc {
  ChangeCheckState changeCheckState = ChangeCheckState(false, false, false);

  MainBloc() {
    _mainBlocEventController.stream.listen(_eventToState);
  }

  final _mainBlocEventController = StreamController<SettingsEvent>();

  StreamSink<SettingsEvent> get inEvent => _mainBlocEventController.sink;
  final _mainBlocController = StreamController<SettingsState>();

  Stream get mainStream => _mainBlocController.stream;

  StreamSink get mainSink => _mainBlocController.sink;

  void _eventToState(SettingsEvent event) async {
    final prefs = await SharedPreferences.getInstance();
    if (event is InitEvent) {
      await prefs.clear();
      mainSink.add(changeCheckState);
    }
    if (event is FirstCheckEvent) {
      prefs.setBool(OnboardingStep.ONE.toString(), event.enable);
      changeCheckState.first = event.enable;
      mainSink.add(changeCheckState);
    } else if (event is SecondCheckEvent) {
      prefs.setBool(OnboardingStep.TWO.toString(), event.enable);
      changeCheckState.second = event.enable;
      mainSink.add(changeCheckState);
    } else if (event is ThirdCheckEvent) {
      prefs.setBool(OnboardingStep.THREE.toString(), event.enable);
      changeCheckState.third = event.enable;
      mainSink.add(changeCheckState);
    }
  }

  void dispose() {
    _mainBlocController.close();
    _mainBlocEventController.close();
  }
}
