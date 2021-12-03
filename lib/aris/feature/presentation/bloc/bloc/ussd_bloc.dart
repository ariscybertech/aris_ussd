import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ussd_event.dart';
part 'ussd_state.dart';

class UssdBloc extends Bloc<UssdEvent, UssdState> {
  UssdBloc() : super(UssdInitial()) {
    on<UssdEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
