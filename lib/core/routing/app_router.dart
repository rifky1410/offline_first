import 'package:go_router/go_router.dart';
import '../../features/news/presentation/pages/news_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const NewsPage(),
    ),
  ],
);