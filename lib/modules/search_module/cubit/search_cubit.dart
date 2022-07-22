import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/helpers/dio_helper.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search_module/cubit/search_states.dart';
import 'package:flutter/material.dart';
import '../../../shared/constants.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit(): super(SearchInitState());

  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);

  final TextEditingController searchController = TextEditingController();
  SearchModel? searchModel;

  void searchProducts(){
    emit(SearchLoadingState());

    DioHelper.postData(endPoint: search, data: {
      'text': searchController.text//searchController.text
    }
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);

      emit(SearchSuccessState());
    }).catchError((error){

      emit(SearchErrorState());
    });
  }

}