import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting
import 'package:newsapp/utils/imagegetter.dart';
import 'package:url_launcher/link.dart';

class NewsDetails extends StatelessWidget {
  final String? author;
  final String? title;
  final String? desc;
  final String imageurl;
  final String? content;
  final String? url;
  final String? date;

  const NewsDetails({
    super.key,
    required this.author,
    required this.date,
    required this.title,
    required this.desc,
    required this.imageurl,
    required this.content,
    required this.url,
  });

  String formatDate(String dateTime) {
    final DateTime parsedDate = DateTime.parse(dateTime);
    final DateFormat formatter = DateFormat('yyyy-MM-dd'); 
    return formatter.format(parsedDate);
  }
  String formatTime(String publishedAt) {
    final DateTime parsedTime = DateTime.parse(publishedAt);
    final DateFormat formatter = DateFormat('HH:mm'); 
    return formatter.format(parsedTime);
  }
  @override
  Widget build(BuildContext context) {
    print(imageurl);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
  height: 300,
  width: 300,
  decoration: BoxDecoration(
    image: DecorationImage(
      image: ImageProviderUtil.getImageProvider(imageurl, "assets/Image.jpg"),
      fit: BoxFit.cover,
    ),
    boxShadow: const [
      BoxShadow(color: Colors.red, blurRadius: 20, blurStyle: BlurStyle.outer, spreadRadius: 30),
    ],
    border: const Border(
      right: BorderSide(color: Colors.red, width: 3),
      left: BorderSide(color: Colors.red, width: 3),
      bottom: BorderSide(color: Colors.red, width: 3),
    ),
    borderRadius: const BorderRadius.only(
      bottomLeft: Radius.circular(40),
      bottomRight: Radius.circular(40),
    ),
  ),
  clipBehavior: Clip.antiAlias,
),

              ),
              const SizedBox(height: 40),
               Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      author != null ? author.toString() : "author",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                 
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                      formatDate(date != null ? date.toString() : "date" ) ,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        formatTime(date != null ? date.toString() : "time") , 
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                      ],
                    )
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title != null ? title.toString() : "title",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  desc != null ? desc.toString() : "desc",
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  content != null ? content.toString() : "Content",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Link(
                  uri: Uri.parse(url != null ? url.toString() : "url" ),
                  builder: (context, followLink) => GestureDetector(
                    onTap: followLink,
                    child: const Text(
                      "Click for more details",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue, 
                        decoration: TextDecoration.underline, 
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
