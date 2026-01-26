import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _waveController;
  late final Animation<double> _waveFade;
  late final Animation<Offset> _waveSlideX;
  late final Animation<double> _waveScale;

  @override
  void initState() {
    super.initState();

    _waveController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));

    _waveFade = CurvedAnimation(parent: _waveController, curve: Curves.easeOut);

    _waveSlideX = Tween<Offset>(
      begin: const Offset(-0.05, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _waveController, curve: Curves.easeOutCubic));

    _waveScale = Tween<double>(
      begin: 0.98,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _waveController, curve: Curves.easeOut));

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _waveController.forward();
    });
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(child: Image.asset('assets/images/splash_logo.png', width: 400, fit: BoxFit.contain)),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: FadeTransition(
              opacity: _waveFade,
              child: SlideTransition(
                position: _waveSlideX,
                child: ScaleTransition(
                  scale: _waveScale,
                  child: Image.asset('assets/images/splash_wave.png', height: 200, fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
