import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oflline_first/features/news/domain/entities/article_entity.dart';
import 'package:oflline_first/features/news/domain/repositories/news_repository.dart';
import 'package:oflline_first/features/news/domain/usecases/get_articles.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  late GetArticles sut;
  late MockNewsRepository mockRepo;

  setUp(() {
    mockRepo = MockNewsRepository();
    sut = GetArticles(mockRepo);
  });

  test('memanggil repository.getArticles() dan mengembalikan hasilnya', () async {
    final articles = [
      ArticleEntity(title: 'Artikel 1', description: 'desc', urlToImage: ''),
      ArticleEntity(title: 'Artikel 2', description: 'desc', urlToImage: ''),
    ];
    when(() => mockRepo.getArticles()).thenAnswer((_) async => articles);

    final result = await sut();

    expect(result.length, 2);
    expect(result.first.title, 'Artikel 1');
    verify(() => mockRepo.getArticles()).called(1);
  });

  test('melempar exception jika repository gagal', () async {
    when(() => mockRepo.getArticles()).thenThrow(Exception('error'));

    expect(() => sut(), throwsException);
  });
}
