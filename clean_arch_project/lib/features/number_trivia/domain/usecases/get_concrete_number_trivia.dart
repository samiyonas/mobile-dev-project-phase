import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/number_trivia.dart';
import '../repo/number_trivia_repo.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepo repo;

  GetConcreteNumberTrivia(this.repo);

  Future<Either<Failure, NumberTrivia>> execute(int number) {
    return repo.getConcreteNumberTrivia(number);
  }
}