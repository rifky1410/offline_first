import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/env_config.dart';
import '../../../../core/di/injection.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_state.dart';
import '../widgets/article_card.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isProd = EnvConfig.isProduction;
    return BlocProvider(
      create: (context) => locator<NewsCubit>()..fetchArticles(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A12),
        appBar: AppBar(
          title: Text(
            isProd ? 'UTD - 20123021' : 'DEV - M Rifky',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          backgroundColor: isProd ? const Color(0xFF0D47A1) : const Color(0xFF1A1A2E),
          actions: [
            IconButton(
              icon: const CircleAvatar(
                radius: 16,
                backgroundColor: Colors.blueGrey,
                child: Icon(Icons.person, size: 18, color: Colors.white),
              ),
              onPressed: () => context.push('/profile'),
              tooltip: 'Profil',
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: BlocBuilder<NewsCubit, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blueAccent),
              );
            }
            if (state is NewsLoaded) {
              if (state.articles.isEmpty) {
                return const Center(
                  child: Text(
                    'Tidak ada berita tersedia.',
                    style: TextStyle(color: Colors.white54),
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () => context.read<NewsCubit>().fetchArticles(),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: state.articles.length,
                  itemBuilder: (context, index) =>
                      ArticleCard(article: state.articles[index]),
                ),
              );
            }
            if (state is NewsError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.wifi_off, color: Colors.redAccent, size: 48),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        style: const TextStyle(color: Colors.redAccent, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context.read<NewsCubit>().fetchArticles(),
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
