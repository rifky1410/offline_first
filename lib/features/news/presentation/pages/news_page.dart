import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// PERBAIKAN: Mundur 4 langkah (../../../../) untuk mencapai folder core
import '../../../../core/di/injection.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_state.dart';
import '../widgets/article_card.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<NewsCubit>()..fetchArticles(),
      child: Scaffold(
        appBar: AppBar(title: const Text("DigiNews Terkini")),
        body: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is NewsLoaded) {
              return ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  return ArticleCard(article: state.articles[index]);
                },
              );
            } else if (state is NewsError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text("Tekan refresh untuk memuat berita"));
          },
        ),
      ),
    );
  }
}