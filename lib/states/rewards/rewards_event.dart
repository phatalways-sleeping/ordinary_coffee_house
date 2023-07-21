part of 'rewards_bloc.dart';

abstract class RewardsEvent extends Equatable {
  const RewardsEvent();

  @override
  List<Object> get props => [];
}


class ClaimReward extends RewardsEvent {
  const ClaimReward(this.reward);

  final RewardBase reward;

  @override
  List<Object> get props => [reward];
}

class ViewDrink extends RewardsEvent {
  const ViewDrink();
}

class ViewFreeship extends RewardsEvent {
  const ViewFreeship();
}

class ViewDiscount extends RewardsEvent {
  const ViewDiscount();
}

class LevelUp extends RewardsEvent {
  const LevelUp();
}