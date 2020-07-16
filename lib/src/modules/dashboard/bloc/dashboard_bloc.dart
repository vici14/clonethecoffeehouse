import 'package:flutterclonethecoffeehouse/src/bloc/base/base_event.dart';
import 'package:flutterclonethecoffeehouse/src/bloc/base/bloc_base.dart';
import 'package:flutterclonethecoffeehouse/src/modules/dashboard/bloc/dashboard_event.dart';
import 'package:flutterclonethecoffeehouse/src/modules/dashboard/bloc/dashboard_state.dart';

class DashBoardBloc extends BlocBase<BaseEvent, DashBoardState> {
  int currentIndex = 0;
  final DashBoardTypes type;

  DashBoardBloc({this.type});

  @override
  DashBoardState get initialState => DashBoardState(isLoading: false, currentIndex: 0);

  @override
  Stream<DashBoardState> mapEventToState(BaseEvent event) async* {
    if (event is PageTappedEvent) {
      yield* _changePageState(event);
    }
  }

  Stream<DashBoardState> _changePageState(PageTappedEvent event) async* {
//    yield DashBoardState(state: state, isLoading: true);
//    var index = _changePage();
    yield DashBoardState(state: state, currentIndex: event.index);
  }

  int _changePage(DashBoardTypes type) {
    switch (type) {
      case DashBoardTypes.NEWS:
        return 0;
      case DashBoardTypes.ORDER:
        return 1;
      case DashBoardTypes.STORE:
        return 2;
      case DashBoardTypes.ACCOUNT:
        return 3;
    }
    return 0;
  }

  changePage(DashBoardTypes types) {
    add(PageTappedEvent(index: _changePage(types)));
  }
}
