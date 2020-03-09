import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shashty_app/controllers/HomeController.dart';
import 'package:shashty_app/data/Models/FavouritesModel.dart';
import 'package:shashty_app/screens/Show/ShowDetails/TeamShowScreen.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';
import 'package:shashty_app/utils/Auth.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:shashty_app/utils/FixedAssets.dart';
class TeamsShowScreen extends StatefulWidget {

  Auth auth;
  HomeController homeController;
  TeamsShowScreen({this.auth,this.homeController});
  @override
  _TeamsShowScreenState createState() => _TeamsShowScreenState();
}

class _TeamsShowScreenState extends State<TeamsShowScreen> {



  Future<FavouriteModel> favouritesFuture;

  FavouriteModel allFavourites;
  FavouriteModel searchedFavourites=FavouriteModel(data: List<Datum>());

  int currentPagination = 1;
  int lastPagination = 1;
  bool isLoading = false;
  ScrollController _scrollController = new ScrollController();
  List<int> allFavouritesIds=[];
  TextEditingController searchController=TextEditingController();
  Timer timer;


//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//
//  }

  @override
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    await initializeDateFormatting("ar_SA", null);
    favouritesFuture = getTopFavourites(page: currentPagination,name:"",isFootball: true);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        currentPagination++;
        if (currentPagination <= lastPagination) {
          favouritesFuture =
              getTopFavourites(page: currentPagination,name:"",isFootball: true);
        }
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: favouritesFuture,
          builder: (context, AsyncSnapshot<FavouriteModel> snapshot) => Container(
            child:
            SingleChildScrollView(
              child: snapshot.data ==
                  null
                  ?
              Container(child:  Center(
                  child: FadeInImage( image: AssetImage(FixedAssets.noImage),
                    placeholder:  AssetImage(
                        FixedAssets.noImage),)
              ),)
                  : Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      onChanged: (value) {
                        if(value.length>0){
                          getSearchedFavourites(id: 3,name:value,isFootball: true);
                          searchedFavourites.data.indexWhere((fav)=> fav.isSelected == true);
                          setState(() {

                          });
                        }
                        else if(value.length==0){
                          try {
                            searchedFavourites.data.removeWhere((favourite) =>
                            favourite.isSelected == false,
                            );
                            setState(() {

                            });
                          }catch(e){
                            print("not find any selected items");
                          }


                        }
                        setState(() {

                        });

                      },
                      controller: searchController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(30),
                              borderSide: BorderSide(width: .5)),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black54,
                          ),
                          hintText: 'ابحث هنا بالاسم',
                          hintStyle: TextStyle(
                              color: Color(0xffa8a8a8),
                              fontSize: 15)),
//                          keyboardType: TextInputType.text,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height -100,
                    padding: EdgeInsets.symmetric(vertical: 10.0 , horizontal: 5.0),
                    child: searchController.text.length>0?
                    GridView.builder(
                        itemCount: searchedFavourites.data.length ,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: .7),
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
//                                  Stack(
//                                    children: <Widget>[
                              Container(
                                width:
                                MediaQuery.of(context).size.width / 4,
                                height:
                                MediaQuery.of(context).size.width / 4,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff7c94b6),
                                  image: new DecorationImage(
                                    image: NetworkImage(
                                      "http://koramania.cloudapp.net/FBMSImages/${searchedFavourites.data[index].image}",
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  border: Border.all(
                                      color:
                                      searchedFavourites.data[index].isSelected
                                          ? Colors.red
                                          : Colors.white,
                                      width: 2.0),
                                  borderRadius: new BorderRadius.all(
                                      Radius.circular(
                                          MediaQuery.of(context)
                                              .size
                                              .width /
                                              4)),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeamShowScreen(
                                      teamID:  searchedFavourites.data[index].id,
                                      token:  widget.auth.userToken,
                                      homeController: widget.homeController,
                                      title:searchedFavourites.data[index].name,
                                      imageTeam: searchedFavourites.data[index].image,
                                    )));
                                  },
                                ),
                              ),
