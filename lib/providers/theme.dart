import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_in/mocks/theme.dart';

class ThemeChangeProvider {
  Future<AppTheme> getTheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    AppTheme theme = AppTheme.BlueLight;
    print(preferences);
    if (preferences.getString("theme") == null || preferences.getString("theme") == "") {
      theme = AppTheme.BlueLight;
    } else {
      String prefData = preferences.getString("theme");
      if (prefData == 'BlueLight') {
        theme = AppTheme.BlueLight;
      } else if (prefData == 'BlueDark') {
        theme = AppTheme.BlueDark;
      } else if (prefData == 'GreenLight') {
        theme = AppTheme.GreenLight;
      } else if (prefData == 'GreenDark') {
        theme = AppTheme.GreenDark;
      }
    }
    return theme;
  }

  setTheme(theme) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('theme', theme);
    return theme;
  }
}