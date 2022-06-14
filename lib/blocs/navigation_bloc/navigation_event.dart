part of 'navigation_bloc.dart';

@immutable
abstract class NavigationEvent {}

class NavigateToIndex extends NavigationEvent {
  NavigateToIndex({
    required this.index,
  });

  final int index;
}

class ChangeOrderBottomNavigationSheetBarStatus extends NavigationEvent {
  ChangeOrderBottomNavigationSheetBarStatus({
    required this.showBottomSheet,
  });

  final bool showBottomSheet;
}

class ChangeBottomNavigationBarStatus extends NavigationEvent {
  ChangeBottomNavigationBarStatus({
    required this.showBottomNavBar,
  });

  final bool showBottomNavBar;
}
