import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/item.dart';

class ItemService {
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('items');

  // CREATE — add a new item
  Future<void> addItem(Item item) async {
    await _ref.add(item.toMap());
  }

  // READ — real-time stream of all items
  Stream<List<Item>> streamItems() {
    return _ref
        .orderBy('name')
        .snapshots()
        .map((snap) => snap.docs
            .map((d) => Item.fromMap(d.id, d.data() as Map<String, dynamic>))
            .toList());
  }

  // UPDATE — overwrite fields of an existing item
  Future<void> updateItem(Item item) async {
    await _ref.doc(item.id).update(item.toMap());
  }

  // DELETE — remove an item by its Firestore document ID
  Future<void> deleteItem(String id) async {
    await _ref.doc(id).delete();
  }
}