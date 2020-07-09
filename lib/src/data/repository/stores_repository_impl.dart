import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterclonethecoffeehouse/src/data/models/store_repository.dart';
import 'package:flutterclonethecoffeehouse/src/data/repository/stores_repository.dart';

class StoresRepositoryImp implements StoresRepository {
  final storesCollection = Firestore.instance.collection('stores');

  @override
  Future<List<StoreResponseRepository>> getStores() async {
    try {
      var stores = await storesCollection.getDocuments();
      if (stores.documents.isNotEmpty) {
//        debugPrint('test getStore');
//        stores.documents?.forEach((s) => debugPrint(s.data.toString()));
//        debugPrint('test getStore');
        return stores?.documents
            ?.map((snap) => StoreResponseRepository?.fromJson(
                id: snap.documentID, json: snap.data))
            ?.toList();
      }
    } catch (e) {
      debugPrint('getStores: ${e.toString()}');
    }
    return [];
  }
}
