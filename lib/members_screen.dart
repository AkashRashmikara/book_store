import 'package:flutter/material.dart';
import 'member_detail_screen.dart';

class Member {
  final String name;
  final String email;
  final String image;
  final String description;

  Member({
    required this.name,
    required this.email,
    required this.image,
    required this.description,
  });
}

class MembersScreen extends StatefulWidget {
  const MembersScreen({super.key});

  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  final List<Member> _members = [
    Member(
      name: 'Akash Rashmikara',
      email: 'akashrashmikara@gmail.com',
      image: 'assets/photo.png',
      description: 'Description of Member 1',
    ),
    Member(
      name: 'Sajith Premadasa',
      email: 'sajith@gmail.com',
      image: 'assets/sajith.png',
      description: 'Description of Member 2',
    ),
    Member(
      name: 'Anura Kumara',
      email: 'anurakumara@gmail.com',
      image: 'assets/anura.png',
      description: 'Description of Member 2',
    ),
    Member(
      name: 'Mahinda Rajapaksha',
      email: 'mahindarajapaksha@gmail.com',
      image: 'assets/mahinda.png',
      description: 'Description of Member 2',
    ),
  ];

  List<Member> _filteredMembers = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredMembers = _members;
    _searchController.addListener(_filterMembers);
  }

  void _filterMembers() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMembers = _members.where((member) {
        return member.name.toLowerCase().contains(query) ||
            member.email.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _showAddMemberDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController imageController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a Member'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: imageController,
                  decoration: const InputDecoration(labelText: 'Profile Picture URL'),
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
                setState(() {
                  _members.add(Member(
                    name: nameController.text,
                    email: emailController.text,
                    image: imageController.text,
                    description: descriptionController.text,
                  ));
                  _filterMembers();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Submit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 8, 113, 36),
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
        title: const Text('Members List',
        style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 49, 58, 66),
                              fontWeight: FontWeight.bold,
                            ),),
        backgroundColor: Color.fromARGB(255, 160, 212, 5),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for members...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: _filteredMembers.length,
          itemBuilder: (context, index) {
            final member = _filteredMembers[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemberDetailScreen(member: member),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: member.image.startsWith('assets/')
                          ? Image.asset(
                              member.image,
                              height: 170,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              member.image,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Text(
                            member.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            member.email,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 96, 96, 96),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMemberDialog,
        backgroundColor: const Color.fromARGB(255, 160, 212, 5),
        child: const Icon(Icons.add, color: Color.fromARGB(255, 49, 58, 66)),
      ),
    );
  }
}
