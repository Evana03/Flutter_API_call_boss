import 'dart:async';

import 'package:apicallsboss/models/chuck_categories.dart';
import 'package:apicallsboss/networking/ApiProvider.dart';

class ChuckCategoryRepository {
  ApiProvider _provider = ApiProvider();

  Future<chuckCategories> fetchChuckCategoryData() async {
    final response = await _provider.get("jokes/categories");
    return chuckCategories.fromJson(response);
  }
}
