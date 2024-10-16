import 'package:ciphen/constants/popular.dart';
import 'package:ciphen/database/homedb.dart';
import 'package:ciphen/screens/description_page.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final int id;
  final String catName;
  const CategoryPage({
    super.key,
    required this.id,
    required this.catName,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Stream<List<Map<String, dynamic>>> funitureStream;

  @override
  void initState() {
    super.initState();
    funitureStream = getFurnitures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: funitureStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          final furnitures = snapshot.data!;
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 28,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Category: ${widget.catName}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: GridView.builder(
                      itemCount: furnitures
                          .where((furniture) => furniture['catID'] == widget.id)
                          .toList()
                          .length,
                      scrollDirection: Axis.vertical,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.57,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final furnitureItem = furnitures
                            .where(
                                (furniture) => furniture['catID'] == widget.id)
                            .toList()[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return DescriptionPage(
                                  id: furnitureItem['id'],
                                  catID: furnitureItem['catID'],
                                  ratings: furnitureItem['ratings'],
                                  imageUrl: furnitureItem['imageUrl'],
                                  furName: furnitureItem['furName'],
                                  price: furnitureItem['price'],
                                  description: furnitureItem['description'],
                                  isFavorite: furnitureItem['isFavorite'],
                                );
                              },
                            ));
                          },
                          child: Card(
                            child: Popular(
                              imageUrl: furnitureItem['imageUrl'],
                              furName: furnitureItem['furName'],
                              price: furnitureItem['price'],
                              isFavorite: furnitureItem['isFavorite'],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
