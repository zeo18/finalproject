part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ToggleTheme extends ThemeEvent {
  final bool isDarkTheme;

  const ToggleTheme({required this.isDarkTheme});

  @override
  List<Object> get props => [isDarkTheme];
}
