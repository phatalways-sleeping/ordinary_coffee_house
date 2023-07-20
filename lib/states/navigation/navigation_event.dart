part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object?> get props => [];
}

class NavigateBackFromDetailsView extends NavigationEvent {
  const NavigateBackFromDetailsView();
}

class NavigateBackFromCartView extends NavigationEvent {
  const NavigateBackFromCartView();
}

class NavigateToSplashScreen extends NavigationEvent {
  const NavigateToSplashScreen();
}

class NavigateToHomePage extends NavigationEvent {
  const NavigateToHomePage();
}

class NavigateToDetails extends NavigationEvent {
  const NavigateToDetails();
}

class NavigateToMyCart extends NavigationEvent {
  const NavigateToMyCart();
}

class NavigateToOrderSuccess extends NavigationEvent {
  const NavigateToOrderSuccess();
}

class NavigateToProfile extends NavigationEvent {
  const NavigateToProfile();
}

class NavigateToRewards extends NavigationEvent {
  const NavigateToRewards();
}

class NavigateToRedeeemRewards extends NavigationEvent {
  const NavigateToRedeeemRewards();
}

class NavigateToMyOrder extends NavigationEvent {
  const NavigateToMyOrder();
}
