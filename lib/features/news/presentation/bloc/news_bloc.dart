import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/news_repository.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository repository;

  NewsCubit(this.repository) : super(NewsInitial());

  Future<void> fetchArticles() async {
    emit(NewsLoading());
    try {
      final articles = await repository.getArticles();
      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError("Gagal mengambil berita: $e"));
    }
  }
}