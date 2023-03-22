import 'package:app_redes_sociais/controllers/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

class CarouselPage extends StatelessWidget {
  MainController controller = Get.put(MainController());

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrousel'),
      ),
      body: Column(
        children: [_carousel(), _indicator()],
      ),
    );
  }

  Widget _carousel() {
    return CarouselSlider(
      carouselController: _controller,
      options: CarouselOptions(
        height: 400,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        //enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: (int idx, __) {
          _current = idx;
          controller.update();
        },
        scrollDirection: Axis.horizontal,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Container(
            width: MediaQuery.of(Get.context!).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(color: Colors.amber),
            child: Text(
              'text $i',
              style: TextStyle(fontSize: 16.0),
            ));
      }).toList(),
    );
  }

  Widget _indicator() {
    return GetBuilder<MainController>(builder: (context) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [1, 2, 3, 4, 5].asMap().entries.map((entry) {
            return Container(
              width: 12.0,
              height: 12.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(Get.context!).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                      .withOpacity(_current == entry.key ? 0.9 : 0.4)),
            );
          }).toList());
    });
  }
}
