// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/moduels/search/cubit/cubitSearch.dart';
import 'package:shopapp/moduels/search/cubit/state.dart';
import 'package:shopapp/shared/local/componante.dart';

class SearchScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: searchController,
                        onFieldSubmitted: (String? text) {
                          SearchCubit.get(context).getSearch(text!);
                        },
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please add something to search aabout';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          label: Text('Search'),
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      if (state is LoadingSearchState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 10.0,
                      ),
                      if (state is SucessSearchState)
                        Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => buildListProduct(
                                    SearchCubit.get(context)
                                        .searchsModel
                                        .data
                                        .data[index],
                                    context,
                                    isOldPrice: false,
                                  ),
                              separatorBuilder: (context, index) => myDivider(),
                              itemCount: SearchCubit.get(context)
                                  .searchsModel
                                  .data
                                  .data
                                  .length),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
