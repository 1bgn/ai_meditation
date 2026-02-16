import 'package:injectable/injectable.dart';

import '../../domain/entities/breathing_history_item.dart';
import '../../domain/repositories/breathing_history_repository.dart';
import '../datasources/breathing_history_datasource.dart';

@LazySingleton(as: BreathingHistoryRepository)
class BreathingHistoryRepositoryImpl implements BreathingHistoryRepository {
  BreathingHistoryRepositoryImpl(this._local);

  final BreathingHistoryLocalDatasource _local;

  @override
  List<BreathingHistoryItem> getHistory() => _local.getHistory();

  @override
  Future<void> addHistoryItem(BreathingHistoryItem item) =>
      _local.addHistoryItem(item);

  @override
  Future<void> deleteHistoryItem(BreathingHistoryItem item) =>
      _local.deleteHistoryItem(item);
}
