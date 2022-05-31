import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:spoonacular/models/Recipe.dart';
part 'api_client.g.dart';

String api_key = "c08f4981c8a44110b7ee3521f12796b4";

@RestApi(baseUrl: "https://api.spoonacular.com/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('recipes/random')
  Future<RecipeResponse> getRecipes(
      @Query("apiKey") String apiKey,
      @Query("number") int number,
      @Query("tags") List<String> tags
      );


  /*@POST('user/Api/v1/user/login')                                         //login
  Future<Response> getLogin([
    @Header("DeviceId") String deviceId,
    @Header("AuthorizedToken") String authenticationKey,
    @Header("Version") String version,
    @QueryMap() Map<String, String> param,
  ]);*/
}