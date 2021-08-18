abstract class UserStates {}

class UserInitialState extends UserStates {}
class UserPasswordState extends UserStates {}

class UserDataLoadingState extends UserStates {}

class UserDataSuccessState extends UserStates {}

class UserDataErrorState extends UserStates {
  String onError;
  UserDataErrorState(this.onError);
}
