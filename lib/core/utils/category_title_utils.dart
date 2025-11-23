

class CategoryTitleScreenUtils {

  static String getCategoryTitle(String category) {
    switch (category) {
      case 'recent':
        return 'Recently Generated';
      case 'quick':
        return 'Quick & Easy';
      case 'saved':
        return 'Saved Recipes';
      default:
        return 'All Recipes';
    }
  }

  static final recipes = List.generate(
    12,
        (index) => {
      'title': 'Recipe ${index + 1}',
      'cookTime': '${15 + index * 5} min',
      'difficulty': ['Easy', 'Medium', 'Hard'][index % 3],
      'cuisine': ['Italian', 'Asian', 'Mexican', 'Indian'][index % 4],
    },
  );


}