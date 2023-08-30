part of 'transactions_cubit.dart';

@immutable
abstract class TransactionsState {}

class TransactionsInitial extends TransactionsState {}
class getAllTransactionLoadingState extends TransactionsState {}
class getAllTransactionSuccessState extends TransactionsState {}
class getAllTransactionErrorState extends TransactionsState {}
class addTransactionLoadingState extends TransactionsState {}
class addTransactionSuccessState extends TransactionsState {}
class addTransactionErrorState extends TransactionsState {}