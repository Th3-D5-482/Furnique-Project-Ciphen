import 'package:firebase_database/firebase_database.dart';

final DatabaseReference dbRefHome = FirebaseDatabase.instance.ref();

Future<List<Map<String, dynamic>>> getCategories() async {
  final DataSnapshot snapshot = await dbRefHome.child('Categories').get();
  List<Map<String, dynamic>> exisitngCategories = [];
  if (snapshot.exists) {
    List<dynamic> values = snapshot.value as List<dynamic>;
    for (var value in values) {
      exisitngCategories.add({
        'id': value['id'],
        'catName': value['catName'],
        'imageUrl': value['imageUrl'],
      });
    }
  }
  return exisitngCategories;
}

Future<List<Map<String, dynamic>>> getBanners() async {
  final DataSnapshot snapshot = await dbRefHome.child('Banners').get();
  List<Map<String, dynamic>> exisitingBanner = [];
  if (snapshot.exists) {
    List<dynamic> values = snapshot.value as List<dynamic>;
    for (var value in values) {
      exisitingBanner.add({
        'id': value['id'],
        'text1': value['text1'],
        'text2': value['text2'],
        'text3': value['text3'],
        'imageUrl': value['imageUrl'],
      });
    }
  }
  return exisitingBanner;
}

Stream<List<Map<String, dynamic>>> getFurnitures() async* {
  yield* dbRefHome.child('Furnitures').onValue.map((event) {
    final DataSnapshot snapshot = event.snapshot;
    List<Map<String, dynamic>> exisitingFurniture = [];
    if (snapshot.exists) {
      List<dynamic> values = snapshot.value as List<dynamic>;
      for (var value in values) {
        exisitingFurniture.add({
          'id': value['id'],
          'catID': value['catID'],
          'furName': value['furName'],
          'imageUrl': value['imageUrl'],
          'price': value['price'],
          'isPopular': value['isPopular'],
          'ratings': value['ratings'],
          'description': value['description'],
          'isFavorite': value['isFavorite'],
        });
      }
    }
    return exisitingFurniture;
  });
}
