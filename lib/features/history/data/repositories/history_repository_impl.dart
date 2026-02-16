import 'package:injectable/injectable.dart';

import '../../domain/entities/meditation_history_item.dart';
import '../../domain/repositories/history_repository.dart';
import '../datasources/history_local_datasource.dart';

@LazySingleton(as: HistoryRepository)
class HistoryRepositoryImpl implements HistoryRepository {
  HistoryRepositoryImpl(this._local);

  final HistoryLocalDatasource _local;

  @override
  List<MeditationHistoryItem> getHistory() => _local.getHistory();

  @override
  Future<void> addHistoryItem(MeditationHistoryItem item) => _local.addHistoryItem(item);

  @override
  Future<void> deleteHistoryItem(MeditationHistoryItem item) => _local.deleteHistoryItem(item);
}
