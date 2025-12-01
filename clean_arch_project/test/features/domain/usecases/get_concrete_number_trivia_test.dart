import 'package:mockito/mockito.dart' as mockito;
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_arch_project/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:clean_arch_project/features/number_trivia/domain/repo/number_trivia_repo.dart';
import 'package:clean_arch_project/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:clean_arch_project/core/errors/failure.dart';

class MockNumberTriviaRepo extends mockito.Mock
    implements NumberTriviaRepo {}

void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepo mockRepo;

  setUp(() {
    mockRepo = MockNumberTriviaRepo();
    usecase = GetConcreteNumberTrivia(mockRepo);
  });

  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: 'number one', number: tNumber);
  const tFailure = Failure('Server Failure');


  test(
    'should get trivia for the number from the repository',
    () async {
      mockito.when(mockRepo.getConcreteNumberTrivia(tNumber))
          .thenAnswer((_) async => const Right(tNumberTrivia)); 
      final result = await usecase.execute(tNumber);
      expect(result, const Right(tNumberTrivia));
      mockito.verify(mockRepo.getConcreteNumberTrivia(tNumber));
      mockito.verifyNoMoreInteractions(mockRepo);
    }
  );

  test(
    'should return Failure when repository fails to get data',
    () async {
      mockito.when(mockRepo.getConcreteNumberTrivia(tNumber))
          .thenAnswer((_) async => const Left(tFailure)); 
      final result = await usecase.execute(tNumber);
      expect(result, const Left(tFailure));
      mockito.verify(mockRepo.getConcreteNumberTrivia(tNumber));
      mockito.verifyNoMoreInteractions(mockRepo);
    }
  );
}