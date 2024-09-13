import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_manager_state.dart';

class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit() : super(AppManagerInitial());

  void onObscureChange() => emit(ObscureChange());

  void onSelectChange() => emit(SelectChange());

  void onScreenChange() => emit(ScreenChange());

  void onTextFormFieldChange() => emit(TextFormFieldChange());
}
