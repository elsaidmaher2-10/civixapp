part of 'singup_cubit.dart';

class SingupState {}

class SingupimageInitial extends SingupState {}

class Singupimageselected extends SingupState {
  File image;
  Singupimageselected(this.image);
}

class Singupimagedosentselected extends SingupState {}
