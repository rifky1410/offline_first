import '../../domain/entities/article_entity.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<ArticleEntity> articles;
  NewsLoaded(this.articles);
}

class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
}