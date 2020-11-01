import 'dart:collection';

import 'package:aplikacija/pages/subc_details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String>{
  static List<dynamic> dbData = [];
  // punimo listu sa podacima koje cemo searchat
  Future dbDataStanovanje = FirebaseFirestore.instance.collection("Stanovanje").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      dbData.add(Result(category: "Stanovanje", subCategory: result["name"], text: result["body"]));
    });
  });
  Future dbDataFinansije = FirebaseFirestore.instance.collection("Finansije").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      // ignore: top_level_function_literal_block, top_level_function_literal_block
      dbData.add(Result(category: "Finansije", subCategory: result["name"], text: result["body"]));
    });
  });
  Future dbDataPosao = FirebaseFirestore.instance.collection("Posao").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      // ignore: top_level_function_literal_block, top_level_function_literal_block
      dbData.add(Result(category: "Posao", subCategory: result["name"], text: result["body"]));
    });
  });
  Future dbDataObitelj = FirebaseFirestore.instance.collection("Obitelj").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      // ignore: top_level_function_literal_block, top_level_function_literal_block
      dbData.add(Result(category: "Obitelj", subCategory: result["name"], text: result["body"]));
    });
  });
  Future dbDataStudiranje = FirebaseFirestore.instance.collection("Studiranje").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      // ignore: top_level_function_literal_block, top_level_function_literal_block
      dbData.add(Result(category: "Studiranje", subCategory: result["name"], text: result["body"]));
    });
  });
  Future dbDataVozila = FirebaseFirestore.instance.collection("Vozila").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      // ignore: top_level_function_literal_block, top_level_function_literal_block
      dbData.add(Result(category: "Vozila", subCategory: result["name"], text: result["body"]));
    });
  });
  Future dbDataOsiguranje = FirebaseFirestore.instance.collection("Osiguranje").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      // ignore: top_level_function_literal_block, top_level_function_literal_block
      dbData.add(Result(category: "Osiguranje", subCategory: result["name"], text: result["body"]));
    });
  });
  Future dbDataDrustveniZivot = FirebaseFirestore.instance.collection("Drustveni Život").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      // ignore: top_level_function_literal_block, top_level_function_literal_block
      dbData.add(Result(category: "Drustveni Život", subCategory: result["name"], text: result["body"]));
    });
  });
  Future dbDataLjudi = FirebaseFirestore.instance.collection("Naši Ljudi").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      // ignore: top_level_function_literal_block, top_level_function_literal_block
      dbData.add(Result(category: "Naši Ljudi", subCategory: result["name"], text: result["body"]));
    });
  });
  Future dbDataUredi = FirebaseFirestore.instance.collection("Uredi za strance").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      // ignore: top_level_function_literal_block, top_level_function_literal_block
      dbData.add(Result(category: "Uredi za strance", subCategory: result["name"], text: result["body"]));
    });
  });
  Future dbDataJezici = FirebaseFirestore.instance.collection("Jezici").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      // ignore: top_level_function_literal_block, top_level_function_literal_block
      dbData.add(Result(category: "Jezici", subCategory: result["name"], text: result["body"]));
    });
  });

//overriding of functionalities that search delegate already has, so tto customize it for ourselves

  @override
  List<Widget> buildActions(BuildContext context) {
    // actions to perform from appbar, in our case clear button to clear search
    return [
      IconButton(icon: Icon(Icons.clear), onPressed: () {
        query="";
      }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading part on the left of the appbar
    return IconButton(
        icon: AnimatedIcon(
          icon:AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // showing results based on the selection
    List<dynamic> resultListHelp = query.isEmpty ? [] : dbData.where((p) =>p.text.toLowerCase().contains(query.toLowerCase())).toList();
    List<dynamic> resultList = LinkedHashSet.from(resultListHelp).toList();

    return ListView.builder(itemBuilder: (context, i) => ListTile(
      title: Text(resultList[i].subCategory),
      subtitle: Text(resultList[i].category),
      onTap: (){
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new SubcategoryDetails(subcategory: resultList[i].subCategory, textBody: resultList[i].text,)));
      },
    ),
      itemCount: resultList.length,
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // what to show when someone is searching
    final resultListHelp = query.isEmpty ? [] : dbData.where((p) =>p.text.toLowerCase().contains(query.toLowerCase())).toList();
    List<dynamic> resultList =[];

    return ListView.builder(itemBuilder: (context, i) => ListTile(
      title: Text(resultList[i].subCategory),
      subtitle: Text(resultList[i].category),
      onTap: (){
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) => new SubcategoryDetails(subcategory: resultList[i].subCategory, textBody: resultList[i].text,)));
      },
    ),
      itemCount: resultList.length,
    );
  }

}

class Result{
  final category;
  final subCategory;
  final text;

  Result({
    this.category,
    this.subCategory,
    this.text
  });
}