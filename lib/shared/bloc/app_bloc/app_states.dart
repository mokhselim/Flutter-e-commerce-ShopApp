abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppNavBarState extends AppStates {}
class AppDotsState extends AppStates {}

class AppGetHomeDataLoadingState extends AppStates {}

class AppGetHomeDataSuccessState extends AppStates {}

class AppGetHomeDataErrorState extends AppStates {
  final String onError;
  AppGetHomeDataErrorState(this.onError);
}

class AppAddSaleProductState extends AppStates {}

class AppSearchProductLoadingState extends AppStates {}

class AppSearchProductSuccessState extends AppStates {}

class AppSearchProductErrorState extends AppStates {
  final String onError;
  AppSearchProductErrorState(this.onError);
}
class AppFavoritesLoadingState extends AppStates {}

class AppFavoritesSuccessState extends AppStates {}

class AppFavoritesErrorState extends AppStates {
  final String onError;
  AppFavoritesErrorState(this.onError);
}
class AppSetFavoritesLoadingState extends AppStates {}

class AppSetFavoritesSuccessState extends AppStates {}

class AppSetFavoritesErrorState extends AppStates {
  final String onError;
  AppSetFavoritesErrorState(this.onError);
}

class AppGetUserDataSuccessState extends AppStates {}

class AppGetUserDataErrorState extends AppStates {
  final String onError;
  AppGetUserDataErrorState(this.onError);
}


class AppGetUserCartSuccessState extends AppStates {}

class AppGetUserCartErrorState extends AppStates {
  final String onError;
  AppGetUserCartErrorState(this.onError);
}
class AppSetUserCartSuccessState extends AppStates {}

class AppSetUserCartErrorState extends AppStates {
  final String onError;
  AppSetUserCartErrorState(this.onError);
}
