import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/description.dart';

class TvWidget extends StatefulWidget {
  final List? tvShows;

  const TvWidget({Key? key, this.tvShows}) : super(key: key);

  @override
  _TvWidgetState createState() => _TvWidgetState();
}

class _TvWidgetState extends State<TvWidget> {
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
                    duration: Duration(milliseconds: 1000),
                  );
                },
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Top TV Shows",
                  style: GoogleFonts.lusitana(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8),
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
              itemCount: widget.tvShows?.length ?? 0,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final tvShow = widget.tvShows![index];
                if (tvShow['original_name'] == null) {
                  return SizedBox.shrink();
                }
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Description(
                          name: tvShow['original_name'] ?? 'Loading',
                          description:
                              tvShow['overview'] ?? 'No description available',
                          bannerurl: 'https://image.tmdb.org/t/p/w500' +
                              (tvShow['backdrop_path'] ?? ''),
                          posterurl: 'https://image.tmdb.org/t/p/w500' +
                              (tvShow['poster_path'] ?? ''),
                          vote: tvShow['vote_average']?.toString() ?? 'N/A',
                          launch_on: tvShow['first_air_date'] ?? 'N/A',
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 140,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500' +
                                    (tvShow['poster_path'] ?? ''),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          tvShow['original_name'] ?? 'Loading',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.lusitana(
                            fontSize: 16,
                            color: Colors.white,
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
