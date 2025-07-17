import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia_test/model/user_model.dart';
import 'package:suitmedia_test/provider/user_provider.dart';
import 'package:suitmedia_test/services/fetch_data_user.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  final ScrollController scrollController = ScrollController();
  List<User> users = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;

  Future<void> fetchInitialData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await fetchUser(1);
      setState(() {
        users = data;
        currentPage = 1;
        hasMore = data.length == 10;
      });
    } catch (_) {}
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchMoreData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final data = await fetchUser(currentPage + 1);
      setState(() {
        users.addAll(data);
        currentPage++;
        hasMore = data.length == 10;
      });
    } catch (_) {}
    setState(() {
      isLoading = false;
    });
  }

  Future<void> refreshUsers() async {
    await fetchInitialData();
  }

  @override
  void initState() {
    super.initState();
    fetchInitialData();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.minScrollExtent - 200 &&
          !isLoading &&
          hasMore) {
        fetchMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xff554AF0),
          ),
        ),
        title: const Text('Third Screen'),
        centerTitle: true,
        bottom: PreferredSize(preferredSize: const Size.fromHeight(1.0), child: Container(
          color: Colors.grey,
          height: 1,
        )),
      ),
      body: RefreshIndicator(
        onRefresh: refreshUsers,
        child: users.isEmpty && !isLoading
            ? const Center(child: Text('Tidak ada data'))
            : ListView.builder(
                controller: scrollController,
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == users.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final user = users[index];
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar),),
                          title: Text(user.firstName + user.lastName),
                          subtitle: Text(user.email),
                          onTap: (){
                            Provider.of<UserProvider>(context, listen: false).setSelectedName(user.firstName + user.lastName);
                            Navigator.pop(context);
                          },
                        ),
                         const Divider(
                          thickness: 0.5,
                          indent: 16,
                          endIndent: 16,
                          color: Colors.grey,
                         )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
