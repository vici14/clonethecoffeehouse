import 'package:flutterclonethecoffeehouse/src/bloc/base/base_state.dart';

enum DashBoardTypes { NEWS, ORDER, STORE, ACCOUNT }

class DashBoardState extends BaseState {
  final int currentIndex;

  DashBoardState({int currentIndex, DashBoardState state, bool isLoading})
      : currentIndex = currentIndex ?? state.currentIndex,
        super(
            isLoading: isLoading ?? state?.isLoading,
            timeStamp: DateTime.now().millisecondsSinceEpoch);
}
