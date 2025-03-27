import 'package:flutter/material.dart';
import 'quote_function.dart';

void main() {
  runApp(MaterialApp(home: Quotes()));
}

void decrement(q) {
  if (q['qtn'] > 0) {
    q['qtn'] = q['qtn'] - 1;
  }
}

class Quotes extends StatefulWidget {
  const Quotes({super.key});

  @override
  State<Quotes> createState() => _QuotesState();
}

class _QuotesState extends State<Quotes> {
  List<Aqua> quote = [
    Aqua(name: 'item 1', song: "tinidor", qtn: 5),
    Aqua(name: 'item 2', song: "kutsara", qtn: 2),
    Aqua(name: 'item 3', song: "bowl", qtn: 4),
    Aqua(name: 'item 4', song: "kawali", qtn: 5),
  ];

  // Widget cardtemplate(q) {
  //   return QuouteCard(q: q);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[300],
        appBar: AppBar(
          title: Text('Inventory information'),
          backgroundColor: Colors.green[500],
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: quote
                  .map((q) => QuouteCard(
                      q: q,
                      delete: () {
                        setState(() {
                          quote.remove(q);
                        });
                      },
                      minus: () {
                        setState(() {
                          q.qtn == q.qtn! - 1;
                        });
                      },
                      add: () {
                        setState(() {
                          q.qtn == q.qtn! - 1;
                        });
                      }))
                  .toList(),
            ),
          ),
        ));
  }
}

class QuouteCard extends StatelessWidget {
  const QuouteCard(
      {super.key,
      required this.q,
      required this.delete,
      required this.minus,
      required this.add});
  final Function delete;
  final dynamic q;
  final Function minus;
  final Function add;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text(q.song,
                    style: TextStyle(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 172, 50, 50))),
                SizedBox(
                  height: 5.5,
                ),
                Text(
                  q.name,
                  style: TextStyle(fontSize: 20, color: Colors.green),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  q.qtn.toString(),
                  style: TextStyle(color: Colors.orangeAccent, fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        delete();
                        print('data been deleted');
                      },
                      label: Text('delete'),
                      icon: Icon(Icons.delete),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        minus();
                      },
                      icon: Icon(Icons.remove),
                      label: Text('add'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        add();
                      },
                      label: Text('minus'),
                      icon: Icon(Icons.remove),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
