import 'package:coffee_order_app/components/coffee_productview.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselRewardsView extends StatefulWidget {
  const CarouselRewardsView({
    super.key,
    required this.rewards,
  });

  final List<CoffeeProductView> rewards;
  @override
  State<CarouselRewardsView> createState() => _CarouselRewardsViewState();
}

class _CarouselRewardsViewState extends State<CarouselRewardsView> {
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),
      child: CarouselSlider(
        items: widget.rewards,
        options: CarouselOptions(
          aspectRatio: 2,
          viewportFraction: 0.4,
          initialPage: 0,
          enableInfiniteScroll: true,
          enlargeFactor: 0.25,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
        carouselController: buttonCarouselController,
      ),
    );
  }
}
