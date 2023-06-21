class RecipeModel {
  late String name;
  late String imgUrl;
  late String recipeUrl;
  late double calories;

  RecipeModel(
      {this.name = "aam",
      this.imgUrl = "img",
      this.recipeUrl = "recipe",
      this.calories = 0.00});

  factory RecipeModel.fromMap(Map recipe) {
    return RecipeModel(
      name: recipe['label'],
      imgUrl: recipe['image'],
      recipeUrl: recipe['url'],
      calories: recipe['calories'],
    );
  }

}
