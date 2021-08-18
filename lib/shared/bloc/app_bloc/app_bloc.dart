import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopin/components/constant/constant.dart';
import 'package:shopin/components/constant/end_point.dart';
import 'package:shopin/models/shop_model/cart_model.dart';
import 'package:shopin/models/shop_model/categories_model.dart';
import 'package:shopin/models/shop_model/favorite_model.dart';
import 'package:shopin/models/shop_model/home_model.dart';
import 'package:shopin/models/shop_model/products_model.dart';
import 'package:shopin/models/user_model/user_model.dart';
import 'package:shopin/shared/network/remote/dio_helper.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int navBar = 0;
  int dotsPosition = 0;

  ///NavBar
  void navBarIndex(int index) {
    navBar = index;
    emit(AppNavBarState());
  }

  ///NavBar
  void dotsIndex(int index) {
    dotsPosition = index;
    emit(AppDotsState());
  }

  /// get all data
  void getData() async {
    emit(AppGetHomeDataLoadingState());
    await getHomeData().then(
        (value) => getCategoriesData().then((value) => getProductsData()));

    getUserData();
    getUserCart();
    getFavorites();
    emit(AppGetHomeDataSuccessState());
  }

  ///Get Home Data
  Future<void> getHomeData() async {
    return await DioHelper.getData(
      endPoint: HOME,
      token: token ?? '',
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
    }).catchError((onError) {
      emit(AppGetHomeDataErrorState(onError.toString()));
    });
  }

  ///Get Categories Data
  Future<void> getCategoriesData() async {
    await DioHelper.getData(
      endPoint: CATEGORIES,
      token: token ?? '',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
    }).catchError((onError) {
      emit(AppGetHomeDataErrorState(onError.toString()));
    });
  }

  ///Get Products Data
  Future<void> getProductsData() async {
    await DioHelper.getData(
      endPoint: PRODUCTS,
      token: token ?? '',
    ).then((value) {
      productsModel = ProductsModel.fromJson(value.data);
      saleList(productsModel!);
    }).catchError((onError) {
      emit(AppGetHomeDataErrorState(onError.toString()));
    });
  }

  ///Search Product
  Future<void> searchProducts(String product) async {
    emit(AppSearchProductLoadingState());
    if (product.isNotEmpty)
      await DioHelper.setData(
        token: token ?? '',
        endPoint: SEARCH,
        query: {"text": product},
      ).then((value) {
        searchProduct = ProductsModel.fromJson(value.data);
        emit(AppSearchProductSuccessState());
      }).catchError((onError) {
        emit(AppSearchProductErrorState(onError.toString()));
      });
  }

  /// Create Sale List
  void saleList(ProductsModel products) {
    saleProducts = [];
    topSaleProducts = [];
    products.data.data.forEach((element) {
      if (element.discount > 1) saleProducts!.add(element);
      if (element.discount > 40) topSaleProducts!.add(element);
    });
  }

  ///Get Favorites
  Future<void> getFavorites() async {
    emit(AppFavoritesLoadingState());
    if (token != null)
      await DioHelper.getData(
        endPoint: FAVORITES,
        token: token ?? '',
      ).then((value) {
        favoritesProduct = FavoritesModel.fromJson(value.data);

        emit(AppFavoritesSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(AppFavoritesErrorState(onError.toString()));
      });
  }

  ///Set and Remove Favorites
  Future<void> setFavorites({
    required var product,
  }) async {
    emit(AppSetFavoritesLoadingState());
    if (product is int) {
      favoritesProduct!.data.data.removeWhere(
        (element) => element.product.id == product,
      );
      await DioHelper.setData(
        endPoint: FAVORITES,
        token: token ?? '',
        query: {
          'product_id': product,
        },
      ).then((value) {
        getHomeData();
        getProductsData();
        getFavorites();

        emit(AppSetFavoritesSuccessState());
      }).catchError((onError) {
        emit(AppSetFavoritesErrorState(onError.toString()));
      });
    } else {
      product.inFavorites = !product.inFavorites;
      await DioHelper.setData(
        endPoint: FAVORITES,
        token: token ?? '',
        query: {
          'product_id': product.id,
        },
      ).then((value) async {
        await getFavorites();

        emit(AppSetFavoritesSuccessState());
      }).catchError((onError) {
        emit(AppSetFavoritesErrorState(onError.toString()));
      });
    }
  }

  ///get user Data by token
  Future<void> getUserData() async {
    if (token != null)
      await DioHelper.getData(
        endPoint: PROFILE,
        token: token ?? '',
      ).then((value) {
        userModel = UserModel.fromJson(value.data);
        emit(AppGetUserDataSuccessState());
      }).catchError((onError) {
        emit(AppGetUserDataErrorState(onError.toString()));
      });
  }

  ///get user cart
  Future<void> getUserCart() async {
    if (token != null)
      await DioHelper.getData(
        endPoint: CARTS,
        token: token ?? '',
      ).then((value) {
        cartModel = CartModel.fromJson(value.data);
        emit(AppGetUserCartSuccessState());
      }).catchError((onError) {
        print(onError.toString());
        emit(AppGetUserCartErrorState(onError.toString()));
      });
  }

  ///set user cart
  Future<void> setUserCart(var productId) async {
    if (token != null) {
      if (productId is int) {
        await DioHelper.setData(
            endPoint: CARTS,
            token: token ?? '',
            query: {"product_id": productId}).then((value) async {
          await getUserCart();
          emit(AppSetUserCartSuccessState());
        }).catchError((onError) {
          emit(AppSetUserCartErrorState(onError.toString()));
        });
      } else {
        favoritesProduct!.data.data.forEach((element) async {
          await DioHelper.setData(
              endPoint: CARTS,
              token: token ?? '',
              query: {"product_id": element.product.id}).then((value) async {
            emit(AppSetUserCartSuccessState());
          }).catchError((onError) {
            emit(AppSetUserCartErrorState(onError.toString()));
          });
        });

      }
      await getUserCart();
    }
  }
}
