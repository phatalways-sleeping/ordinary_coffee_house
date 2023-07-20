part of 'order_view_bloc.dart';

abstract class OrderViewEvent extends Equatable {
  const OrderViewEvent();

  @override
  List<Object> get props => [];
}

class ChangeView extends OrderViewEvent {
  const ChangeView(this.viewOnGoing);

  final bool viewOnGoing;

  @override
  List<Object> get props => [viewOnGoing];
}
