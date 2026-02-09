import 'package:injectable/injectable.dart';

import '../repositories/home_repository.dart';

@injectable
class GetLastMeditation {
  const GetLastMeditation(this._repository);

  final HomeRepository _repository;

  String? call() => _repository.getLastMeditationTitle();
}
