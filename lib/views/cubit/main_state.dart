part of 'main_cubit.dart';

 class MainState extends Equatable {
  const MainState({
    required this.key,
    required this.theme,
    required this.navigatorKey
  });

 final ThemeData theme;
 final Key key;
 final GlobalKey<NavigatorState> navigatorKey;

  @override
  List<Object> get props => [key, theme, navigatorKey];
  
}

