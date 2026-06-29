import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/news/data/models/article_model.dart';

class IsarManager {
  static Future<Isar> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open(
      [ArticleModelSchema],
      directory: dir.path,
    );
  }
}
