import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderImage extends StatefulWidget {
  final List<String> img;
  final int imgLength;

  const SliderImage({Key key, this.img, this.imgLength}) : super(key: key);
  @override
  _SliderImageState createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImage> {
  CarouselController _controller = CarouselController();

  int _changeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: screenSize.height * 0.25,
          width: screenSize.width,
          color: Colors.grey,
          child: CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              onPageChanged: (val, reason) {
                setState(() {
                  _changeIndex = val;
                });
              },
              viewportFraction: 1.0,
              height: screenSize.height * 0.25,

              enlargeCenterPage: false,
              // autoPlay: false,
            ),
            items: widget.img
                .map((item) => Container(
                      child: Center(
                          child: Image.asset(
                        item,
                        fit: BoxFit.cover,
                        width: screenSize.width,
                        height: screenSize.height * 0.25,
                      )),
                    ))
                .toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              widget.imgLength,
              (index) => Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: CircleAvatar(
                      radius: 5,
                      backgroundColor:
                          _changeIndex == index ? Colors.black : Colors.grey,
                    ),
                  )),
        )
      ],
    );
  }
}
