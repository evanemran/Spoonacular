import 'package:spoonacular/models/Recipe.dart';

class RecipeResponse {
  List<Recipe>? recipes;

  RecipeResponse({this.recipes});

  RecipeResponse.fromJson(Map<String, dynamic> json) {
    if (json['recipes'] != null) {
      recipes = <Recipe>[];
      json['recipes'].forEach((v) {
        recipes!.add(new Recipe.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recipes != null) {
      data['recipes'] = this.recipes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}