import 'package:api_series/request/fetch_show_details.dart';
import 'package:api_series/widgets/custom_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowDetailsPage extends StatefulWidget {
  final int id;
  final String? name;
  final String? description;
  final String? image_thumbnail_path;
  final String? country;
  final String? status;
  final String? network;
  final List? genres;

  const ShowDetailsPage({
    Key? key,
    required this.id,
    this.name,
    this.description,
    this.image_thumbnail_path,
    this.country,
    this.status,
    this.network,
    this.genres,
  }) : super(key: key);

  @override
  State<ShowDetailsPage> createState() => _ShowDetailsPageState();
}

class _ShowDetailsPageState extends State<ShowDetailsPage> {
  bool toggle = false;
  bool loading = false;
  num? ratingReview;
  String? first_name;
  final storeMessage = FirebaseFirestore.instance;
  CollectionReference userRef =
      FirebaseFirestore.instance.collection('reviews');
  final TextEditingController _reviewController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: <Color>[
              Color(0XFF101A26),
              Color(0XFF026873),
              Color(0xFF35F2DF)
            ])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) =>
                  [CustomAppbar()],
              body: SingleChildScrollView(
                  child: FutureBuilder<ShowDetails>(
                      future: fetchShowDetails(widget.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            children: [
                              Stack(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 400 / 451,
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data!.imageThumbnailPath),
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 410,
                                    width: 451,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.center,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Color(0xCC000000),
                                          Color(0x00000000),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(
                                        15, 335, 30, 2),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(snapshot.data!.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline2!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text(snapshot.data!.status,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.normal)),
                                            const SizedBox(width: 6),
                                            const Icon(Icons.circle,
                                                color: Colors.white, size: 6),
                                            const SizedBox(width: 6),
                                            Text(snapshot.data!.country,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.normal)),
                                            const SizedBox(width: 6),
                                            const Icon(Icons.circle,
                                                color: Colors.white, size: 6),
                                            const SizedBox(width: 6),
                                            Text(snapshot.data!.network,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.normal)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Container(
                                width: 350,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  color: Colors.grey[800],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Column(
                                    children: [
                                      ExpansionTile(
                                        title: Container(
                                          width: 350,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            color: Colors.grey[800],
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 120),
                                                child: Row(
                                                  children: [
                                                    Text("Synopsis",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline4!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 32),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      snapshot.data!.startDate,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5!
                                                          .copyWith(
                                                              color: Colors
                                                                  .grey[400]),
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      snapshot.data!.genres
                                                          .join(", "),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline5!
                                                          .copyWith(
                                                              color: Colors
                                                                  .grey[400]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        children: [
                                          Container(
                                            width: 350,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              color: Colors.grey[800],
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Text(
                                                snapshot.data!.description,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      height: 1.5,
                                                    ),
                                                textAlign: TextAlign.justify,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text("Rate ",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4),
                                                Text(
                                                  snapshot.data!.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4!
                                                      .copyWith(
                                                          color:
                                                              Colors.amber[300],
                                                          fontWeight:
                                                              FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  color: Colors.grey[350],
                                                  width: 205,
                                                  height: 1,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          RatingBar.builder(
                                            initialRating: 0.5,
                                            minRating: 0.5,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              ratingReview = rating;
                                            },
                                          ),
                                          const SizedBox(height: 10),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 50,
                                                      vertical: 16),
                                              child: TextField(
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                  controller: _reviewController,
                                                  decoration: InputDecoration(
                                                    enabledBorder:
                                                        const UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                    focusedBorder:
                                                        const UnderlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                    hintText:
                                                        'Review this show...',
                                                    hintStyle: Theme.of(context)
                                                        .textTheme
                                                        .headline5,
                                                    suffixIcon: IconButton(
                                                        onPressed: () async {
                                                          if (_reviewController
                                                              .text
                                                              .isNotEmpty) {
                                                            final reviewDoc =
                                                                storeMessage
                                                                    .collection(
                                                                        "reviews")
                                                                    .doc();
                                                            await reviewDoc
                                                                .set({
                                                              "review_text":
                                                                  _reviewController
                                                                      .text
                                                                      .trim(),
                                                              "first_name":
                                                                  first_name,
                                                              "rating":
                                                                  ratingReview,
                                                            });
                                                            _reviewController
                                                                .clear();
                                                          }
                                                        },
                                                        icon: const Icon(
                                                            Icons.send,
                                                            color:
                                                                Colors.amber)),
                                                  )))
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        return const Center(child: CircularProgressIndicator());
                      })),
            )));
  }
}