import 'package:dartz/dartz.dart';
import 'package:my_money_v3/features/home/domain/entities/home_info_entity.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/domain/usecases/usecase.dart';
import '../repositories/home_info_repository.dart';

class GetHomeInfo implements UseCase<HomeInfoEntity, NoParams> {
  final HomeInfoRepository homeInfoRepository;

  GetHomeInfo({required this.homeInfoRepository});

  @override
  Future<Either<Failure, HomeInfoEntity>> call(NoParams params) =>
      homeInfoRepository.getHomeInfo();
}
