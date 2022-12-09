part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

//sign up
class SignedIn extends AuthState {
  final User? user;
  SignedIn(this.user);
}

//sign up and choose profile photo
class SignedInWithProfilePhoto extends AuthState {
  final User? user;
  SignedInWithProfilePhoto(this.user);
}

//login
class Login extends AuthState {
  final User? user;
  Login(this.user);
}

class SuggestedUsername extends AuthState {
  final List<String> usernames;
  SuggestedUsername(this.usernames);
}

class UserNameAvialable extends AuthState {
  final bool isAvailable;
  UserNameAvialable(this.isAvailable);
}

class ChooseProfileImageLoginChanged extends AuthState {
  final String url;
  ChooseProfileImageLoginChanged(this.url);
}

class AddUserInterests extends AuthState {
  final bool interestsUpdated;
  AddUserInterests(this.interestsUpdated);
}

class UpdateGenderDuringSignup extends AuthState {
  final bool genderUpdated;
  UpdateGenderDuringSignup(this.genderUpdated);
}

class ForgetPassword extends AuthState {
  final bool isSent;
  ForgetPassword(this.isSent);
}

class ForgetUsername extends AuthState {
  final bool isSent;
  ForgetUsername(this.isSent);
}

class GetTheUserData extends AuthState {
  final User? user;
  GetTheUserData(this.user);
}
