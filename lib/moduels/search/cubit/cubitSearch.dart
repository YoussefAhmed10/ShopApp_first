import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/searchmodel/searchProductModel.dart';
import 'package:shopapp/moduels/search/cubit/state.dart';
import 'package:shopapp/shared/Network/endPoints.dart';
import 'package:shopapp/shared/local/constance.dart';
import 'package:shopapp/shared/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(InitialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);

  late SearchsModel searchsModel;
  void getSearch(String text) {
    emit(LoadingSearchState());
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: token!,
    ).then((value) {
      searchsModel = SearchsModel.fromJson(value.data);
      emit(SucessSearchState());
    }).catchError((error) {
      print(error.toString());
      emit(
        ErrorSearchState(
          error.toString(),
        ),
      );
    });
  }
}
