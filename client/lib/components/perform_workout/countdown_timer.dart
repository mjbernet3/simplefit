import 'dart:async';
import 'package:client/components/shared/app_icon_button.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/formatter.dart';
import 'package:flutter/material.dart';

// TODO: Add max and min so stat does not adjust incorrectly
class CountdownTimer extends StatefulWidget {
  final int totalSeconds;
  final Function onChanged;
  final Function onComplete;

  CountdownTimer({
    @required this.totalSeconds,
    @required this.onChanged,
    @required this.onComplete,
  });

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int _startingTime;
  int _currentTime;
  int _delay = 1;
  Stopwatch _stopwatch;
  Timer _timer;
  bool _isStarted = false;

  @override
  void initState() {
    super.initState();
    _startingTime = widget.totalSeconds;
    _currentTime = _startingTime;
    _stopwatch = Stopwatch();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.firstElevation,
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: !_isStarted
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              Text(
                Formatter.secondsToTime(_currentTime),
                style: TextStyle(fontSize: 56.0),
              ),
              SizedBox(width: 5.0),
              !_isStarted
                  ? Column(
                      children: [
                        AppIconButton(
                          icon: Icon(Icons.add),
                          color: Constants.secondElevation,
                          padding: EdgeInsets.all(4.0),
                          onPressed: () => {
                            setState(
                              () => {
                                _startingTime += 1,
                                _currentTime = _startingTime,
                              },
                            ),
                            widget.onChanged(_startingTime),
                          },
                        ),
                        SizedBox(height: 10.0),
                        AppIconButton(
                          icon: Icon(Icons.remove),
                          color: Constants.secondElevation,
                          padding: EdgeInsets.all(4.0),
                          onPressed: () => {
                            setState(
                              () => {
                                _startingTime -= 1,
                                _currentTime = _startingTime,
                              },
                            ),
                            widget.onChanged(_startingTime),
                          },
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: RoundedButton(
                  height: 30.0,
                  buttonText: 'Reset',
                  color: Constants.secondElevation,
                  onPressed: _resetTimer,
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: RoundedButton(
                  height: 30.0,
                  buttonText: !_stopwatch.isRunning ? 'Start' : 'Stop',
                  color: Constants.secondElevation,
                  onPressed: _toggleTimer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleTimer() {
    if (_stopwatch.isRunning) {
      _stopTimer();
      setState(() =>
          _currentTime = _startingTime - _stopwatch.elapsed.inSeconds + _delay);
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    if (_currentTime >= _delay) {
      _isStarted = true;
      _stopwatch.start();
      _timer = Timer.periodic(Duration(seconds: 1), _updateTime);
    }
  }

  void _updateTime(Timer timer) {
    if (_stopwatch.isRunning) {
      if (_currentTime < _delay) {
        _stopTimer();
        setState(() => _currentTime = 0);
        widget.onComplete();
      } else {
        setState(() => _currentTime =
            _startingTime - _stopwatch.elapsed.inSeconds + _delay);
      }
    }
  }

  void _stopTimer() {
    _stopwatch.stop();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void _resetTimer() {
    _stopTimer();
    _stopwatch.reset();
    setState(
      () => {
        _currentTime = _startingTime,
        _isStarted = false,
      },
    );
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}
