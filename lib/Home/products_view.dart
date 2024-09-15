
import 'package:elevate_task/Home/api_service.dart';
import 'package:elevate_task/Home/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ProductView extends StatefulWidget {
  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  late Future<List<Product>> Products;
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    Products = getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        leading: Icon(Icons.shopping_cart_outlined),
        title: Text('Online Shopping',style: TextStyle(fontSize:15.sp)),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Product>>(
        future: Products,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            categories = snapshot.data!.map((product) => product.category).toSet().toList();

            return DefaultTabController(
              length: categories.length,
              child: Column(
                children: [
                  TabBar(
                    unselectedLabelColor: Colors.indigo.withOpacity(0.5),
                    labelColor: Colors.indigo,
                    indicatorColor: Colors.indigo,

                    isScrollable: true,
                    tabs: categories.map((category) => Tab(text: category,),).toList(),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: categories.map((category) {

                        List<Product> categoryProducts = snapshot.data!
                            .where((product) => product.category == category)
                            .toList();

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(

                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 0.7,
                                crossAxisCount: 2,
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 10
                            ),
                            itemCount: categoryProducts.length,

                            itemBuilder:(context, index) {
                              return   Column
                                (
                                  children: [

                                    Container(
                                        child: Column(
                                          children: [
                                            Stack(
                                              alignment: Alignment.topRight,

                                              children: [
                                                Container(

                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight:Radius.circular(14),topLeft: Radius.circular(14)),
                                                  ),
                                                  child: Image.network(
                                                      height: 100.h,width: 173.w,
                                                      fit: BoxFit.fitWidth,
                                                      "${categoryProducts[index].image}"),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(

                                                      width:25.w,height: 25.h,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.white, boxShadow:[
                                                    BoxShadow(
                                                      color: Colors.grey.withOpacity(0.8),

                                                      spreadRadius:2.r,
                                                      blurRadius:15.r,
                                                    ),

                                                  ], ),child: Icon(Icons.favorite_border,color: Colors.indigo,size: 20,)),
                                                ),],)

                                            , Padding(
                                              padding: EdgeInsets.only(top:8.h,left: 4.w),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      maxLines: 1,
                                                      overflow:TextOverflow.fade,style: TextStyle(color:Colors.indigo[900],fontWeight: FontWeight.w500,fontSize:10.sp ),
                                                      "${categoryProducts[index].title}"),
                                                  Text(
                                                      maxLines: 1,
                                                      overflow:TextOverflow.ellipsis,style: TextStyle(color:Colors.indigo[900],fontWeight: FontWeight.w500,fontSize:10.sp),
                                                      "${categoryProducts[index].description}"),
                                                  SizedBox(height: 4,),
                                                  Row(
                                                    children: [
                                                      Text("${categoryProducts[index].price.toString()}",style: TextStyle(color:Colors.indigo[900],fontWeight: FontWeight.w500,fontSize:10.sp ),),
                                                      SizedBox(width:15,),
                                                      Text(

                                                        "1800 EGP ",style: TextStyle(decoration: TextDecoration.lineThrough,color:Colors.indigo[400],fontWeight: FontWeight.w400,fontSize:8.sp ),),
                                                    ],
                                                  ),

                                                  Row(
                                                    children: [  Text("Review ${categoryProducts[index].price}",style: TextStyle(color:Colors.indigo[900],fontWeight: FontWeight.w400,fontSize:9.sp ),),
                                                      SizedBox(width:5,),
                                                      Icon(Icons.star,color: Colors.yellow,size:16)
                                                      , Spacer(),
                                                      Padding(
                                                        padding:  EdgeInsets.only(right: 5.w),
                                                        child: Container(width:25.w,height: 25.h,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.indigo,),child: Icon(Icons.add,color: Colors.white,size:22,)),
                                                      ),

                                                    ],
                                                  )
                                                ],),
                                            )

                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.indigo.withOpacity(0.6),width:1.5.w),color: Colors.white,
                                            borderRadius: BorderRadius.circular(15.r)
                                        ),
                                        height:200.h,width:175.w)
                                  ]
                              );
                            },

                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }


          return Center(child: CircularProgressIndicator(color: Colors.indigo),);
        },
      ),
    );
  }
}