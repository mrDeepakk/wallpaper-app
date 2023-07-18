// ignore_for_file: camel_case_types
import 'dart:async';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

// ignore: must_be_immutable
class wallpaperScreen extends StatelessWidget {
  String imgUrl = '';
  late String result;
  wallpaperScreen(this.imgUrl, {super.key});
  // ignore: non_constant_identifier_names
  Future<void> SetLockWallpaper() async {
    var file = await DefaultCacheManager().getSingleFile(imgUrl);
// Platform messages may fail, so we use a try/catch PlatformException.
    // String result;
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
        goToHome: true,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
  }

  Future<void> SetHomeWallpaper() async {
    var file = await DefaultCacheManager().getSingleFile(imgUrl);
// Platform messages may fail, so we use a try/catch PlatformException.
    // String result;
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
        goToHome: true,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
  }

  Future<void> SetBothWallpaper() async {
    var file = await DefaultCacheManager().getSingleFile(imgUrl);
// Platform messages may fail, so we use a try/catch PlatformException.
    // String result;
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: file.path,
        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
        goToHome: true,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60, left: 7, right: 7),
              child: SizedBox(
                height: 45,
                child: ElevatedButton(
                  clipBehavior: Clip.antiAlias,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white38,
                  ),
                  onPressed: () => {
                    // SetWallpaper()
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (BuildContext context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  SetLockWallpaper();
                                },
                                child: const ListTile(
                                  title: Center(
                                    child: Text(
                                      "Set as Lock Screen",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  SetHomeWallpaper();
                                },
                                child: const ListTile(
                                  title: Center(
                                    child: Text(
                                      "Set As Home Screen",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  SetBothWallpaper();
                                },
                                child: const ListTile(
                                  title: Center(
                                    child: Text(
                                      "Set Both",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        })
                  },
                  child: const Text(
                    "Set as Wallpaper",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 30,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
