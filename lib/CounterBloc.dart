import 'package:bloc_pattern/CounterEvents.dart';

class CounterBloc {
  int counter = 0;
  List<CounterEvent> events = [];

  Stream<int> mapStateToEvent() async* {
    while (true) {
      if(events.length > 0) {
        CounterEvent event = events[0];
        events.removeAt(0);
        if(event is CounterDecrementEvent) {
          counter = counter -1;
        } else if(event is CounterIncrementEvent) {
          counter = counter + 1;
        }
        yield counter;
      }

      await new Future.delayed(const Duration(microseconds: 1));
    }
  }

  void addEvent(CounterEvent event) {
    events.add(event);
  }
}
