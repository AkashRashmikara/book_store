import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'book_detail_screen.dart';

class Book {
  final String title;
  final String author;
  final String image;
  final String price;
  final String description;
  double rating;
  List<Comment> comments;

  Book({
    required this.title,
    required this.author,
    required this.image,
    required this.price,
    required this.description,
    this.rating = 0.0,
    this.comments = const [],
  });
}

class Comment {
  final String user;
  final String text;
  final bool liked;

  Comment({required this.user, required this.text, this.liked = false});
}

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key});

  @override
  _BooksScreenState createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final List<Book> _books = [
    Book(
      title: 'Magul Kama',
      author: 'Kumarathunga Munidasa',
      image: 'assets/magulkama.jpeg',
      price: "Rs:400.00",
      description:
          "Magul Kama is a Sinhala children's story book. The English translation, The Wedding Feast, is available for readers aged 8–10 and up.",
    ),
    Book(
      title: 'Gamperaliya',
      author: 'Martin Wickramasinghe',
      image: 'assets/gamperaliya.jpg',
      price: "Rs:800.00",
      description:
          "Gamperaliya is about the gradual decline of traditional village life in Sri Lanka due to modernization. The story follows an aristocratic family in a southern village and how their lives change as the commercial culture of the city replaces the village's traditional economic and social structure.",
    ),
    Book(
      title: 'Madol Doowa',
      author: 'Martin Wickramasinghe',
      image: 'assets/madolduwa.jpg',
      price: "Rs:750.00",
      description:
          "Madol Duwa is a children's novel by Martin Wickramasinghe that was translated into English. The title translates to 'island of mangroves' in Sinhala. ",
    ),
    Book(
      title: 'Amba Yahaluwo',
      author: 'T. B. Ilangarathne',
      image: 'assets/ambayahaluwo.jpg',
      price: "Rs:500.00",
      description:
          "Amba Yahaluwo translates to 'The Best of Friends' in English. It is a Sinhala novel written by Tikiri Bandara Ilangaratne in 1957. The English translation was published in 1998 by Seneviratne B. Aludeniya. Amba Yahaluwo is about two friends, Nimal and Sunil, who are inseparable and don't care about social barriers. The story is about their courage and resolve to stay together through life's vicissitudes. ",
    ),
    Book(
      title: 'Ape Gama',
      author: 'Martin Wickramasinghe',
      image: 'assets/apegama.jpg',
      price: "Rs:600.00",
      description:
          "Ape Gama is a semi-autobiographical book by Martin Wickramasinghe, a Sri Lankan author. The book was originally published in Sinhala in 1940 and translated into English in 1968 as Lay Bare the Roots. The book is about the author's childhood experiences in Sri Lanka's Southern Province.",
    ),
    Book(
      title: 'Manuthapaya',
      author: 'I. M. R. E. Iriyagolla',
      image: 'assets/manuthapaya.jpeg',
      price: "Rs:900.00",
      description:
          'Manuthapaya was a popular translation of Les Misérables among readers. Iriyagolle was a writer, journalist, and translator who was fluent in both Sinhala and English. He also wrote songs like "Loken Uthum Rata Lankavai" and "Sema Danamana Dinu Sujathadarani". ',
    ),
  ];

  List<Book> _filteredBooks = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredBooks = _books;
    _searchController.addListener(_filterBooks);
  }

  void _filterBooks() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredBooks = _books.where((book) {
        return book.title.toLowerCase().contains(query) ||
            book.author.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _addBook(String title, String author, String image, String description,
      String price) {
    setState(() {
      _books.add(Book(
        title: title,
        author: author,
        image: image,
        price: price,
        description: description,
      ));
      _filterBooks();
    });
  }

  void _showAddBookDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController authorController = TextEditingController();
    final TextEditingController imageController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a new book'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: authorController,
                  decoration: const InputDecoration(labelText: 'Author'),
                ),
                TextField(
                  controller: imageController,
                  decoration:
                      const InputDecoration(labelText: 'Cover Image URL'),
                ),
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _addBook(
                  titleController.text,
                  authorController.text,
                  imageController.text,
                  priceController.text,
                  descriptionController.text,
                );
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Books List',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromARGB(255, 49, 58, 66),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 160, 212, 5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search by title or author',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.6,
                ),
                itemCount: _filteredBooks.length,
                itemBuilder: (context, index) {
                  final book = _filteredBooks[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailScreen(book: book),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 5,
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.asset(
                              book.image,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 10.0,
                            right: 10.0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                book.price,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 140.0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                              child: Text(
                                book.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 150),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 60),
                                    Text(
                                      book.author,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color.fromARGB(255, 45, 45, 45),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 5),
                                    RatingBar.builder(
                                      initialRating: book.rating,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 18.0,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        setState(() {
                                          book.rating = rating;
                                        });
                                      },
                                    ),
                                    const SizedBox(height: 5),
                                    ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content:
                                                    Text('Added to cart!')));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 160, 212, 5),
                                      ),
                                      child: const Text('Add to Cart'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
      ),
    );
  }
}
