import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blinking Heart App',
      home: BlinkingHeart(),
    );
  }
}

class BlinkingHeart extends StatefulWidget {
  @override
  _BlinkingHeartState createState() => _BlinkingHeartState();
}

class _BlinkingHeartState extends State<BlinkingHeart>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _animation;
  late AudioPlayer _audioCache;

  bool _showLoveMessage = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000), // Change duration if needed
    )..repeat(reverse: true);

    _animation = ColorTween(begin: Colors.transparent, end: Colors.red)
        .animate(_controller);

    _audioCache = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blinking Heart'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () async {
            setState(() {
              _showLoveMessage = !_showLoveMessage;
            });
           // await _audioCache.play('iloveyou.mp3'); // Play sound on tap
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 100.0,
                  ),
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Icon(
                        Icons.favorite,
                        color: _animation.value,
                        size: 100.0,
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (_showLoveMessage)
                Text(
                  'I love you',
                  style: TextStyle(fontSize: 24),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
