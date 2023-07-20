part of 'rewards_cubit.dart';

abstract class RewardsState extends Equatable {
  const RewardsState({
    required this.currentUser,
    required this.rewards,
    required this.clicked,
  });
  final UserModel currentUser;
  final List<Reward> rewards;
  final bool clicked;

  @override
  List<Object> get props => [currentUser, rewards, clicked];
}

class RewardsFullState extends RewardsState {
  const RewardsFullState({
    required super.currentUser,
    required super.rewards,
    required super.clicked,
  });
}
