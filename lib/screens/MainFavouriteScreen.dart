import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shashty_app/data/Models/FavouritesModel.dart';
import 'package:shashty_app/sharedWidget/SharedWidgets.dart';

import 'RegisterScreen.dart';

class MainFavouriteScreen extends StatefulWidget {
  @override
  _MainFavouriteScreenState createState() => _MainFavouriteScreenState();
}

class _MainFavouriteScreenState extends State<MainFavouriteScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text("تسجيل حساب جديد",style: TextStyle(color: Colors.white70),),
            ),

            Image.asset(
              "assets/imgs/logo.png",
              width: MediaQuery.of(context).size.width - 50,
              height: MediaQuery.of(context).size.height * 0.12,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "اختر القسم المفضل",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.red,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemExtent: 120,
                padding: EdgeInsets.all(8),
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 100.0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemsFavouriteScreen(
                                          category: 3,
                                          categoryType: "parent_show",
                                      isFootball: false,
                                        )));
                          },
                        ),
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: AssetImage("assets/imgs/tvshow.jpg"),
                            fit: BoxFit.fill,
                          ),
                           borderRadius: new BorderRadius.all(
                              const Radius.circular(100.0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "برامج",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 100.0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SubFavouriteScreen()));
                          },
                        ),
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: AssetImage("assets/imgs/drama.jpg"),
                            fit: BoxFit.fill,
                          ),
                           borderRadius: new BorderRadius.all(
                              const Radius.circular(100.0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "دراما",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 100.0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemsFavouriteScreen(
                                      category: 3,
                                      categoryType: "parent_show",
                                      isFootball: true,
                                    )));
                            },
                        ),
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: AssetImage("assets/imgs/football.jpg"),
                            fit: BoxFit.fill,
                          ),
                           borderRadius: new BorderRadius.all(
                              const Radius.circular(100.0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "كرة قدم",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SubFavouriteScreen extends StatefulWidget {
  @override
  _SubFavouriteScreenState createState() => _SubFavouriteScreenState();
}

class _SubFavouriteScreenState extends State<SubFavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset(
                "assets/imgs/logo.png",
                width: MediaQuery.of(context).size.width - 50,
                height: MediaQuery.of(context).size.height * 0.12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "اختر من الدراما",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: Colors.red,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemExtent: 120,
                padding: EdgeInsets.all(8),
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 100.0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemsFavouriteScreen(
                                      category: 2,
                                      categoryType: "parent_show",
                                      isFootball: false,
                                    )));
                          },
                        ),
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: AssetImage("assets/imgs/series.jpg"),
                            fit: BoxFit.fill,
                          ),
                          border: Border.all(color: Colors.white, width: 2.0),
                          borderRadius: new BorderRadius.all(
                              const Radius.circular(100.0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "مسلسلات",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        width: 100.0,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemsFavouriteScreen(
                                      category: 1,
                                      categoryType: "show",
                                      isFootball: false,
                                    )));
                          },
                        ),
                        decoration: new BoxDecoration(
                          color: const Color(0xff7c94b6),
                          image: new DecorationImage(
                            image: AssetImage("assets/imgs/movie.jpg"),
                            fit: BoxFit.fill,
                          ),
                          border: Border.all(color: Colors.white, width: 2.0),
                          borderRadius: new BorderRadius.all(
                              const Radius.circular(100.0)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "افلام",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemsFavouriteScreen extends StatefulWidget {
  final int category;
  final String categoryType;
  final bool isFootball;

  ItemsFavouriteScreen({this.category, this.categoryType,this.isFootball});

  @override
  _ItemsFavouriteScreenState createState() => _ItemsFavouriteScreenState();
}

class _ItemsFavouriteScreenState extends State<ItemsFavouriteScreen> {
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favouritesFuture = getTopFavourites(id:widget.category,page: currentPagination,name:"",isFootball: widget.isFootball);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        currentPagination++;
        if (currentPagination <= lastPagination) {
          favouritesFuture =
              getTopFavourites(id:widget.category,page: currentPagination,name:"",isFootball: widget.isFootball);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: favouritesFuture,
          builder: (context, AsyncSnapshot<FavouriteModel> snapshot) => snapshot
                      .data ==
                  null
              ? Center(
                  child: Image.asset(
                    "assets/imgs/logo.png",
                    width: MediaQuery.of(context).size.width - 50,
                    height: MediaQuery.of(context).size.height * 0.12,
                  ),
                )
              : ListView(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/imgs/logo.png",
                          width: MediaQuery.of(context).size.width - 50,
                          height: MediaQuery.of(context).size.height * 0.12,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "اختر المفضل لديك من ",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.red,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            onChanged: (value) {
                              if(value.length>0){
                                getSearchedFavourites(id: widget.category,name:value,isFootball: widget.isFootball);
                              }
                              else if(value.length==0){
                                try {
                                  searchedFavourites.data.removeWhere((favourite) =>
                                  favourite.isSelected == false,
                                  );
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
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                         Container(
                          height: MediaQuery.of(context).size.height / 2,
                          child: searchController.text.length>0?GridView.builder(
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
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          width:
                                          MediaQuery.of(context).size.width / 4,
                                          height:
                                          MediaQuery.of(context).size.width / 4,
                                          decoration: new BoxDecoration(
                                            color: const Color(0xff7c94b6),
                                            image: new DecorationImage(
                                              image: NetworkImage(
                                                widget.isFootball?"http://koramania.cloudapp.net/FBMSImages/${searchedFavourites.data[index].image}":"http://api.shashty.tv/${ searchedFavourites.data[index].image}",
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
                                              searchedFavourites.data[index].isSelected = !searchedFavourites.data[index].isSelected;
                                              if(searchedFavourites.data[index].isSelected){
                                                allFavouritesIds.add(allFavourites.data[index].id);
                                                allFavourites.data.removeWhere((favourite){
                                                  print("favourite id ${favourite.id} : Searched id ${searchedFavourites.data[index].id}");
                                                  return favourite.id==searchedFavourites.data[index].id;
                                                });
                                                allFavourites.data.add(searchedFavourites.data[index]);
                                              }else{
                                                allFavouritesIds.removeWhere((item){
                                                  return item==searchedFavourites.data[index].id;
                                                });
                                                allFavourites.data.removeWhere((favourite){
                                                          print("favourite id ${favourite.id} : Searched id ${searchedFavourites.data[index].id}");
                                                  return favourite.id==searchedFavourites.data[index].id;
                                                });

                                              }
                                              setState(() {
                                                print("allfavourites length ${allFavouritesIds.length}");
                                              });
                                            },
                                          ),
                                        ),
                                        Visibility(
                                          visible: searchedFavourites.data[index].isSelected,

                                          child: Container(
                                            width:20,
                                            height:20,
                                            decoration: BoxDecoration(color: Colors.white70 ,shape: BoxShape.rectangle),
                                            child:  Icon(Icons.check,color:Colors.red ,size: 18,),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "${searchedFavourites.data[index].name}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                      textAlign: TextAlign.center,
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
                                    Stack(
                                      children: <Widget>[
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width / 4,
                                          height:
                                              MediaQuery.of(context).size.width / 4,
                                          decoration: new BoxDecoration(
                                            color: const Color(0xff7c94b6),
                                            image: new DecorationImage(
                                              image: NetworkImage(
                                              widget.isFootball?"http://koramania.cloudapp.net/FBMSImages/${allFavourites.data[index].image}" :"http://api.shashty.tv/${allFavourites.data[index].image}",
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
                                              allFavourites.data[index].isSelected = !allFavourites.data[index].isSelected;
                                              if(allFavourites.data[index].isSelected){
                                                allFavouritesIds.add(allFavourites.data[index].id);
                                              }else{
                                                allFavouritesIds.removeWhere((item){
                                                  return item==allFavourites.data[index].id;
                                                });

                                              }
                                              setState(() {
                                                print("allfavourites length ${allFavouritesIds.length}");
                                              });
                                            },
                                          ),
                                        ),
                                        Visibility(
                                          visible: allFavourites.data[index].isSelected,

                                          child: Container(
                                            width:20,
                                            height:20,
                                            decoration: BoxDecoration(color: Colors.white70 ,shape: BoxShape.rectangle),
                                            child:  Icon(Icons.check,color:Colors.red ,size: 18,),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      "${allFavourites.data[index].name}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                );
                              }),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: RaisedButton(
                              color: Colors.red,
                              child: Text(
                                "سجل",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: (){
                                if(allFavouritesIds.length>0)
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RegisterScreen(favouriteCategoryIds: allFavouritesIds,favouriteCategoryType: widget.categoryType,)));
                             else{
                                  SharedWidgets.showToastMsg("اختر مفضلة واحدة على الاقل", false);

                                }
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                )),
    );
  }

  Future<FavouriteModel> getTopFavourites({int id, int page,String name,bool isFootball }) async {
    final url =
    !isFootball?"http://api.shashty.tv/api/filter/?category=$id&favourite=1&page=$page&name=$name":"http://api.shashty.tv/api/teams?name=$name&page=$page";
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

