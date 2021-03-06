import 'package:flutter/material.dart';
import 'package:onboarding/OnboardingStep.dart';
import 'package:onboarding/ThirdOnBoardingRoute.dart';

import 'FirstOnboardingRoute.dart';
import 'SecondOnboardingRoute.dart';
import 'StepBloc.dart';
import 'StepEvent.dart';

class SecondOnBoardingLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OnBoardingWidget();
  }
}

class _OnBoardingWidget extends State<SecondOnBoardingLayout> {
  final _bloc = StepBloc();
  OnboardingStep _step = OnboardingStep.ONE;

  _OnBoardingWidget(){
    _bloc.stepEventSink.add(LoadStepEvent());
    _bloc.step.listen((event) {setState(() {
      _step = event;
    });});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_step.toString()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Step: ${_step.toString()}'),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThirdOboardingRoute()),
                  );
                },
                child: Text("Next"))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
