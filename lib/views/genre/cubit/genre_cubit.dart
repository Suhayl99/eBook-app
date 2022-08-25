import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/util/enum/api_request_status.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../models/category.dart';
import '../../../util/api.dart';
import '../../../util/functions.dart';

part 'genre_state.dart';

class GenreCubit extends Cubit<GenreState> {
  GenreCubit() : super(GenreState(apiRequestStatus: APIRequestStatus.loading));

   ScrollController controller = ScrollController();
  List items = [];
  int page = 1;
  bool loadingMore = false;
  bool loadMore = true;
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;

  listener(url) {
  
  }

  getFeed(String url) async {
    emit(GenreState(apiRequestStatus: APIRequestStatus.loading));
    try {
      CategoryFeed feed = await Api().getCategory(url);
      items = feed.feed!.entry!;
      emit(GenreState(apiRequestStatus: APIRequestStatus.loaded));
          controller.addListener(() async {
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        if (!loadingMore) {
          if (apiRequestStatus != APIRequestStatus.loading &&
        !loadingMore &&
        loadMore) {
      Timer(Duration(milliseconds: 100), () {
        controller.jumpTo(controller.position.maxScrollExtent);
      });
      loadingMore = true;
      page = page + 1;
      try {
        CategoryFeed feed = await Api().getCategory(url + '&page=$page');
        items.addAll(feed.feed!.entry!);
        loadingMore = false;
      } catch (e) {
        loadMore = false;
        loadingMore = false;
        throw (e);
      }
    }
          // Animate to bottom of list
          Timer(Duration(milliseconds: 100), () {
            controller.animateTo(
              controller.position.maxScrollExtent,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeIn,
            );
          });
        }
      }
    });
    } catch (e) {
        if (Functions.checkConnectionError(e)) {
        emit(GenreState(apiRequestStatus:  APIRequestStatus.connectionError));
      showToast('Connection error');
    } else {
        emit(GenreState(apiRequestStatus: APIRequestStatus.error));
      showToast('Something went wrong, please try again');
    }
    }  
  }

  showToast(msg) {
    Fluttertoast.showToast(
      msg: '$msg',
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
    );
  }

  }