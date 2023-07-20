import 'package:bloc/bloc.dart';
import 'package:coffee_order_app/repositories/models/models.dart';
import 'package:coffee_order_app/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'rewards_state.dart';

class RewardsCubit extends Cubit<RewardsState> {
  RewardsCubit(this._applicationRepository)
      : super(RewardsFullState(
          currentUser: _applicationRepository.currentUser,
          rewards: _applicationRepository.rewards,
          clicked: _applicationRepository.clicked
        ));

  final ApplicationRepository _applicationRepository;

  void claimReward(Reward reward) {
    _applicationRepository.claimReward(reward);
    emit(RewardsFullState(
      currentUser: _applicationRepository.currentUser,
      rewards: _applicationRepository.rewards,
      clicked: _applicationRepository.clicked
    ));
  }

  void levelUp() {
    _applicationRepository.levelUp();
    emit(RewardsFullState(
      currentUser: _applicationRepository.currentUser,
      rewards: _applicationRepository.rewards,
      clicked: _applicationRepository.clicked
    ));
  }
}
