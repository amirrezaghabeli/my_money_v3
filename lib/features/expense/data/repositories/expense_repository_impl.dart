import 'package:dartz/dartz.dart';
import 'package:my_money_v3/core/data/models/expense_model.dart';

import '../../../../core/domain/entities/expense.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/expense_repository.dart';
import '../datasources/expense_remote_data_source.dart';
import '../datasources/expnese_local_data_source.dart';

class ExpenseRepositoryImpl implements ExpenseRepository {
  final ExpenseRemoteDataSource expenseRemoteDataSource;
  final ExpenseLocalDataSource expenseLocalDataSource;

  ExpenseRepositoryImpl({
    required this.expenseRemoteDataSource,
    required this.expenseLocalDataSource,
  });

  @override
  Future<Either<Failure, void>> addExpense(ExpenseModel expenseModel) async {
    try {
      var result = await expenseLocalDataSource.addExpense(expenseModel);
      return Right(result);
    } on Exception {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, List<Expense>>> getExpenses([
    int? fromDate,
    int? toDate,
  ]) async {
    final result = await expenseLocalDataSource.getExpenses(fromDate, toDate);
    return Right(result);
  }

  @override
  Future<Either<Failure, void>> deleteExpense(String id) async {
    final result = await expenseLocalDataSource.deleteExpense(id);
    return Right(result);
  }
}
