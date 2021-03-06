import 'package:flutter/material.dart';
import 'package:onboarding/CheckSettingsEvent.dart';
import 'package:onboarding/MainBloc.dart';
import 'package:onboarding/OnboardingStep.dart';
import 'package:onboarding/SettingsState.dart';
import 'package:onboarding/StepEvent.dart';

import 'FirstOnboardingRoute.dart';
import 'SecondOnboardingRoute.dart';
import 'StepBloc.dart';
import 'ThirdOnBoardingRoute.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage()
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _bloc = MainBloc()..inEvent.add(InitEvent());
  bool _firstCheckValue = false;
  bool _secondCheckValue = false;
  bool _thirdCheckValue = false;
  MaterialPageRoute route =  MaterialPageRoute(
      builder: (context) => FirstOboardingRoute());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Onboarding Flutter Example"),
      ),
      body: Center(
        child: StreamBuilder(
            stream: _bloc.mainStream,
            initialData: ChangeCheckState(false, false, false),
            builder: (context, snapshot) {
              if (snapshot.data is ChangeCheckState) {
                _firstCheckValue = (snapshot.data as ChangeCheckState).first;
                _secondCheckValue = (snapshot.data as ChangeCheckState).second;
                _thirdCheckValue = (snapshot.data as ChangeCheckState).third;
              }
              if (_firstCheckValue) {
                route = MaterialPageRoute(
                        builder: (context) => FirstOboardingRoute());
              } else if (_secondCheckValue) {
                route = MaterialPageRoute(
                    builder: (context) => SecondOboardingRoute());
              } else if (_thirdCheckValue) {
                route = MaterialPageRoute(
                    builder: (context) => ThirdOboardingRoute());
              }
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CheckboxListTile(
                      title: Text(OnboardingStep.ONE.toString()),
                      value: _firstCheckValue,
                      onChanged: (newValue) {
                        _bloc.inEvent.add(FirstCheckEvent(newValue));
                      },
                    ),
                    CheckboxListTile(
                      title: Text(OnboardingStep.TWO.toString()),
                      value: _secondCheckValue,
                      onChanged: (newValue) {
                        _bloc.inEvent.add(SecondCheckEvent(newValue));
                      },
                    ),
                    CheckboxListTile(
                      title: Text(OnboardingStep.THREE.toString()),
                      value: _thirdCheckValue,
                      onChanged: (newValue) {
                        _bloc.inEvent.add(ThirdCheckEvent(newValue));
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(context, route);
                        },
                        child: Text("Start"))
                  ]);
            }),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
