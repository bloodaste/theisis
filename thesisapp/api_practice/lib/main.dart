import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multipages_app/classes/loader.dart';
import 'package:multipages_app/classes/pokemonmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Pokemon(),
    );
  }
}

class Pokemon extends StatefulWidget {
  const Pokemon({super.key});

  @override
  State<Pokemon> createState() => _PokemonState();
}

class _PokemonState extends State<Pokemon> {
  List<Model> decodefunction = [];
  List<String> images = [];
  bool isLoading = true; // Indicates loading state

  @override
  void initState() {
    super.initState();
    gettingPokemonApi();
  }

  Future<void> gettingPokemonApi() async {
    setState(() {
      isLoading = true; // Start loading
    });

    const url =
        'https://pokeapi.co/api/v2/pokemon?limit=50&offset=0'; // Fetch 50 instead of 100000
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      List<dynamic> result = json['results'];

      setState(() {
        decodefunction = result.map((e) => Model.fromJson(e)).toList();
        images = List.generate(decodefunction.length, (index) {
          return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png";
        });
        isLoading = false; // Stop loading
      });
    } else {
      setState(() {
        isLoading = true; // Stop loading on error
      });
      throw Exception("Failed to load Pokémon data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon API Integration'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? const Center(child: Loader()) // Show loader while fetching data
          : ListView.builder(
              itemCount: decodefunction.length,
              addAutomaticKeepAlives: false,
              itemBuilder: (context, index) {
                final pokemon = decodefunction[index];
                final image = images[index];

                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  color: Colors.blue[400],
                  child: Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image.network(image,
                              errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.image);
                          }),
                          title: Text(pokemon.name),
                          subtitle: Text(pokemon.url),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('sasa'),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: gettingPokemonApi, // Reload data
        child: const Icon(Icons.refresh),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Default to Home
        selectedItemColor: Colors.green,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
