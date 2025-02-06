import 'package:flutter/material.dart';
import 'books_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BookDetailScreen extends StatefulWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        backgroundColor: const Color.fromARGB(255, 160, 212, 5),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        widget.book.image,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.book.title,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Author: ${widget.book.author}',
                    style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  RatingBar.builder(
                    initialRating: widget.book.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 30.0,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Color.fromARGB(255, 160, 212, 5),
                    ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        widget.book.rating = rating;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.book.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),

                  const SizedBox(height: 20),

                  /// **Added Download PDF & Add to Cart Buttons**
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          // Add PDF Download functionality here
                        },
                        icon: const Icon(Icons.picture_as_pdf),
                        label: const Text('Download PDF'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 160, 212, 5),
                          foregroundColor: const Color.fromARGB(255, 45, 45, 45),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Add to Cart functionality here
                        },
                        icon: const Icon(Icons.shopping_cart),
                        label: const Text('Add to Cart'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 160, 212, 5),
                          foregroundColor: const Color.fromARGB(255, 45, 45, 45),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  const Text(
                    'Comments',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.book.comments.length,
                    itemBuilder: (context, index) {
                      final comment = widget.book.comments[index];
                      return ListTile(
                        title: Text(comment.user),
                        subtitle: Text(comment.text),
                        trailing: Icon(
                          comment.liked ? Icons.thumb_up : Icons.thumb_down,
                          color: comment.liked ? Colors.green : Colors.red,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Add a comment',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (text) {
                      setState(() {
                        widget.book.comments.add(Comment(user: 'Akash', text: text, liked: true));
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
