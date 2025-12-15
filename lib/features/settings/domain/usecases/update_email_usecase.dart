import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../auth/domain/usecases/update_email_usecase.dart' as auth;

class UpdateEmailUseCase {
  final auth.UpdateEmailUseCase authUpdateEmail;

  UpdateEmailUseCase(this.authUpdateEmail);

  Future<Either<Failure, void>> call(String newEmail) {
    return authUpdateEmail(newEmail);
  }
}
