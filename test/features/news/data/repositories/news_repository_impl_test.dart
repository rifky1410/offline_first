import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oflline_first/features/news/data/datasources/news_remote_datasource.dart';
import 'package:oflline_first/features/news/data/datasources/news_local_datasource.dart';
import 'package:oflline_first/features/news/data/models/article_model.dart';
import 'package:oflline_first/features/news/data/repositories/news_repository_impl.dart';
import 'package:oflline_first/features/news/domain/entities/article_entity.dart';

class MockNewsRemoteDatasource extends Mock implements NewsRemoteDatasource {}
class MockNewsLocalDatasource extends Mock implements NewsLocalDatasource {}

ArticleModel _makeModel(String title) {
  final m = ArticleModel();
  m.title = title;
  m.description = 'desc';
  m.urlToImage = '';
  return m;
}

void main() {
  late NewsRepositoryImpl sut;
  late MockNewsRemoteDatasource mockRemote;
  late MockNewsLocalDatasource mockLocal;

  setUp(() {
    mockRemote = MockNewsRemoteDatasource();
    mockLocal = MockNewsLocalDatasource();
    sut = NewsRepositoryImpl(
      remoteDataSource: mockRemote,
      localDataSource: mockLocal,
    );
  });

  group('getArticles - online', () {
    test('returns articles sorted Z ke A (Descending) karena NIM Ganjil', () async {
      final models = [
        _makeModel('Berita A'),
        _makeModel('Berita Z'),
        _makeModel('Berita M'),
      ];
      when(() => mockRemote.getNewsFromApi()).thenAnswer((_) async => models);
      when(() => mockLocal.saveArticles(any())).thenAnswer((_) async {});

      final result = await sut.getArticles();

      expect(result[0].title, 'Berita Z');
      expect(result[1].title, 'Berita M');
      expect(result[2].title, 'Berita A');
    });

    test('menyimpan data ke cache (Isar) setelah berhasil fetch', () async {
      final models = [_makeModel('Test Article')];
      when(() => mockRemote.getNewsFromApi()).thenAnswer((_) async => models);
      when(() => mockLocal.saveArticles(any())).thenAnswer((_) async {});

      await sut.getArticles();

      verify(() => mockLocal.saveArticles(any())).called(1);
    });
  });

  group('getArticles - offline fallback', () {
    test('mengembalikan cache dari Isar ketika remote gagal (mode offline)', () async {
      when(() => mockRemote.getNewsFromApi()).thenThrow(Exception('No internet'));
      final cached = [
        ArticleEntity(title: 'Cached Z', description: 'desc', urlToImage: ''),
        ArticleEntity(title: 'Cached A', description: 'desc', urlToImage: ''),
      ];
      when(() => mockLocal.getArticles()).thenAnswer((_) async => cached);

      final result = await sut.getArticles();

      expect(result.isNotEmpty, true);
      expect(result[0].title, 'Cached Z');
    });
  });
}
