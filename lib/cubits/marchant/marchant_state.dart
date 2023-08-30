part of 'marchant_cubit.dart';

@immutable
abstract class MerchantState {}

class MerchantInitial extends MerchantState {}
class getAllMerchantsLoadingState extends MerchantState {}
class getAllMerchantsSuccessState extends MerchantState {}
class getAllMerchantsErrorState extends MerchantState {}
class addMerchantLoadingState extends MerchantState {}
class addMerchantSuccessState extends MerchantState {
  String UserId;
  addMerchantSuccessState(this.UserId);
}
class addMerchantErrorState extends MerchantState {}
