import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ebook_app/util/consts.dart';
import 'package:flutter_ebook_app/theme/theme_config.dart';
import 'package:flutter_ebook_app/views/cubit/main_cubit.dart';
import 'package:flutter_ebook_app/views/details/cubit/detail_cubit.dart';
import 'package:flutter_ebook_app/views/favorites/cubit/favorite_cubit.dart';
import 'package:flutter_ebook_app/views/genre/cubit/genre_cubit.dart';
import 'package:flutter_ebook_app/views/home/cubit/home_cubit.dart';
import 'package:flutter_ebook_app/views/splash/splash.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => AppProvider()),
        // ChangeNotifierProvider(create: (_) => HomeProvider()),
        // ChangeNotifierProvider(create: (_) => DetailsProvider()),
        // ChangeNotifierProvider(create: (_) => FavoritesProvider()),
        // ChangeNotifierProvider(create: (_) => GenreProvider()),
        BlocProvider<HomeCubit>(create: (context) => HomeCubit(),),
        BlocProvider<MainCubit>(create: (context) => MainCubit(),),
        BlocProvider<DetailCubit>(create: (context) => DetailCubit(),),
        BlocProvider<FavoriteCubit>(create: (context) => FavoriteCubit(),),
        BlocProvider<GenreCubit>(create: (context) => GenreCubit(),),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return MaterialApp(
          key: state.key,
          debugShowCheckedModeBanner: false,
          navigatorKey: state.navigatorKey,
          title: Constants.appName,
          theme: themeData(state.theme),
          darkTheme: themeData(ThemeConfig.darkTheme),
          home: Splash(),
        );
      },
    );
  }

  // Apply font to our app's theme
  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.sourceSansProTextTheme(
        theme.textTheme,
      ),
      colorScheme: theme.colorScheme.copyWith(
        secondary: ThemeConfig.lightAccent,
      ),
    );
  }
}
