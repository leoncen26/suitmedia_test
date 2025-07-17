import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/pages/third_page.dart';
import 'package:suitmedia_test/provider/user_provider.dart';

// ignore: must_be_immutable
class SecondPage extends StatefulWidget {

  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  double? deviceHeight;
  String? selectedUser;
  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    final userProv = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Color(0xff554AF0),)),
        title: const Text('Seccond Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Welcome '),
            Text(
              userProv.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: deviceHeight! * 0.30),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    selectedUserName(),
                    buttonChooseUser(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget selectedUserName() {
    final userProv = Provider.of<UserProvider>(context);
    return Text(
      userProv.selectedUser,
      style: const TextStyle(fontSize: 20),
    );
  }

  Widget buttonChooseUser() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff2B637B),
            minimumSize: const Size(
              310,
              40,
            )),
        onPressed: () async{
          final userName = await Navigator.push(context, MaterialPageRoute(builder: (context){
            return const ThirdPage();

          }));
          if(userName != null){
            setState(() {
              selectedUser = userName;
            });
          }
        },
        child: const Text(
          'Choose a User',
          style: TextStyle(
            color: Colors.white,
          ),
        ));
  }
}
