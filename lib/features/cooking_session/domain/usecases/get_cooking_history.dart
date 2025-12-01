
import '../entities/cooking_session_entity.dart';
import '../repository/cooking_repository.dart';

class GetCookingHistory {
  final CookingRepository repository;

  GetCookingHistory(this.repository);

  Stream<List<CookingSession>> call(String userId) {
    return repository.getCookingHistoryStream(userId);
  }
}