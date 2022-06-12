import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spoonacular/Models/SimilarRecipeResponse.dart';
import 'package:spoonacular/models/Recipe.dart';
import 'package:transparent_image/transparent_image.dart';

import 'RequestManager/api_client.dart';
import 'Themes/AppTheme.dart';

int id = 0;
late Recipe selRecipe;

class DetailScreen extends StatelessWidget {
  final Recipe selectedRecipe;
  DetailScreen({key, required this.selectedRecipe});

  @override
  Widget build(BuildContext context) {
    String title = selectedRecipe.title.toString();

    id = selectedRecipe.id!;
    selRecipe = selectedRecipe;
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(selectedRecipe.title.toString(), style: AppTheme.titleTextDetail,),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(10),
                color:Colors.transparent
            ),
            child: Image.network(selectedRecipe.image.toString(),
              fit: BoxFit.fill,),
          ),
          const SizedBox(
            height: 20,
          ),
          //Text("Similar Recipe", style: AppTheme.titleTextDetail,),
          // _getSimilarRecipe(context),
          Text("Similar Recipe", style: AppTheme.titleTextDetail,),
          const SizedBox(
            height: 20,
          ),
          Text(selectedRecipe.summary.toString(), style: AppTheme.subtitleTextDetail,),
          const SizedBox(
            height: 20,
          ),
          showKeyPoints(),
          const SizedBox(
            height: 20,
          ),
          Text("Ingredients", style: AppTheme.titleTextDetail,),
          showIngredientsList(),
          const SizedBox(
            height: 20,
          ),

        ],
      ),
      ),
      ),
    );
  }
}

FutureBuilder<List<SimilarRecipeResponse>> _getSimilarRecipe(BuildContext context) {

  final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
  return FutureBuilder<List<SimilarRecipeResponse>>(

    future: client.getSimilarRecipes(api_key, 4,  id),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final List<SimilarRecipeResponse>? posts = snapshot.data;
        return _buildSimilarRecipeList(context, posts!);
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            // backgroundColor: Colors.white,
          ),
        );
      }
    },
  );
}

Widget showIngredientsList() {
  return ListView.builder(
    itemCount: selRecipe.extendedIngredients?.length,
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    padding: EdgeInsets.all(8),
    itemBuilder: (context, index) {
      // clickedRecipe = posts[index];
      if(index % 2 == 0){
        return Card(
            elevation: 8,
            color: Colors.white,
            child: InkWell(
                onTap: () {

                },
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.all(16),
                      child: FadeInImage.memoryNetwork(
                        image: 'https://spoonacular.com/cdn/ingredients_100x100/' + selRecipe.extendedIngredients![index].image.toString(),
                        width: 80,
                        height: 80,
                        placeholder: kTransparentImage,
                        imageErrorBuilder:
                            (context, error, stackTrace) {
                          return Image.asset(
                              'assets/images/flag_placeholder.jpg',
                              width: 80,
                              height: 80,
                              fit: BoxFit.fitWidth);
                        },
                        fit: BoxFit.fitWidth,
                      ),),
                    Expanded(child: Column(
                      children: [
                        // Align(alignment: Alignment.centerLeft, child: Text(selRecipe.extendedIngredients![index].aisle.toString(), style: AppTheme.subtitleText, textAlign: TextAlign.start,),),
                        // Align(alignment: Alignment.centerLeft, child: Text(selRecipe.extendedIngredients![index].originalName.toString(), style: AppTheme.subtitleText, textAlign: TextAlign.start,),),
                        Padding(padding: EdgeInsets.all(8),
                          child: Align(alignment: Alignment.centerLeft, child: Text(selRecipe.extendedIngredients![index].original.toString(), style: AppTheme.subtitleText, textAlign: TextAlign.start,),),)
                      ],
                    )),
                  ],
                )
            )
        );
      }
      else {
        return Card(
          elevation: 8,
          color: Colors.white,
          child: InkWell(
              onTap: () {

              },
              child: Row(
                children: [
                  Expanded(child: Column(
                    children: [
                      // Align(alignment: Alignment.centerLeft, child: Text(selRecipe.extendedIngredients![index].aisle.toString(), style: AppTheme.subtitleText, textAlign: TextAlign.start,),),
                      // Align(alignment: Alignment.centerLeft, child: Text(selRecipe.extendedIngredients![index].originalName.toString(), style: AppTheme.subtitleText, textAlign: TextAlign.start,),),
                      Padding(padding: EdgeInsets.all(8),
                        child: Align(alignment: Alignment.centerRight, child: Text(selRecipe.extendedIngredients![index].original.toString(), style: AppTheme.subtitleText, textAlign: TextAlign.start,),),)
                    ],
                  )),
                  Padding(padding: EdgeInsets.all(16),
                  child: FadeInImage.memoryNetwork(
                    image: 'https://spoonacular.com/cdn/ingredients_100x100/' + selRecipe.extendedIngredients![index].image.toString(),
                    width: 80,
                    height: 80,
                    placeholder: kTransparentImage,
                    imageErrorBuilder:
                        (context, error, stackTrace) {
                      return Image.asset(
                          'assets/images/flag_placeholder.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.fitWidth);
                    },
                    fit: BoxFit.fitWidth,
                  ),),
                ],
              )
          )
      );
      }

    },
  );
}

Widget showKeyPoints() {
  return Padding(padding: EdgeInsets.all(16), child:Column(
    children: [
      Row(children: [
        Icon(Icons.people, color: Colors.yellow,),
        Expanded(child: Text("  Can be served to " + selRecipe.servings.toString() + " Peoples", style: AppTheme.subtitleTextDetail,))
      ],),
      const SizedBox(
        height: 10,
      ),
      Row(children: [
        Icon(Icons.timer, color: Colors.yellow,),
        Expanded(child: Text("  Can be made within " + selRecipe.readyInMinutes.toString() + " Minutes", style: AppTheme.subtitleTextDetail,))
      ],),
      const SizedBox(
        height: 10,
      ),
      Row(children: [
        Icon(Icons.health_and_safety, color: Colors.yellow,),
        Expanded(child: Text("  Health score " + selRecipe.healthScore.toString() + " Points", style: AppTheme.subtitleTextDetail,))
      ],),
    ],
  ),);
}

Expanded _buildSimilarRecipeList(BuildContext context, List<SimilarRecipeResponse> posts) {
  return Expanded(child: ListView.builder(
    itemCount: posts.length,
    padding: EdgeInsets.all(4),
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
      // clickedRecipe = posts[index];
      return Container(
        width: 120,
        height: 100,
        child: Card(
            elevation: 8,
            color: Colors.white,
            child: InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => DetailScreen(selectedRecipe: null,)),
                // );
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:<Widget>[
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Container(
                        decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(10),
                            color:Colors.transparent
                        ),
                        child: Text(posts[index].title.toString(),
                          style: AppTheme.subtitleTextDetail,),
                      ),
                    ),
                    Container(
                      decoration:BoxDecoration(
                          borderRadius:BorderRadius.circular(10),
                          color:Colors.transparent
                      ),
                      child: Image.network('https://spoonacular.com/recipeImages/'+posts[index].id.toString()+'-556x370.'+posts[index].imageType.toString(),
                        fit: BoxFit.fill,),
                    ),
                  ]
              ),
            )
        ),
      );

    },
  ));
}