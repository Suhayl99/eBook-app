import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ebook_app/util/api.dart';
import 'package:flutter_ebook_app/util/enum/api_request_status.dart';
import '../../../models/category.dart';
import '../../../util/functions.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState(apiRequestStatus: APIRequestStatus.loading));

  CategoryFeed top = CategoryFeed();
  CategoryFeed recent = CategoryFeed();

  getFeeds() async {
      emit(HomeState(apiRequestStatus: APIRequestStatus.loading));
    try {
      CategoryFeed popular = await Api().getCategory(Api.popular);
      top=popular;
      CategoryFeed newReleases = await Api().getCategory(Api.recent);
      recent=newReleases;
      emit(HomeState(apiRequestStatus:APIRequestStatus.loaded));
    } catch (e) {
     if (Functions.checkConnectionError(e)) {
      emit(HomeState(apiRequestStatus: APIRequestStatus.connectionError));
    } else {
      emit(HomeState(apiRequestStatus: APIRequestStatus.error));
    }
    }
  }

}

