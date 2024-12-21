import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihep/repositories/papers_repository.dart';

class DashboardBloc extends Bloc<PaperEvent, DashboardState> {
  DashboardBloc({required PapersRepository papersRepo})
      : _papersRepo = papersRepo,
        super(const DashboardInitial()) {
    on<DashboardRequested>(
      (event, emit) async {
        emit(const DashboardLoading());

        try {
          final paper = await _papersRepo.getTotalPapersCount();

          final data = DashboardData(
            totalPapersCount: paper,
          );

          emit(DashboardSuccess(data));
        } catch (e) {
          emit(DashboardFailure(e));
        }
      },
    );
  }

  final PapersRepository _papersRepo;
}

sealed class DashboardState {
  const DashboardState();
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardSuccess extends DashboardState {
  const DashboardSuccess(this.data);
  final DashboardData data;
}

class DashboardFailure extends DashboardState {
  const DashboardFailure(this.error);
  final Object error;
}

sealed class PaperEvent {
  const PaperEvent();
}

class DashboardRequested extends PaperEvent {
  const DashboardRequested();
}

class DashboardData {
  const DashboardData({
    required this.totalPapersCount,
  });

  final int totalPapersCount;
}
