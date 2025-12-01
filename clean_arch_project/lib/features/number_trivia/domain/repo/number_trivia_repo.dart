import '../../../../core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/number_trivia.dart';

// I'm gonna use this repostitory contract to mock in tests and implement in data layer
abstract class NumberTriviaRepo{
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}