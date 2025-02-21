import 'package:clean_archi_features_first/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<successType, Params> {
  Future<Either<Failure, successType>> call(Params param);
}

class NoParams {}
