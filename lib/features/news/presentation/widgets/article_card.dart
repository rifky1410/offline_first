import 'package:flutter/material.dart';
import '../../domain/entities/article_entity.dart';

class ArticleCard extends StatelessWidget {
  final ArticleEntity article;
  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Text(article.description, maxLines: 2, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}