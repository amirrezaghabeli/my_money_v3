import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../repositories/category_repository.dart';

class DeleteCategoryUseCase implements UseCase<void, DeleteCategoryParams> {
  final CategoryRepository categoryRepository;

  DeleteCategoryUseCase({required this.categoryRepository});

  @override
  Future<Either<Failure, void>> call(DeleteCategoryParams params) =>
      categoryRepository.deleteCategory(params.id);
}

class DeleteCategoryParams extends Equatable {
  final String id;

  const DeleteCategoryParams(this.id);

  @override
  List<Object?> get props => [id];
}
