import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit_shop/states_shop.dart';
import 'package:shop_app/model/categories_model.dart';
import 'package:shop_app/model/favorites_model.dart';
import 'package:shop_app/network/dio_helper.dart';
import 'package:shop_app/shared/component.dart';

import '../model/Change_Fav_model.dart';
import '../model/categories_model.dart';
import '../model/login_model.dart';
import '../model/search_model.dart';
import '../model/shop_model.dart';
import '../network/cache_helper.dart';
import '../screens/login/login.dart';
import '../screens/shop/cateogries.dart';
import '../screens/shop/favorites.dart';
import '../screens/shop/products.dart';
import '../screens/shop/settings.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(InitialState_());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void signOut_(context) {
    CacheHelper.removeData(key: 'token').then((value) {
      if (value) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      }

      emit(SuccessLogoutData());
    }).onError((error, stackTrace) {
      print(error);
      emit(ErrorLogoutData());
    });
  }

  List<Widget> screens = [
    const ProductsScreen(),
    const CateogriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen(),
  ];

  void changeScreen(int index) {
    currentIndex = index;
    // if(currentIndex == 2)
    //   {
    //     getFavoriteData();
    //   }
    // if(currentIndex == 3)
    //   {
    //     getProfileData();
    //   }
    emit(changeIndexButton());
  }

  Map<int, bool> favorite = {};

  HomeModel? homeModel;
  void getHomeData() {
    emit(LoadingHomeData());
    DioHelper.getData(
      url: 'home',
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorite.addAll({element.id!: element.in_favorites!});
      });
      emit(SuccessHomeData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorHomeData());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: 'categories',
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(SuccessCategoriesData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorCategoriesData());
    });
  }

  ChangeFavoriteModel? changeFavoriteModel;
  void ChangeFavorite(int product_id) {
    favorite[product_id] = !favorite[product_id]!;
    emit(SuccessChangeFirstFavData());

    DioHelper.postData(
      url: 'favorites',
      token: token,
      data: {
        'product_id': product_id,
      },
    ).then((value) {
      changeFavoriteModel = ChangeFavoriteModel.fromJson(value.data);
      print(changeFavoriteModel!.message);
      if (!changeFavoriteModel!.status!) {
        favorite[product_id] = !favorite[product_id]!;
      } else {
        getFavoriteData();
      }

      emit(SuccessChangeFavData(changeFavoriteModel!));
    }).catchError((error) {
      print(error.toString());
      favorite[product_id] = !favorite[product_id]!;

      emit(ErrorChangeFavData());
    });
  }

  FavoriteModel? favoriteModel;
  void getFavoriteData() {
    emit(LoadingFavoriteData());
    DioHelper.getData(
      url: 'favorites',
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(SuccessFavoritesData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorFavoritesData());
    });
  }

  ShopLoginModel? UserDatas;
  void getProfileData() {
    emit(LoadingProfileData());
    DioHelper.getData(
      url: 'profile',
      token: token,
    ).then((value) {
      UserDatas = ShopLoginModel.fromJson(value.data);
      print(UserDatas!.data!.name);
      emit(SuccessProfileData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorProfileData());
    });
  }

  void getUpdateData({
  required String name,
  required String email,
  required String phone,
   String? password,
}) {
    emit(LoadingUpdateData());
    DioHelper.putData(
      url: 'update-profile',
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      },
    ).then((value) {
      UserDatas = ShopLoginModel.fromJson(value.data);
      print(UserDatas!.data!.name);
      emit(SuccessUpdateData(UserDatas!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateData());
    });
  }

  SearchModel? searchModel;
  void getSearchData(String search) {
    emit(LoadingSearchData());
    DioHelper.postData(
      url: 'products/search',
      data: {
        'text': search,
      },
      token: token,
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      emit(SuccessSearchData(searchModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorSearchData());
    });
  }


  ShopLoginModel? registerModel;
  void getRegisterData({
  required String name,
  required String email,
  required String password,
    required String phone,
}) {
    emit(LoadingRegisterData());
    DioHelper.postData(
      url: 'register',
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      }
    ).then((value) {
      registerModel = ShopLoginModel.fromJson(value.data);
      emit(SuccessRegisterData(registerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ErrorRegisterData());
    });
  }

  bool isPass = true;
  IconData icon = Icons.visibility_outlined;

  void changeVisibilityPass() {
    isPass = !isPass;
    icon = isPass ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeRegisterPassVisibilityState());
  }


}