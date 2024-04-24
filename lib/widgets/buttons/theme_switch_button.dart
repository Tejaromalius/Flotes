import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flotes/common/themes.dart' show CustomThemes;

class ThemeSwitchButton extends StatefulWidget {
  const ThemeSwitchButton({super.key});

  @override
  _ThemeSwitchButtonState createState() => _ThemeSwitchButtonState();
}

class _ThemeSwitchButtonState extends State<ThemeSwitchButton> {
  @override
  Widget build(BuildContext context) {
    ThemeMode currentThemeMode = Get.find<CustomThemes>().currentThemeMode;
    return Container(
      width: double.infinity,
      child: FloatingActionButton(
        heroTag: UniqueKey(),
        onPressed: () async {
          await Get.find<CustomThemes>().changeThemeMode();
          setState(() {});
        },
        child: Stack(
          children: [
            Center(
              child: AnimatedOpacity(
                opacity: currentThemeMode == ThemeMode.system ? 1 : 0,
                duration: Duration(seconds: 1),
                curve: Curves.easeOutExpo,
                child: Text("System Mode"),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(seconds: 1),
              curve: Curves.easeOutQuad,
              alignment: currentThemeMode == ThemeMode.light
                  ? const Alignment(0.7, 0)
                  : const Alignment(-0.7, 0),
              child: AnimatedOpacity(
                opacity: currentThemeMode == ThemeMode.system ? 0 : 1,
                duration: const Duration(milliseconds: 250),
                child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 500),
                  firstCurve: Curves.linear,
                  secondCurve: Curves.linear,
                  firstChild: Text("Dark Mode"),
                  secondChild: Text("Light Mode"),
                  crossFadeState: currentThemeMode == ThemeMode.light
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                ),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(seconds: 1),
              curve: Curves.easeOutExpo,
              alignment: const Alignment(0.75, 0),
              child: AnimatedOpacity(
                opacity: currentThemeMode == ThemeMode.dark ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: Icon(Icons.dark_mode),
              ),
            ),
            AnimatedAlign(
              duration: const Duration(seconds: 1),
              curve: Curves.easeOutExpo,
              alignment: const Alignment(-0.75, 0),
              child: AnimatedOpacity(
                opacity: currentThemeMode == ThemeMode.light ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                child: Icon(Icons.light_mode),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
