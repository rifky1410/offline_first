import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oflline_first/features/news/domain/entities/article_entity.dart';
import 'package:oflline_first/features/news/domain/repositories/news_repository.dart';
import 'package:oflline_first/features/news/domain/usecases/get_articles.dart';
import 'package:oflline_first/features/news/presentation/bloc/news_bloc.dart';
import 'package:oflline_first/features/news/presentation/bloc/news_state.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  late NewsCubit cubit;
  late MockNewsRepository mockRepo;
  late GetArticles getArticles;

  setUp(() {
    mockRepo = MockNewsRepository();
    getArticles = GetArticles(mockRepo);
    cubit = NewsCubit(getArticles);
  });

  tearDown(() => cubit.close());

  test('state awal adalah NewsInitial', () {
    expect(cubit.state, isA<NewsInitial>());
  });

  test('emit [NewsLoading, NewsLoaded] ketika fetchArticles berhasil', () async {
    final articles = [
      ArticleEntity(title: 'Z Article', description: 'desc', urlToImage: ''),
      ArticleEntity(title: 'A Article', description: 'desc', urlToImage: ''),
    ];
    when(() => mockRepo.getArticles()).thenAnswer((_) async => articles);

    final states = <NewsState>[];
    cubit.stream.listen(states.add);

    await cubit.fetchArticles();

    expect(states[0], isA<NewsLoading>());
    expect(states[1], isA<NewsLoaded>());
    expect((states[1] as NewsLoaded).articles.length, 2);
  });

  test('emit [NewsLoading, NewsError] ketika fetchArticles gagal', () async {
    when(() => mockRepo.getArticles()).thenThrow(Exception('Gagal'));

    final states = <NewsState>[];
    cubit.stream.listen(states.add);

    await cubit.fetchArticles();

    expect(states[0], isA<NewsLoading>());
    expect(states[1], isA<NewsError>());
    expect((states[1] as NewsError).message, contains('Gagal'));
  });
}
