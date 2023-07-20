part of 'profile_view_bloc.dart';

abstract class ProfileViewEvent extends Equatable {
  const ProfileViewEvent();

  @override
  List<Object> get props => [];
}

class ChangeUsername extends ProfileViewEvent {
  const ChangeUsername(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class ChangePhoneNumber extends ProfileViewEvent {
  const ChangePhoneNumber(this.phoneNumber);

  final String phoneNumber;

  @override
  List<Object> get props => [phoneNumber];
}

class ChangeEmail extends ProfileViewEvent {
  const ChangeEmail(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class ChangeAddress extends ProfileViewEvent {
  const ChangeAddress(this.address);

  final String address;

  @override
  List<Object> get props => [address];
}
