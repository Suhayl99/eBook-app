part of 'detail_cubit.dart';

 class DetailState extends Equatable {
   DetailState({
    required this.faved
   });

final bool faved;

@override
  List<Object> get props => [faved];
}



