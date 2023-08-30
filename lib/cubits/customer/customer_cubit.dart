import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/customer_model.dart';
import '../../utils/constants.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(CustomerInitial());

  static CustomerCubit get(context) => BlocProvider.of(context);

  List customers = [];
  double forMe=0;
  double forYou=0;
  getAllCustomers() async {
    customers.clear();
    forMe=0;
    forYou=0;
    emit(getAllCustomersLoadingState());
    await FirebaseFirestore.instance
        .collection("customers")
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
        customers.add(
          {
            'id':element.id,
            'data':element.data(),
          }
        );
      }
      print(customers);
      print(forMe);
      print(forYou);
      emit(getAllCustomersSuccessState());
    }).catchError((error) {
      emit(getAllCustomersErrorState());
    });
  }
String? userIdNow;
  addCustomer(String name, String phone) async {
    emit(addCustomerLoadingState());
    final customersCollection =
        FirebaseFirestore.instance.collection('customers');
    await customersCollection.add({
      'name': name,
      'phone': phone,
      'balance': 0.0,
    }).then((value) {
      userIdNow=value.id;
      emit(addCustomerSuccessState(userIdNow!));
    }).catchError((error){
      emit(addCustomerErrorState());
    });
  }
}
