part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();
  @override
  List<Object?> get props => [];
}

class SplashScreen extends NavigationState {
  const SplashScreen();
}

class HomePage extends NavigationState {
  const HomePage();
}

class Details extends NavigationState {
  const Details();
}

class MyCart extends NavigationState {
  const MyCart();
}

class OrderSuccess extends NavigationState {
  const OrderSuccess();
}

class Profile extends NavigationState {
  const Profile();
}

class Rewards extends NavigationState {
  const Rewards();
}

class RedeeemRewards extends NavigationState {
  const RedeeemRewards();
}

class MyOrder extends NavigationState {
  const MyOrder();
}
