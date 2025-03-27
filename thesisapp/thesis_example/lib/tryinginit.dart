import 'package:flutter/material.dart';

class QWER extends StatefulWidget {
  const QWER({super.key});

  @override
  State<QWER> createState() => _QWERState();
}

class _QWERState extends State<QWER> {
  @override
  void initState() {
    super.initState();

    print('init state');
  }

  int yearlevel = 1;
  @override
  Widget build(BuildContext context) {
    print('initstate');
    return Scaffold(
      backgroundColor: Colors.blue[500],
      appBar: AppBar(
        title: Text('new project'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/pic3.jpg'),
                radius: 50,
              ),
            ),
            Divider(
              color: Colors.green,
              thickness: 5,
            ),
            Text(
              'NAME',
              style: TextStyle(
                letterSpacing: 2,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Kurt Andrei',
              style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.black,
                  fontFamily: 'okay',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              color: Colors.amber,
              child: (Text(
                'Section',
                style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              )),
            ),
            SizedBox(height: 5),
            Text(
              'current year $yearlevel',
              style: TextStyle(
                  letterSpacing: 2,
                  color: Colors.black,
                  fontFamily: 'okay',
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'email me ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'okay',
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.email,
                  color: Colors.white,
                  size: 40,
                ),
              ],
            ),
            SizedBox(height: 10),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      yearlevel++;
                      print('$yearlevel');
                    });
                  },
                  label: Text('add'),
                  icon: Icon(
                    Icons.add,
                    size: 20,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      iconColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                ),
                ElevatedButton.icon(
                  label: Text('minus'),
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    Navigator.pushNamed(context, 'morefile');
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      iconColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10)),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
