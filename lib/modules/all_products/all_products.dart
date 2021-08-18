import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopin/components/components/components.dart';
import 'package:shopin/components/constant/constant.dart';
import 'package:shopin/modules/product_screen/product_screen.dart';
import 'package:shopin/shared/bloc/app_bloc/app_bloc.dart';
import 'package:shopin/shared/bloc/app_bloc/app_states.dart';
import 'package:shopin/style/colors.dart';
import 'package:shopin/style/fonts.dart';

class AllProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = AppCubit.get(context);

        if (productsModel == null) {
          return Center(child: CircularProgressIndicator());
        } else
        return StaggeredGridView.countBuilder(
          physics: BouncingScrollPhysics(),
          crossAxisCount: 4,
          itemCount: productsModel!.data.data.length,
          itemBuilder: (BuildContext context, int index) {

            var products = productsModel!.data.data[index];

            return Stack(
              alignment: Alignment.topRight,
              children: [
                InkWell(
                  onTap: () {
                    navigateTo(
                      context,
                      ProductScreen(
                        products,
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CachedNetworkImage(
                              imageUrl: products.image,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              products.name,
                              maxLines: 1,
                              style: tajawal.copyWith(
                                  fontSize: size.width / 24,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                products.price.toString(),
                                style: tajawal.copyWith(
                                    fontSize: size.width / 28,
                                    fontWeight: FontWeight.bold,
                                    color: mainColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              if (products.discount > 0)
                                Text(
                                  products.oldPrice.toString(),
                                  style: TextStyle(
                                      fontSize: size.width / 36,
                                      color: Colors.grey[700],
                                      decoration: TextDecoration.lineThrough,
                                      decorationColor: Colors.red,
                                      decorationThickness: 2),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    cubit.setFavorites(product: products);
                  },
                  icon: Icon(
                    Icons.favorite,
                    color:
                        products.inFavorites ? Colors.red : Colors.grey,
                  ),
                ),
                if (products.discount > 0)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: DiscountContainer(
                        size, products.discount, false),
                  )
              ],
            );
          },
          staggeredTileBuilder: (int index) => StaggeredTile.count(2, 2),
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
        );
      },
    );
  }
}
