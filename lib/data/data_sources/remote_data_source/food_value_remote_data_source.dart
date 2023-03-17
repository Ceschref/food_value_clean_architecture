import 'package:web_provise/core/http_client/api_provider.dart';
import 'package:web_provise/core/http_client/custom_exception.dart';
import 'package:web_provise/data/models/food_value_model.dart';

import '../../../core/http_client/list_response.dart';

class FoodValueRemoteDataSource {
  FoodValueRemoteDataSource({required this.apiProvider});

  ApiProviderRepository apiProvider;

  Future<ListResponse<FoodValueModel>> getListFoodValue() async {
    try {
      final rawResponse = await apiProvider.getRequest(
        'https://hf-android-app.s3-eu-west-1.amazonaws.com/android-test/recipes.json',
      );
      if (rawResponse.statusCode == 200) {
        return ListResponse<FoodValueModel>(rawResponse.data, (itemJson) => FoodValueModel.fromJson(itemJson));
      } else {
        throw CustomException(rawResponse.statusCode, rawResponse.statusMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
}