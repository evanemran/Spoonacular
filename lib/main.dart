import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spoonacular/RequestManager/api_client.dart';
import 'package:spoonacular/Themes/AppTheme.dart';
import 'package:spoonacular/models/Recipe.dart';

String api_key = "c08f4981c8a44110b7ee3521f12796b4";
int number = 20;

void main() {
  runApp(const MyApp());
}

FutureBuilder<RecipeResponse> _buildRecipeBody(BuildContext context) {
  final client = ApiClient(Dio(BaseOptions(contentType: "application/json")));
  return FutureBuilder<RecipeResponse>(

    future: client.getRecipes(api_key, number),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final List<Recipe>? posts = snapshot.data?.recipes;
        return _buildRandomRecipeList(context, posts!);
      } else {
        return Center(
          child: CircularProgressIndicator(),
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
      return Card(
        elevation: 4,
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:<Widget>[
              Container(
                decoration:BoxDecoration(
                    borderRadius:BorderRadius.circular(10),
                    color:Colors.transparent
                ),
                child: new Image.network(posts[index].image.toString(),
                fit: BoxFit.fill,),
              ),
              Container(
                decoration:BoxDecoration(
                    borderRadius:BorderRadius.circular(10),
                    color:Colors.transparent
                ),
                child: Text(posts[index].title.toString(),
                  style: AppTheme.titleText,),
              ),
              Container(
                decoration:BoxDecoration(
                    borderRadius:BorderRadius.circular(10),
                    color:Colors.transparent
                ),
                child: Text(posts[index].sourceName.toString(),
                  style: AppTheme.subtitleText,),
              ),
              Container(
                decoration:BoxDecoration(
                    borderRadius:BorderRadius.circular(10),
                    color:Colors.transparent
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:<Widget>[
                      Container(
                        decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(0),
                            color:Colors.green
                        ),
                        child: Text(posts[index].aggregateLikes.toString() + " Likes",
                          style: AppTheme.subtitleText,),
                      ),
                      Container(
                        decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(0),
                            color:Colors.green
                        ),
                        child: Text(posts[index].readyInMinutes.toString() + " Mins",
                          style: AppTheme.subtitleText,),
                      ),
                      Container(
                        decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(0),
                            color:Colors.green
                        ),
                        child: Text(posts[index].servings.toString() + " person",
                          style: AppTheme.subtitleText,),
                      )
                    ]
                ),
              ),
            ]
        ),
      );

    },
  );
}

// ListView _buildRandomRecipeList(BuildContext context, List<Recipe> posts) {
//   return ListView.builder(
//     itemCount: posts.length,
//     padding: EdgeInsets.all(8),
//     itemBuilder: (context, index) {
//       return Card(
//         elevation: 4,
//         child: ListTile(
//           title: Text(
//             posts[index].title.toString(),
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           subtitle: Text(posts[index].sourceName.toString()),
//         ),
//       );
//     },
//   );
// }

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
    final response = client.getRecipes(api_key, number);
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {

        },
        label:Icon(Icons.cancel),
        backgroundColor: Colors.green,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
