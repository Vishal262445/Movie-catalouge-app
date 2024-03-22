import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/utils/text.dart';

class TopRated extends StatefulWidget {
  final List? topRated;

  const TopRated({Key? key, this.topRated}) : super(key: key);

  @override
  _TopRatedState createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  _controller.animateTo(
                    _controller.offset - MediaQuery.of(context).size.width,
                    curve: Curves.easeOut,
                    duration: Duration(milliseconds: 300),
                  );
                },
              ),
              SizedBox(width: 8), // Add a SizedBox for spacing
              Expanded(
                child: Text(
                  "Top Rated Movies",
                  style: GoogleFonts.lusitana(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8), // Add a SizedBox for spacing
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  _controller.animateTo(
                    _controller.offset + MediaQuery.of(context).size.width,
                    curve: Curves.easeOut,
                    duration: Duration(milliseconds: 300),
                  );
                },
              ),
            ],
          ),
          Container(
            height: 270,
            child: ListView.builder(
              controller: _controller,
              itemCount: widget.topRated?.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = widget.topRated![index];
                return InkWell(
                  onTap: () {},
                  child: Container(
                    width: 140,
                    child: Column(
                      children: [
                        Container(
                          height: 135,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500' +
                                    (movie['poster_path'] ?? ''),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: modified_text(
                            text: movie['title'] ?? 'Loading',
                            color: Colors.black, // You can specify a color
                            size: 16, // You can specify the size
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
