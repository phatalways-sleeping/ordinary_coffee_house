import 'package:bloc/bloc.dart';
import 'package:coffee_order_app/models/models.dart';
import 'package:coffee_order_app/repositories/repositories.dart';
import 'package:equatable/equatable.dart';
part 'profile_view_event.dart';
part 'profile_view_state.dart';

class ProfileViewBloc extends Bloc<ProfileViewEvent, ProfileViewState> {
  ProfileViewBloc(this._applicationRepository)
      : super(ProfileViewFullState(
          currentUser: _applicationRepository.currentUser,
        )) {
    on<ChangeUsername>(
      (event, emit) async {
        await _applicationRepository.changeUsername(event.username);
        emit(ProfileViewFullState(
            currentUser: _applicationRepository.currentUser));
      },
    );
    on<ChangePhoneNumber>(
      (event, emit) async {
        await _applicationRepository.changePhoneNumber(event.phoneNumber);
        emit(ProfileViewFullState(
            currentUser: _applicationRepository.currentUser));
      },
    );
    on<ChangeEmail>(
      (event, emit) async {
        await _applicationRepository.changeEmail(event.email);
        emit(ProfileViewFullState(
            currentUser: _applicationRepository.currentUser));
      },
    );
    on<ChangeAddress>(
      (event, emit) async {
        await _applicationRepository.changeAddress(event.address);
        emit(ProfileViewFullState(
            currentUser: _applicationRepository.currentUser));
      },
    );
  }

  final ApplicationRepository _applicationRepository;
}
