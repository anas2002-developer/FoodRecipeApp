import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:khana_app/model.dart';
import 'package:khana_app/recipeWebView.dart';

class Search extends StatefulWidget {

  String searchData;
  Search(@required this.searchData);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {


  var isLoading;

  var searchCtrl = TextEditingController();

  List<RecipeModel> listRecipeModel = <RecipeModel>[];

  List list2 = [
    {
      "img" : "https://i.kym-cdn.com/entries/icons/original/000/023/397/C-658VsXoAo3ovC.jpg",
      "heading" : "Spiderman",
    },

    {
      "img" : "https://i.kym-cdn.com/entries/icons/original/000/023/397/C-658VsXoAo3ovC.jpg",
      "heading" : "Spiderman",
    },

    {
      "img" : "https://i.kym-cdn.com/entries/icons/original/000/023/397/C-658VsXoAo3ovC.jpg",
      "heading" : "Spiderman",
    },

    {
      "img" : "https://i.kym-cdn.com/entries/icons/original/000/023/397/C-658VsXoAo3ovC.jpg",
      "heading" : "Spiderman",
    },

    {
      "img" : "https://i.kym-cdn.com/entries/icons/original/000/023/397/C-658VsXoAo3ovC.jpg",
      "heading" : "Spiderman5",
    },

    {
      "img" : "https://i.kym-cdn.com/entries/icons/original/000/023/397/C-658VsXoAo3ovC.jpg",
      "heading" : "Spiderman6",
    },

  ];

  void callAPI(String food) async{


    setState(() {
      isLoading = true;
      listRecipeModel.clear();
    });

    var url = Uri.parse("https://api.edamam.com/api/recipes/v2?type=public&q=$food&app_id=f1d36ca8&app_key=1f8fff0346f6cffa382104bbf760df1f");
    http.Response response = await http.get(url);
    Map jsonData = jsonDecode(response.body);

    //better to use log for complete data
    print(jsonData.toString());

    jsonData['hits'].forEach(
            (elem){
          RecipeModel model = RecipeModel();
          model = RecipeModel.fromMap(elem['recipe']);
          listRecipeModel.add(model);

          setState(() {
            isLoading = false;
          });

        }
    );

    listRecipeModel.forEach(
            (pos){
          print(pos.name);
          print(pos.calories);
        }
    );



  }

  @override
  void initState() {
    super.initState();

    callAPI(widget.searchData);
    print("init called");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: Colors.white),
                    child: Row(
                      children: [
                        InkWell(
                          child: Icon(CupertinoIcons.search),
                          onTap: (){
                            if (searchCtrl.text.replaceAll(" ","")!=""){
                              callAPI(searchCtrl.text);
                            }
                          },),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchCtrl,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Chalo kuch banaya jae ?",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: isLoading ? Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: CircularProgressIndicator())): ListView.builder(
                      itemCount: listRecipeModel.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RecipeWebView(listRecipeModel[index].recipeUrl),));
                          },
                          child: Card(
                            margin: EdgeInsets.all(20),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  child: Image.network(listRecipeModel[index].imgUrl,
                                    fit: BoxFit.fill,
                                    height: 300,
                                    width: double.infinity,),
                                  borderRadius: BorderRadius.circular(20),
                                ),

                                Positioned(
                                  // top: ,
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          color: Colors.black26,
                                        ),
                                        padding: EdgeInsets.all(10),
                                        child: Text(listRecipeModel[index].name))),

                                Positioned(
                                    right: 0,
                                    top: 0,
                                    height: 30,
                                    width: 80,
                                    child: Container(
                                        color: Colors.black26,
                                        padding: EdgeInsets.all(6),
                                        child: Center(
                                            child: Row(
                                              children: [
                                                Icon(Icons.local_fire_department),
                                                Text(listRecipeModel[index].calories.toString().substring(0,5)),
                                              ],
                                            ))))
                                //
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );;
  }
}

