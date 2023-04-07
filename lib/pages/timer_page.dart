import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:audioplayers/audioplayers.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  final player = AudioPlayer();
  void playSound() {
    player.play(AssetSource('not1sec.wav'));
  }

  final int _duration = 10;
  final CountDownController _controller = CountDownController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countdown timer'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back')),
            CircularCountDownTimer(
              duration: _duration,
              initialDuration: 0,
              controller: _controller,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              ringColor: Colors.grey[300]!,
              ringGradient: null,
              fillColor: Colors.cyan,
              fillGradient: null,
              backgroundColor: Colors.amber[900],
              backgroundGradient: null,
              strokeWidth: 20.0,
              strokeCap: StrokeCap.round,

              // Text Style for Countdown Text.
              textStyle: const TextStyle(
                fontSize: 33.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),

              // Format for the Countdown Text.
              textFormat: CountdownTextFormat.S,
              isReverse: true,
              isReverseAnimation: true,
              isTimerTextShown: true,
              autoStart: true,

              onStart: () {
                debugPrint('Countdown Started');
              },

              onComplete: () {
                debugPrint('Countdown Ended');
              },

              onChange: (String timeStamp) {
                debugPrint('Countdown Changed $timeStamp');
              },

              timeFormatterFunction: (defaultFormatterFunction, duration) {
                if (duration.inSeconds == 0) {
                  // only format for '0'
                  return "Alarm raised";
                } else {
                  // other durations by it's default format
                  playSound();
                  return Function.apply(defaultFormatterFunction, [duration]);
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                // _controller.pause();
                _controller.pause();
              },
              child: const Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
