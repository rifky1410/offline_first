class ArticleEntity {
  final String title;
  final String description;
  final String urlToImage;
  final String url;

  ArticleEntity({
    required this.title,
    required this.description,
    required this.urlToImage,
    this.url = '',
  });
}