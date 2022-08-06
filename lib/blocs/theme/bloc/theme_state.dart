part of 'theme_bloc.dart';

class ThemeState extends Equatable {
  final bool isDarkTheme;
  const ThemeState({this.isDarkTheme = false});

  @override
  List<Object> get props => [isDarkTheme];
  Map<String, dynamic> toMap() {
    return {
      'isDarkTheme': isDarkTheme,
    };
  }

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(isDarkTheme: map['isDarkTheme'] ?? false);
  }
}
