import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spoonacular/DetailScreen.dart';
import 'package:spoonacular/RequestManager/api_client.dart';
import 'package:spoonacular/Themes/AppTheme.dart';
import 'package:spoonacular/models/Recipe.dart';
import 'package:transparent_image/transparent_image.dart';

String api_key = "e31374215c8e40b4839ff7bc9fa7ed14";
int number = 20;
List<String> tags =  [];
// Recipe clickedRecipe = new Recipe();

void main() {
  runApp(const MyApp());
}

Future showToast(String message) async {
  await Fluttertoast.cancel();
  
  Fluttertoast.showToast(msg: message, fontSize: 18);
}

FutureBuilder<RecipeResponse> _buildRecipeBody(BuildContext context) {

  final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
  return FutureBuilder<RecipeResponse>(

    future: client.getRecipes(api_key, number, tags),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final List<Recipe>? posts = snapshot.data?.recipes;
        return _buildRandomRecipeList(context, posts!);
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            // backgroundColor: Colors.white,
          ),
        );
      }
    },
  );
}

ListView _buildRandomRecipeList(BuildContext context, List<Recipe> posts) {
  return ListView.builder(
    itemCount: posts.length,
    padding: EdgeInsets.all(8),
    itemBuilder: (context, index) {
      // clickedRecipe = posts[index];
      return Card(
        elevation: 8,
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailScreen(selectedRecipe: posts[index],)),
            );
          },
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:<Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(10),
                        color:Colors.transparent
                    ),
                    child: Text(posts[index].title.toString(),
                      style: AppTheme.titleText,),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(10),
                        color:Colors.transparent
                    ),
                    child: Text(posts[index].getCategory().toString(),
                      style: AppTheme.subtitleText,),
                  ),
                ),
                Container(
                  decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(10),
                      color:Colors.transparent
                  ),
                  child: FadeInImage.memoryNetwork(
                    image: posts[index].image.toString(),
                    height: 200,
                    placeholder: kTransparentImage,
                    imageErrorBuilder:
                        (context, error, stackTrace) {
                      return Image.asset(
                          'assets/images/flag_placeholder.jpg',
                          height: 200,
                          fit: BoxFit.fitHeight);
                    },
                    fit: BoxFit.fitWidth,
                  ),
                  // child: Image.network(posts[index].image.toString(),
                  //   fit: BoxFit.fill,),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(10),
                        color:Colors.transparent
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:<Widget>[
                          Container(
                            // decoration:BoxDecoration(
                            //     borderRadius:BorderRadius.circular(0),
                            //     color:Colors.green
                            // ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget> [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      child: IconButton(
                                        icon: Icon(Icons.thumb_up),
                                        color: Colors.blue,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Text(posts[index].aggregateLikes.toString() + " Likes",
                                        style: AppTheme.subtitleText,),
                                    ),
                                  ),
                                ],
                              )
                            // child: Text(posts[index].aggregateLikes.toString() + " Likes",
                            //   style: AppTheme.subtitleText,),
                          ),
                          Container(
                            // decoration:BoxDecoration(
                            //     borderRadius:BorderRadius.circular(0),
                            //     color:Colors.green
                            // ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget> [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      child: IconButton(
                                        icon: Icon(Icons.timer),
                                        color: Colors.red,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Text(posts[index].readyInMinutes.toString() + " Mins",
                                        style: AppTheme.subtitleText,),
                                    ),
                                  ),
                                ],
                              )
                            // child: Text(posts[index].aggregateLikes.toString() + " Likes",
                            //   style: AppTheme.subtitleText,),
                          ),
                          Container(
                            // decoration:BoxDecoration(
                            //     borderRadius:BorderRadius.circular(0),
                            //     color:Colors.green
                            // ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget> [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      child: IconButton(
                                        icon: Icon(Icons.group),
                                        color: Colors.green,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Container(
                                      child: Text(posts[index].servings.toString() + " Person",
                                        style: AppTheme.subtitleText,),
                                    ),
                                  ),
                                ],
                              )
                            // child: Text(posts[index].aggregateLikes.toString() + " Likes",
                            //   style: AppTheme.subtitleText,),
                          ),
                        ]
                    ),
                  ),
                ),
              ]
          ),
        )
      );

    },
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spoonacular',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Recipes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();

  }

  Future getRandomRecipeApiCall() async{
    final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
    // Map<String, String> createDoc = new HashMap();
    // createDoc['username'] = "shikha";
    // createDoc['password'] = "shikha";
    // final response = client.getLogin('123','abc','',createDoc);
    final response = client.getRecipes(api_key, number, tags);
    // final user = userFromJson(response.toString());
    // print(user);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _buildRecipeBody(context),
      backgroundColor: Colors.green,
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Colors.green,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            child: Icon(Icons.food_bank_rounded),
            label: "Main course",
            onTap: () {

              tags.clear();
              tags.add("main course");
              // _buildRecipeBody(context);
              ReloadWithTag();
            }
          ),
          SpeedDialChild(
              child: Icon(Icons.food_bank_rounded),
              label: "Side dish",
              onTap: () {
                tags.clear();
                tags.add("side dish");
                ReloadWithTag();
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.food_bank_rounded),
              label: "Dessert",
              onTap: () {
                tags.clear();
                tags.add("dessert");
                // _buildRecipeBody(context);
                ReloadWithTag();
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.food_bank_rounded),
              label: "Appetizer",
              onTap: () {
                tags.clear();
                tags.add("appetizer");
                ReloadWithTag();
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.food_bank_rounded),
              label: "Salad",
              onTap: () {
                tags.clear();
                tags.add("salad");
                ReloadWithTag();
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.food_bank_rounded),
              label: "Breakfast",
              onTap: () {
                tags.clear();
                tags.add("breakfast");
                ReloadWithTag();
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.food_bank_rounded),
              label: "Soup",
              onTap: () {
                tags.clear();
                tags.add("soup");
                ReloadWithTag();
              }
          ),
          SpeedDialChild(
              child: Icon(Icons.food_bank_rounded),
              label: "drink",
              onTap: () {
                tags.clear();
                tags.add("drink");
                ReloadWithTag();
              }
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void ReloadWithTag(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return MyApp();
        },
      ),
    );
  }
}
