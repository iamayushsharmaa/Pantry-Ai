
class DifficultyUtils {
  static String getDifficultyLabel(int difficulty) {
    switch (difficulty) {
      case 1:
        return "Easy";
      case 2:
        return "Moderate";
      case 3:
        return "Medium";
      case 4:
        return "Hard";
      case 5:
        return "Expert";
      default:
        return "Medium";
    }
  }
}
