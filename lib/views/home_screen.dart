import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_news_app/models/news_channels_headlines_model.dart';
import 'package:my_news_app/view_model/news_view_model.dart';
import 'package:my_news_app/views/categores_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum Filterlist { bbcNews, aryNews, independent, reuters, cnn, aljazeera }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  Filterlist? selectedMenu;

  String name = 'bbc-news';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;

    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CategoresScreen()),
            );
          },
          icon: Image.asset('images/category_icon.png', height: 30, width: 30),
        ),
        title: Center(
          child: Text(
            'News',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),

            textAlign: TextAlign.center,
          ),
        ),

        actions: [
          PopupMenuButton<Filterlist>(
            initialValue: selectedMenu,

            color: Colors.green.shade400,
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (Filterlist item) {
              setState(() {
                selectedMenu = item;

                if (item == Filterlist.bbcNews)
                  name = 'bbc-news';
                else if (item == Filterlist.aryNews)
                  name = 'ary-news';
              });
            },

            itemBuilder: (BuildContext context) => <PopupMenuEntry<Filterlist>>[
              PopupMenuItem<Filterlist>(
                value: Filterlist.bbcNews,

                child: Text('BBC News'),
              ),

              PopupMenuItem<Filterlist>(
                value: Filterlist.aryNews,

                child: Text('Ary News'),
              ),

              PopupMenuItem<Filterlist>(
                value: Filterlist.aljazeera,

                child: Text('aljazeera'),
              ),

              PopupMenuItem<Filterlist>(
                value: Filterlist.independent,
                child: Text('Independent'),
              ),

              PopupMenuItem<Filterlist>(
                value: Filterlist.reuters,
                child: Text('Reuters'),
              ),
            ],
          ),
        ],
      ),

      body: ListView(
        children: [
          SizedBox(
            child: Container(
              height: height * .5,

              width: width,

              child: FutureBuilder<NewsChanelsHeadlinesModel>(
                key: ValueKey(name),
                future: newsViewModel.fetchNewsChannelHeadlines(name),
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
                        return SizedBox(
                          child: Stack(
                            alignment: Alignment.center,

                            children: [
                              Container(
                                height: height * .4,
                                width: width * .9,

                                padding: EdgeInsets.symmetric(
                                  vertical: width * 0.01,
                                ),
                                child: ClipRRect(
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
                              ),

                              Positioned(
                                bottom: 0,
                                child: Card(
                                  elevation: 5,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),

                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      height: height * .22,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: width * 0.6,

                                            child: Text(
                                              snapshot
                                                  .data!
                                                  .articles![index]
                                                  .title
                                                  .toString(),
                                              maxLines: 2,

                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),

                                          Spacer(),

                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .articles![index]
                                                      .source!
                                                      .name
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(width: width * 0.2),
                                                Text(
                                                  DateFormat(
                                                    'dd MMM yyyy',
                                                  ).format(
                                                    DateTime.parse(
                                                      snapshot
                                                          .data!
                                                          .articles![index]
                                                          .publishedAt
                                                          .toString(),
                                                    ),
                                                  ),

                                                  maxLines: 2,

                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(color: Colors.amber);
