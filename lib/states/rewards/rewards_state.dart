part of 'rewards_bloc.dart';


enum VouchersEvent {
  viewDrink,
  viewFreeship,
  viewDiscount,
  levelUp,
}

abstract class RewardsState extends Equatable {
  const RewardsState({
    required this.currentUser,
    required this.rewards,
    required this.clicked,
    required this.event,
  });
  final UserModel currentUser;
  final List<RewardBase> rewards;
  final bool clicked;
  final VouchersEvent event;

  @override
  List<Object> get props => [currentUser, rewards, clicked, event];
}

class RewardsFullState extends RewardsState {
  const RewardsFullState({
    required super.currentUser,
    required super.rewards,
    required super.clicked,
    required super.event,
  });
}
