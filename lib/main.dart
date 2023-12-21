import 'package:apollo_nasa_app/view/apollo_list_view.dart';
import 'package:apollo_nasa_app/viewModel/nasa_wiew_model.dart';
import 'package:apollo_nasa_app/viewModel/we.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FavoritesProvider _nasaViewModel =  FavoritesProvider();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _nasaViewModel),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
        ChangeNotifierProvider(create: (context) => RatingProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Proyecto Apolo de la NASA',
        debugShowCheckedModeBanner: false,
        home: NasaListWidget(),
      ),
    );
  }
}
