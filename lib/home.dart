import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wallpaper/wallpaper_screen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List imageList = [];
  int page = 1;
  bool _isloading = true;

  Future<void> getimage() async {
    await get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=80&page=$page"),
        headers: {
          "Authorization":
              "74Ht4wJPwFIrBPFgNJ7dAg2X1nhwekvkD98k0W7xNCZ0BXDxfSPlLZGn"
        }).then((value) {
      Map json = jsonDecode(value.body);

      setState(() {
        imageList = json["photos"];
        _isloading = false;
      });
    });
  }

  @override
  void initState() {
    getimage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isloading = true;
            page++;
          });
          getimage();
        },
        child: const Icon(Icons.refresh),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: _isloading
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                    childAspectRatio: 2 / 3),
                itemCount: 80,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => wallpaperScreen(
                                imageList[index]['src']['large2x']),
                          ));
                    },
                    child: Container(
                      color: Colors.white60,
                      child: Image.network(
                        imageList[index]['src']['tiny'],
                        fit: BoxFit.cover,
                      ),
                      // color: Colors.teal[100],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
