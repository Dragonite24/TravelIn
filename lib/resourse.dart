import 'package:travel_in/mocks/theme.dart';
import 'package:travel_in/providers/theme_provider.dart';

class Resources {
  final themeGenerator = ThemeChangeProvider();

  Future<AppTheme> getTheme() => themeGenerator.getTheme();

  setTheme(theme) => themeGenerator.setTheme(theme);
}