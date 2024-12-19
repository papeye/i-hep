import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihep/models/paper.dart';
import 'package:ihep/repositories/papers_repository.dart';

class PapersBloc extends Bloc<PapersEvent, PapersFetchState> {
  PapersBloc({required PapersRepository papersRepo})
      : _papersRepo = papersRepo,
        super(const PapersFetchInitial()) {
    on<PapersFetchRequested>(
      (event, emit) async {
        emit(const PapersFetchLoading());

        try {
          final papers = await _papersRepo.getTopCitedPapers(
            size: event.size,
            page: event.page,
          );

          emit(PapersFetchSuccess(papers));
        } catch (e) {
          emit(PapersFetchFailure(e));
        }
      },
    );
  }

  final PapersRepository _papersRepo;
}

sealed class PapersFetchState {
  const PapersFetchState();
}

class PapersFetchInitial extends PapersFetchState {
  const PapersFetchInitial();
}

class PapersFetchLoading extends PapersFetchState {
  const PapersFetchLoading();
}

class PapersFetchSuccess extends PapersFetchState {
  const PapersFetchSuccess(this.papers);
  final List<Paper> papers;
}

class PapersFetchFailure extends PapersFetchState {
  const PapersFetchFailure(this.error);
  final Object error;
}

sealed class PapersEvent {
  const PapersEvent();
}

class PapersFetchRequested extends PapersEvent {
  const PapersFetchRequested({
    required this.size,
    required this.page,
  });
  final int size;
  final int page;
}
