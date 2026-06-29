import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/env_config.dart';
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
        backgroundColor: const Color(0xFF121212), // Background Dark Mode
        appBar: AppBar(
          // Logika Anti-AI: Nama dan Warna sesuai Environment
          title: Text(
            EnvConfig.isProduction ? "UTD - 20123021" : "DEV - Rifky",
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: EnvConfig.isProduction ? const Color(0xFF0D47A1) : const Color(0xFF1E1E1E), 
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.white));
            } 
            else if (state is NewsLoaded) {
              return ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) {
                  return ArticleCard(article: state.articles[index]);
                },
              );
            } 
            else if (state is NewsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return const Center(child: Text("Tekan refresh untuk memuat berita", style: TextStyle(color: Colors.white)));
          },
        ),
      ),
    );
  }
}