//                                      Visibility(
//                                        visible: searchedFavourites.data[index].isSelected,
//
//                                        child: Container(
//                                          width:20,
//                                          height:20,
//                                          decoration: BoxDecoration(color: Colors.white70 ,shape: BoxShape.rectangle),
//                                          child:  Icon(Icons.check,color:Colors.red ,size: 18,),
//                                        ),
//                                      )
//                                    ],
//                                  ),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child:Text(
                                  "${searchedFavourites.data[index].name}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          );
                        }) :
                    GridView.builder(
                        itemCount: snapshot.data.data.length ,
                        shrinkWrap: true,
                        controller: _scrollController,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, childAspectRatio: .7),
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
//                                  Stack(
//                                    children: <Widget>[
                              Container(
                                width:
                                MediaQuery.of(context).size.width / 4,
                                height:
                                MediaQuery.of(context).size.width / 4,
                                decoration: new BoxDecoration(
                                  color: const Color(0xff7c94b6),
                                  image: new DecorationImage(
                                    image: NetworkImage(
                                        "http://koramania.cloudapp.net/FBMSImages/${allFavourites.data[index].image}"
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                  border: Border.all(
                                      color:
                                      allFavourites.data[index].isSelected
                                          ? Colors.red
                                          : Colors.white,
                                      width: 2.0),
                                  borderRadius: new BorderRadius.all(
                                      Radius.circular(
                                          MediaQuery.of(context)
                                              .size
                                              .width /
                                              4)),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeamShowScreen(
                                      teamID:  allFavourites.data[index].id,
                                      token: widget.auth.userToken.toString(),
                                      homeController: widget.homeController,
                                      title:allFavourites.data[index].name,
                                      imageTeam: allFavourites.data[index].image,
                                    )));
                                    print("allfavourites length ${allFavourites.data[index].id}");
                                    print("allfavourites length ${widget.auth.userToken.toString()}");
                                    print("allfavourites length ${widget.homeController}");
                                    print("allfavourites length ${allFavourites.data[index].name}");
                                    print("allFavourites.data[index].image ${allFavourites.data[index].image}");

                                  },
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child:Text(
                                  "${allFavourites.data[index].name}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          );
                        }),
                  ),

                ],
              ),
            ),
          )),
    );
  }

  Future<FavouriteModel> getTopFavourites({int page,String name,bool isFootball }) async {
    final url =
    !isFootball?"http://api.shashty.tv/api/filter/?category=3&favourite=1&page=$page&name=$name":"http://api.shashty.tv/api/teams?name=$name&page=$page";
    try{
      final topFavouritesResponse = await http.get(url);

      if (topFavouritesResponse.statusCode == 200) {
        if (allFavourites == null)
          allFavourites = favouriteModelFromJson(topFavouritesResponse.body);
        else{

          allFavourites.data
              .addAll(favouriteModelFromJson(topFavouritesResponse.body).data);
        }
        allFavourites.data.removeWhere((favourite){
          return favouriteModelFromJson(topFavouritesResponse.body).data.contains(favourite.id);
        });
        lastPagination = allFavourites.lastPage;

        setState(() {});

        return allFavourites;
      } else {
        final responseJson = json.decode(topFavouritesResponse.body);
        print(' CallResponse body failed ');
        print(' CallResponse body failed ' + responseJson.toString());

        return null;
      }
    }catch(e){
      print("get favourites exception");
    }
  }

  Future<FavouriteModel> getSearchedFavourites({int id,String name,bool isFootball}) async {
    final url =
    !isFootball?"http://api.shashty.tv/api/filter/?category=$id&favourite=1&name=$name":"http://api.shashty.tv/api/teams?name=$name";
    try{
      final topFavouritesResponse = await http.get(url);

      if (topFavouritesResponse.statusCode == 200) {
        if (searchedFavourites == null) {
          searchedFavourites = favouriteModelFromJson(topFavouritesResponse.body);
          print("searchedFavourites is null");

        }
        else{
          print("searchedFavourites is not null");

          try{
            searchedFavourites.data.removeWhere((favourite) =>
            favourite.isSelected == false,
            );
          }catch(e){
            print("no selectrd items flound");
          }
          searchedFavourites.data
              .addAll(favouriteModelFromJson(topFavouritesResponse.body).data);
        }
        for(int i=0;i<allFavouritesIds.length;i++){
          for(int j=0;j<searchedFavourites.data.length;j++){
            if(searchedFavourites.data[i].id==(allFavouritesIds[i])){

            }
          }
        }
        return allFavourites;
      } else {
        final responseJson = json.decode(topFavouritesResponse.body);
        print(' CallResponse body failed ');
        print(' CallResponse body failed ' + responseJson.toString());

        return null;
      }
    }catch(e){
      print("get favourites exception");
    }
  }

}