part of 'profile_view_bloc.dart';

abstract class ProfileViewState extends Equatable {
  const ProfileViewState({
    required this.currentUser,
  });

  final UserModel currentUser;
  @override
  List<Object> get props => [currentUser];
}

class ProfileViewFullState extends ProfileViewState {
  const ProfileViewFullState({
    required super.currentUser,
  });
}
