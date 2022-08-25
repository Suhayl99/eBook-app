part of 'genre_cubit.dart';

class GenreState extends Equatable {
 GenreState({
  required this.apiRequestStatus
 });

  final APIRequestStatus apiRequestStatus;

  @override
  List<Object> get props => [apiRequestStatus];
}
