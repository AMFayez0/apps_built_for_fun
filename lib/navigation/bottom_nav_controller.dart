import 'package:app_built_for_fun/navigation/nav_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavController extends StateNotifier<NavStates> {
  NavController() : super(const NavStates());

  void setIndex(int index) {
    state = state.copyWith(index: index);
  }
}

final navProvider =
    StateNotifierProvider<NavController, NavStates>((ref) {
  return NavController();
});
