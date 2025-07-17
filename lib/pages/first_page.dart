import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/pages/second_page.dart';
import 'package:suitmedia_test/provider/user_provider.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController palindromeController = TextEditingController();

  bool isPalindrome(String input) {
    String cleanInput = input.replaceAll(' ', '').toLowerCase();
    String reversed = cleanInput.split('').reversed.join('');
    return cleanInput == reversed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ic_photo@2x.png',
              height: 116,
              width: 116,
            ),
            const SizedBox(height: 20),
            widgetName(),
            const SizedBox(height: 30),
            palindromeText(),
            const SizedBox(height: 30),
            buttonCheck(),
            const SizedBox(height: 30),
            buttonNextPage(),
          ],
        ),
      ),
    ));
  }

  Widget widgetName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextField(
        controller: nameController,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Name',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget palindromeText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextField(
        controller: palindromeController,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Palindrome',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget buttonCheck() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff2B637B),
          minimumSize: const Size(
            320,
            50,
          )),
      onPressed: () {
        String input = palindromeController.text;
        bool result = isPalindrome(input);
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Hasil'),
                  content: Text(result ? 'Palindrome' : 'Bukan Palindrome'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Ok'))
                  ],
                ));
      },
      child: const Text(
        'CHECK',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget buttonNextPage() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff2B637B),
          minimumSize: const Size(
            320,
            50,
          )),
      onPressed: () {
        Provider.of<UserProvider>(context, listen: false)
            .setName(nameController.text);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const SecondPage();
            },
          ),
        );
      },
      child: const Text(
        'NEXT',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
