import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ihep/models/paper.dart';
import 'package:ihep/repositories/papers_repository.dart';

class PaperBloc extends Bloc<PaperEvent, PaperFetchState> {
  PaperBloc({required PapersRepository papersRepo})
      : _papersRepo = papersRepo,
        super(const PaperFetchInitial()) {
    on<PaperFetchRequested>(
      (event, emit) async {
        emit(const PaperFetchLoading());

        try {
          final paper = await _papersRepo.getSpecificPaper(event.id);

          emit(PaperFetchSuccess(paper));
        } catch (e) {
          emit(PaperFetchFailure(e));
        }
      },
    );
  }

  final PapersRepository _papersRepo;
}

sealed class PaperFetchState {
  const PaperFetchState();
}

class PaperFetchInitial extends PaperFetchState {
  const PaperFetchInitial();
}

class PaperFetchLoading extends PaperFetchState {
  const PaperFetchLoading();
}

class PaperFetchSuccess extends PaperFetchState {
  const PaperFetchSuccess(this.paper);
  final Paper paper;
}

class PaperFetchFailure extends PaperFetchState {
  const PaperFetchFailure(this.error);
  final Object error;
}

sealed class PaperEvent {
  const PaperEvent();
}

class PaperFetchRequested extends PaperEvent {
  const PaperFetchRequested({
    required this.id,
  });

  final String id;
}
