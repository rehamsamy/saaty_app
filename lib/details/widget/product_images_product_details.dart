import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saaty_app/model/product_model.dart';
import 'package:saaty_app/providers/product_controller.dart';
import 'package:saaty_app/providers/storage_controller.dart';

import '../../cons.dart';

class ContainerProductImages extends StatelessWidget {
 Product product;

 ContainerProductImages(this.product);
 ProductController _productController=Get.find();
 CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Cons.primary_color)),
        child: Stack(
          children: [
            ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: product.images.length,
                itemBuilder: (_, indx) {
                  return Container(
                      margin: EdgeInsets.all(2),
                      child: SizedBox(
                          height: 65,
                          width: 55,
                          child: Image.network(
                            product.images[indx],
                            scale: 1,
                            fit: BoxFit.cover,
                          )));
                }),
            Align(
              alignment:StorageController.isArabicLanguage? Alignment.centerLeft:Alignment.centerRight,
              child: Container(
                height: 90,
                width: 65,
                color: Cons.accent_color,
                child: Center(
                  child: Container(
                    child: InkWell(
                      onTap: () {
                        showImageDialog(context, product);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            product.images.length.toString(),
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          Icon(
                            Icons.photo_camera,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }



 void showImageDialog(BuildContext context, Product product) {
   showDialog(context: context, builder: (ctx){
     return AlertDialog(
       content: Container(
         height: MediaQuery.of(ctx).size.height*0.7,
         margin: EdgeInsets.symmetric(vertical: 0,horizontal: 0),
         width: double.infinity,
         child:
         Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             buildCarouselSlider(product,context)  ,
             SizedBox(height: 20,),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 for (int i =0;i<product.images.length;i++)
                   buildCircleSlider(i)
               ],
             )

           ],
         ),

       ),
     );
   });

 }


 Widget buildCircleSlider(int i){
   return GetBuilder<ProductController>(
     builder: (_)=>Padding(
       padding: const EdgeInsets.all(2.0),
       child: Container(
         height: 13,
         width: 13,
         decoration: BoxDecoration(
             border:i==_productController.sliderIndex? Border.all(width:2,color:Cons.accent_color ):Border.all(width:1,color:Cons.accent_color ),
             shape: BoxShape.circle,
             color:_productController.sliderIndex==i?Colors.white:Cons.primary_color
         ),
       ),
     ),
   );
 }


 Widget buildCarouselSlider(Product product,BuildContext context) {
   return
     Container(
       width: double.infinity,
       height: MediaQuery.of(context).size.height *.4,
       child:
       GetBuilder<ProductController>(
         builder: (_)=>
             CarouselSlider(
               carouselController:_carouselController,
               items: product.images.map((e) =>
                   Image.network(e,fit: BoxFit.fill,)
               ).toList(),
               options: CarouselOptions(
                   onPageChanged: (ind,x){
                     _productController.changeSliderImage(ind);
                     _productController.update();
                   },
                   initialPage: 1,
                   autoPlayAnimationDuration:Duration(milliseconds: 100),
                   autoPlay: true,
                   enlargeCenterPage: true,
                   aspectRatio: 9/6,
                   viewportFraction: 0.97
               ),),
       ),

     );
 }

}
