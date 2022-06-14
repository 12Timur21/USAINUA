import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(
          const NavigationState(
            index: 0,
          ),
        ) {
    on<NavigateToIndex>((event, emit) {
      emit(
        state.copyWith(
          index: event.index,
        ),
      );
    });
    on<ChangeOrderBottomNavigationSheetBarStatus>((event, emit) {
      emit(
        state.copyWith(
          showBottomSheet: event.showBottomSheet,
        ),
      );
    });
    on<ChangeBottomNavigationBarStatus>((event, emit) {
      emit(
        state.copyWith(
          showBottomNavBar: event.showBottomNavBar,
        ),
      );
    });
  }
}
