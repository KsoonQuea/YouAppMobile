import 'package:flutter/material.dart';

class MyThemeExtension extends ThemeExtension<MyThemeExtension> {
  final List<Color> gradientColors;

  const MyThemeExtension({required this.gradientColors});

  @override
  ThemeExtension<MyThemeExtension> copyWith({List<Color>? gradientColors}) {
    return MyThemeExtension(
      gradientColors: gradientColors ?? this.gradientColors,
    );
  }

  @override
  ThemeExtension<MyThemeExtension> lerp(ThemeExtension<MyThemeExtension>? other, double t) {
    if (other is! MyThemeExtension) {
      return this;
    }
    return MyThemeExtension(
      gradientColors: List.generate(
        gradientColors.length,
        (index) => Color.lerp(gradientColors[index], other.gradientColors[index], t)!,
      ),
    );
  }
}

// Reusable gradient background widget
class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeExtension = Theme.of(context).extension<MyThemeExtension>()!;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: themeExtension.gradientColors,
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: child,
    );
  }
}

// Reusable page scaffold with gradient background
class GradientScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const GradientScaffold({
    Key? key,
    required this.title,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GradientBackground(child: body),
    );
  }
}