import 'package:bloc/bloc.dart';
import 'package:coffee_order_app/repositories/app_repository.dart';
import 'package:coffee_order_app/models/reward.dart';
import 'package:coffee_order_app/models/user_model.dart';
import 'package:equatable/equatable.dart';

part 'rewards_event.dart';
part 'rewards_state.dart';

class RewardsBloc extends Bloc<RewardsEvent, RewardsState> {
  RewardsBloc(this._applicationRepository)
      : super(
          RewardsFullState(
            currentUser: _applicationRepository.currentUser,
            rewards: _applicationRepository.rewards,
            clicked: _applicationRepository.clicked,
            event: VouchersEvent.viewDrink,
          ),
        ) {
    on<ClaimReward>((event, emit) {
      _applicationRepository.claimReward(event.reward);
      emit(RewardsFullState(
        currentUser: _applicationRepository.currentUser,
        rewards: _applicationRepository.rewards,
        clicked: _applicationRepository.clicked,
        event: state.event,
      ));
    });

    on<LevelUp>((event, emit) {
      _applicationRepository.levelUp();
      emit(RewardsFullState(
        currentUser: _applicationRepository.currentUser,
        rewards: _applicationRepository.rewards,
        clicked: _applicationRepository.clicked,
        event: VouchersEvent.levelUp,
      ));
    });

    on<ViewDrink>((event, emit) {
      emit(RewardsFullState(
        currentUser: _applicationRepository.currentUser,
        rewards: _applicationRepository.rewards,
        clicked: _applicationRepository.clicked,
        event: VouchersEvent.viewDrink,
      ));
    });

    on<ViewFreeship>((event, emit) {
      emit(RewardsFullState(
        currentUser: _applicationRepository.currentUser,
        rewards: _applicationRepository.rewards,
        clicked: _applicationRepository.clicked,
        event: VouchersEvent.viewFreeship,
      ));
    });

    on<ViewDiscount>((event, emit) {
      emit(RewardsFullState(
        currentUser: _applicationRepository.currentUser,
        rewards: _applicationRepository.rewards,
        clicked: _applicationRepository.clicked,
        event: VouchersEvent.viewDiscount,
      ));
    });
  }

  final ApplicationRepository _applicationRepository;
}
