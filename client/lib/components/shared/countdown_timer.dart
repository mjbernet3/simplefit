import 'dart:async';
import 'package:client/components/shared/app_icon_button.dart';
import 'package:client/components/shared/rounded_button.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/formatter.dart';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  final int totalSeconds;
  final int maxSeconds;
  final Function onChanged;
  final Function onComplete;

  CountdownTimer({
    @required this.totalSeconds,
    @required this.maxSeconds,
    this.onChanged,
    this.onComplete,
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
    _startingTime = widget.totalSeconds;
    _currentTime = _startingTime;
    _stopwatch = Stopwatch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
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
                  style: const TextStyle(fontSize: 56.0),
                ),
                const SizedBox(width: 5.0),
                !_isStarted
                    ? Column(
                        children: [
                          AppIconButton(
                            icon: const Icon(Icons.add),
                            color: Constants.secondElevation,
                            padding: const EdgeInsets.all(4.0),
                            onPressed: _increment,
                          ),
                          const SizedBox(height: 10.0),
                          AppIconButton(
                            icon: const Icon(Icons.remove),
                            color: Constants.secondElevation,
                            padding: const EdgeInsets.all(4.0),
                            onPressed: _decrement,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: 15.0),
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
                const SizedBox(width: 10.0),
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
      ),
    );
  }

  void _increment() {
    if (_startingTime + 1 <= widget.maxSeconds) {
      setState(
        () => {
          _startingTime += 1,
          _currentTime = _startingTime,
        },
      );
      widget.onChanged(_startingTime);
    }
  }

  void _decrement() {
    if (_startingTime - 1 >= 0) {
      setState(
        () => {
          _startingTime -= 1,
          _currentTime = _startingTime,
        },
      );
      widget.onChanged(_startingTime);
    }
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
