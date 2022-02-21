import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/products_controller.dart';

import '../../cons.dart';

class BottomNavigationMain extends StatelessWidget {
  ProductsController _productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsController>(
      builder: (_) => Container(
        height: 65,
        child: BottomAppBar(
          color: Cons.primary_color,
          child: new Theme(
            data: Theme.of(context).copyWith(
                canvasColor: Colors.blueGrey.shade500,
                primaryColor: Colors.red,
                textTheme: Theme.of(context)
                    .textTheme
                    .copyWith(caption: new TextStyle(color: Colors.yellow))),
            // sets the inactive color of the `BottomNavigationBar`
            child: new BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _productController.selectedTabIndex,
              selectedItemColor: Cons.primary_color,
              onTap: (ind) {
                _productController.changeSelectedTab(ind);
                _productController.update();
                print('.....   ' +
                    _productController.selectedTabIndex.toString());
              },
              items: [
                new BottomNavigationBarItem(
                    icon: new Icon(
                      Icons.more_horiz,
                      color: checkBottomColor(0),
                    ),
                    label: 'all'.tr,
                    // title: new Text('all'.tr,
                    //     style: TextStyle(
                    //       color: checkBottomColor(0),
                    //     )
                 //   )
        ),
                new BottomNavigationBarItem(
                  icon: new Icon(Icons.watch_outlined,
                      color: checkBottomColor(1)),
                 // title: new Text('watch'.tr,
                   //   style: TextStyle(color: checkBottomColor(1))),
                ),
                new BottomNavigationBarItem(
                  icon: new Icon(Icons.stream, color: checkBottomColor(2)),
                  label: 'braclete'.tr,
                  // title: new Text('braclete'.tr,
                  //     style: TextStyle(color: checkBottomColor(2))),
                ),
                new BottomNavigationBarItem(
                  icon: new Icon(Icons.shop, color: checkBottomColor(3)),
                  //title: new Text('stores'.tr,
                   //   style: TextStyle(color: checkBottomColor(3))),
                ),
              ],
            ),
          ),
          shape: CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          notchMargin: 6.0,
        ),
      ),
    );
  }


  checkBottomColor(int index) {
    return _productController.selectedTabIndex == index
        ? Cons.primary_color
        : Colors.white;
  }
}
