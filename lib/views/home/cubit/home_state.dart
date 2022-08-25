part of 'home_cubit.dart';

 class HomeState extends Equatable {
  const HomeState({
    required this.apiRequestStatus,
  });

   final APIRequestStatus apiRequestStatus ;
   
     @override
     List<Object?> get props => [apiRequestStatus];
}


