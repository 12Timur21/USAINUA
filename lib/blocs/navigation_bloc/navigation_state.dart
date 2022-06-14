part of 'navigation_bloc.dart';

@immutable
class NavigationState extends Equatable {
  const NavigationState({
    required this.index,
    this.showBottomSheet = false,
    this.showBottomNavBar = true,
  });

  final int index;
  final bool showBottomSheet;
  final bool showBottomNavBar;

  NavigationState copyWith({
    int? index,
    bool? showBottomSheet,
    bool? showBottomNavBar,
  }) {
    return NavigationState(
      index: index ?? this.index,
      showBottomSheet: showBottomSheet ?? this.showBottomSheet,
      showBottomNavBar: showBottomNavBar ?? this.showBottomNavBar,
    );
  }

  @override
  List<Object?> get props => [index, showBottomSheet, showBottomNavBar];
}
