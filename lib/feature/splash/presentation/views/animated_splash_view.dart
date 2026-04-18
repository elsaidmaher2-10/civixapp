import 'dart:async';

import 'package:citifix/core/database/local/prefmanger.dart';
import 'package:citifix/core/resource/assetvaluemanger.dart';
import 'package:citifix/core/resource/constantmanger.dart';
import 'package:citifix/core/routing/appRoutingRole.dart';
import 'package:citifix/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedSplashView extends StatefulWidget {
  const AnimatedSplashView({super.key});

  @override
  State<AnimatedSplashView> createState() => _AnimatedSplashViewState();
}

class _AnimatedSplashViewState extends State<AnimatedSplashView>
    with SingleTickerProviderStateMixin {
  /// Colors sampled from [assets/citiFixLogo.svg] fills.
  static const List<Color> _logoTitlePalette = [
    Color(0xFF1B3B69),
    Color(0xFF1A6CAE),
    Color(0xFFEF8627),
    Color(0xFF5AA552),
  ];

  late final AnimationController _controller;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2600),
    );
    _logoScale = Tween<double>(
      begin: 0.72,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.0, 0.42)),
    );

    _controller.forward();
    _navigationTimer = Timer(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, _resolveInitialRoute());
    });
  }

  Color _titleLetterColor(int index) =>
      _logoTitlePalette[index % _logoTitlePalette.length];

  double _letterReveal(int index, int total, double t) {
    if (total <= 0) return 0;
    final double span = 0.52 / total;
    final double start = 0.38 + index * span;
    return Interval(
      start,
      (start + span * 1.15).clamp(0.0, 1.0),
      curve: Curves.easeOutCubic,
    ).transform(t);
  }

  String _resolveInitialRoute() {
    final bool isOnboardingViewed =
        PrefrenceManager().getbool(Constantmanger.isOnboardingViewed) ?? false;
    final String? accessToken = PrefrenceManager().getstring(
      Constantmanger.accessToken,
    );
    final String? roleString = PrefrenceManager().getstring(
      Constantmanger.role,
    );

    if (!isOnboardingViewed) return Routes.onbroading;
    if (accessToken == null || accessToken.trim().isEmpty) return Routes.login;

    switch (AppRole.fromString(roleString)) {
      case AppRole.citizen:
        return Routes.citizenMain;
      case AppRole.worker:
        return Routes.workerMain;
      case AppRole.unknown:
        return Routes.login;
    }
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.ltr,

        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFFFFF), Color(0xFFF4F8FE)],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeTransition(
                    opacity: _logoOpacity,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: SvgPicture.asset(
                        AssetValueManager.Klog,
                        width: 140,
                        height: 140,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final String title = Constantmanger.apptitle;
                      final int n = title.length;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: List<Widget>.generate(n, (int i) {
                          final double reveal = _letterReveal(
                            i,
                            n,
                            _controller.value,
                          );
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: Opacity(
                              opacity: reveal,
                              child: Transform.translate(
                                offset: Offset(0, (1 - reveal) * 14),
                                child: Text(
                                  locale: Locale("en"),
                                  title[i],
                                  style: TextStyle(
                                    color: _titleLetterColor(i),
                                    fontSize: 34,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
