import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLottieVisible = false;
  double lottiePosition = 0.0;
  Color filterColor = Colors.orange;
  bool isAnimationPaused = false;

  int selectedSpeedIndex = 2; // Index for controlling speed
  final List<double> animationSpeeds = [
    0.5,
    1.0,
    1.5,
    2.0
  ]; // Different animation speeds

  void changeLottieColor(Color color) {
    setState(() {
      filterColor = color;
    });
  }

  String getColorButtonText() {
    return filterColor == Colors.green
        ? 'Change Color to Orange'
        : 'Change Color to Green';
  }

  void changeAnimationSpeed(int index) {
    setState(() {
      selectedSpeedIndex = index;
    });
  }

  Future<void> pauseAnimation(Duration duration) async {
    setState(() {
      isAnimationPaused = true;
    });

    await Future.delayed(duration);

    setState(() {
      isAnimationPaused = false;
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Hello Hanyn'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLottieVisible = !isLottieVisible;
                  });
                },
                child: Text(isLottieVisible ? 'X' : '+'),
              ),
              
              if (isLottieVisible)
                GestureDetector(
                  onTap: () {
                    if (!isAnimationPaused) {
                      pauseAnimation(Duration(seconds: 3));
                    }
                  },
                  child: Transform.translate(
                    offset: Offset(lottiePosition, 0.0),
                    child: Lottie.asset(
                      'assets/json.json',
                      width: MediaQuery.of(context).size.width *
                          animationSpeeds[selectedSpeedIndex],
                      repeat: isAnimationPaused ? false : true,
                    ),
                  ),
                ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
}
