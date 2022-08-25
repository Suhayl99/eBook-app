import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ebook_app/components/body_builder.dart';
import 'package:flutter_ebook_app/components/book_list_item.dart';
import 'package:flutter_ebook_app/components/loading_widget.dart';
import 'package:flutter_ebook_app/models/category.dart';
import 'package:flutter_ebook_app/views/genre/cubit/genre_cubit.dart';
import 'package:provider/provider.dart';

class Genre extends StatefulWidget {
  final String title;
  final String url;

  Genre({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  _GenreState createState() => _GenreState();
}

class _GenreState extends State<Genre> {
  @override
  void initState() {
    super.initState();
   context.read<GenreCubit>().getFeed(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreCubit, GenreState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('${widget.title}'),
          ),
          body: _buildBody( state),
        );
      },
    );
  }

  Widget _buildBody(GenreState state) {
    return BodyBuilder(
      apiRequestStatus: state.apiRequestStatus,
      child: _buildBodyList(),
      reload: () => context.read<GenreCubit>().getFeed(widget.url),
    );
  }

  _buildBodyList() {
    return ListView(
      controller: context.watch<GenreCubit>().controller,
      children: <Widget>[
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          shrinkWrap: true,
          itemCount: context.watch<GenreCubit>().items.length,
          itemBuilder: (BuildContext context, int index) {
            Entry entry = context.watch<GenreCubit>().items[index];
            return Padding(
              padding: EdgeInsets.all(5.0),
              child: BookListItem(
                entry: entry,
              ),
            );
          },
        ),
        SizedBox(height: 10.0),
        context.watch<GenreCubit>().loadingMore
            ? Container(
                height: 80.0,
                child: _buildProgressIndicator(),
              )
            : SizedBox(),
      ],
    );
  }

  _buildProgressIndicator() {
    return LoadingWidget();
  }
}
