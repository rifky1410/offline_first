import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_articles.dart';
import 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final GetArticles getArticles;

  NewsCubit(this.getArticles) : super(NewsInitial());

  Future<void> fetchArticles() async {
    emit(NewsLoading());
    try {
      final articles = await getArticles();
      emit(NewsLoaded(articles));
    } catch (e) {
      emit(NewsError('Gagal memuat berita: $e'));
    }
  }
}
