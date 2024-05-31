import 'package:flutter/material.dart';
import 'package:flutter_contact/user_page.dart';
import 'package:flutter_contact/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = UserService().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Pengguna')),
        body: Center(
          child: FutureBuilder<List<User>>(
            future: futureUsers,
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    User user = snapshot.data?[index];
                    return ListTile(
                      title: Text('${user.name.first} ${user.name.last}'),
                      subtitle: Text(user.email),
                      trailing: const Icon(Icons.chevron_right_outlined),
                      onTap: (() => openPage(context, user)),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(color: Colors.black26);
                  },
                  itemCount: snapshot.data!.length,
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }),
          ),
        ));
  }

  openPage(context, User user) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserPage(user: user)));
  }
}
