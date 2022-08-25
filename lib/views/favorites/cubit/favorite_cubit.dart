import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../database/favorite_helper.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteState(posts: []));

  bool loading = true;
  var db = FavoriteDB();

  getFavorites() async {
    setLoading(true);
    emit(FavoriteState(posts: []));
    List all = await db.listAll();
    emit(FavoriteState(posts:all));
    setLoading(false);
  }

  void setLoading(value) {
    loading = value;
  }

}
