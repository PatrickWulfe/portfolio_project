import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:portfolio_project/src/app/app_index.dart';

part 'app_bloc.freezed.dart';
part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const _Normal(themeName: ThemeName.light)) {
    on<AppEvent>((event, emit) {
      event.when(
        started: () {},
        themeChanged: (ThemeName themeName) =>
            emit(state.copyWith(themeName: themeName)),
        themeSwapped: () {
          state.themeName == ThemeName.light
              ? emit(state.copyWith(themeName: ThemeName.dark))
              : emit(state.copyWith(themeName: ThemeName.light));
        },
      );
    });
  }
}