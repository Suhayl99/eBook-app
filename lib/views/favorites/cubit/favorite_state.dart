part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
   FavoriteState({
    required this.posts
  });

  final List posts;

  @override
  List<Object> get props => [posts];
}

