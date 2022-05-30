import 'package:flutter/material.dart';
import 'package:spoonacular/models/Recipe.dart';

class DetailScreen extends StatelessWidget {
  final Recipe selectedRecipe;
  DetailScreen({key, required this.selectedRecipe});

  @override
  Widget build(BuildContext context) {
    String title = selectedRecipe.title.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedRecipe.title.toString()),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}