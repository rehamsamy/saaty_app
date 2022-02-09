
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saaty_app/model/product_model.dart';

import '../../cons.dart';

class CareselProductSlider extends StatefulWidget {
  Product product;

  CareselProductSlider(this.product);

  @override
  _CareselProductSliderState createState() => _CareselProductSliderState();
}

class _CareselProductSliderState extends State<CareselProductSlider> {
  CarouselController buttonCarouselController = CarouselController();
  int _index=0;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: buttonCarouselController,
      options: CarouselOptions(
          onPageChanged: (ind, x) {
            setState(() {
              _index = ind;
            });
          },
          initialPage: 1,
          autoPlayAnimationDuration: Duration(milliseconds: 400),
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 9 / 8,
          //viewportFraction: 0.81,
          viewportFraction: 2),
      items: widget.product.images
          .map((e) => Stack(children: [
        Center(
            child: Image.network(
              e,
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width,
              height:  MediaQuery.of(context).size.height,
            )),
        Positioned(
          left: 0,
          right: 0,
          bottom: 5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildCircleSlider(0),
              buildCircleSlider(1),
              buildCircleSlider(2),
              buildCircleSlider(3),
            ],
          ),
        ),
      ]))
          .toList(),
    );
  }


  Widget buildCircleSlider(int index) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 12,
        width: 12,
        decoration: BoxDecoration(
            border: index == _index
                ? Border.all(width: 2, color: Cons.primary_color)
                : Border.all(width: 1, color: Cons.primary_color),
            shape: BoxShape.circle,
            color: _index == index ? Colors.white : Cons.accent_color),
      ),
    );
  }


}


