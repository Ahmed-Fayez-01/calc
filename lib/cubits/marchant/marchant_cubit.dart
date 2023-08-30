import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../utils/constants.dart';

part 'marchant_state.dart';

class MerchantCubit extends Cubit<MerchantState> {
  MerchantCubit() : super(MerchantInitial());
  static MerchantCubit get(context) => BlocProvider.of(context);

  List merchants=[];
  double forMe=0;
  double forYou=0;
  getAllMerchants() async {
    merchants.clear();
    forMe=0;
    forYou=0;
    emit(getAllMerchantsLoadingState());
    await FirebaseFirestore.instance
        .collection("merchants")
        .get()
        .then((value) {
      for (var element in value.docs) {
        if(element.data()["balance"]<0)
        {
          forYou+=element.data()['balance'];
        }else
        {
          forMe+=element.data()['balance'];
        }
        merchants.add(
            {
              'id':element.id,
              'data':element.data(),
            }
        );
      }
      emit(getAllMerchantsSuccessState());
    }).catchError((error) {
      emit(getAllMerchantsErrorState());

    });
  }
  String? userIdNow;
  addMerchant(String name, String phone) async {
    emit(addMerchantLoadingState());
    final customersCollection =
    FirebaseFirestore.instance.collection('merchants');
    await customersCollection.add({
      'name': name,
      'contactPhone': phone,
      'balance': 0.0,
    }).then((value) {
      userIdNow=value.id;
      emit(addMerchantSuccessState(userIdNow!));
    }).catchError((error){
      emit(addMerchantErrorState());
    });
  }
}
