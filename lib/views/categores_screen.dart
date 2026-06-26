import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_news_app/models/categories_news_model.dart';
import 'package:my_news_app/view_model/news_view_model.dart';
import 'package:my_news_app/views/home_screen.dart';

class CategoresScreen extends StatefulWidget {
  const CategoresScreen({super.key});

  @override
  State<CategoresScreen> createState() => _CategoresScreenState();
}

class _CategoresScreenState extends State<CategoresScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  String categoryName = 'General';

  List<String> categoisList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;

    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(
              height: 50,

              child: ListView.builder(
                scrollDirection: Axis.horizontal,

                itemCount: categoisList.length,

                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      categoryName = categoisList[index];

                      setState(() {});
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: categoryName == categoisList[index]
                              ? Colors.green
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),

                          child: Center(
                            child: Text(
                              categoisList[index].toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: height * 0.03),

            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriNewmodel(categoryName),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCircle(size: 50, color: Colors.blue),
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.articles!.length,

                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                height: height * .18,
                                width: width * .3,
                                imageUrl: snapshot
                                    .data!
                                    .articles![index]
                                    .urlToImage
                                    .toString(),

                                fit: BoxFit.cover,

                                placeholder: (context, url) =>
                                    Container(child: spinkit2),

                                errorWidget: (context, url, error) => Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
