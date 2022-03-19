import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class player extends StatefulWidget {
  const player({Key? key}) : super(key: key);

  @override
  State<player> createState() => _playerState();
}

// ignore: camel_case_types
class _playerState extends State<player> {
  bool playing = false;
  var playButton = Icons.play_arrow;
  late AudioPlayer audioPlayer;
  late int result;
  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
    playing = false;
  }

  void getAudio(String url) async {
    if (!playing) {
      var res = await audioPlayer.play(url);
      if (res == 1) {
        setState(() {
          playing = true;
          playButton = Icons.pause;
        });
      }
    } else {
      var res = await audioPlayer.pause();
      if (res == 1) {
        setState(() {
          playing = false;
          playButton = Icons.play_arrow;
        });
      }
    }
  }

  @override
  void dispose() {
    audioPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final String URL = ModalRoute.of(context)!.settings.arguments as String;
    // ignore: unused_label
    color:
    const Color.fromARGB(66, 21, 1, 24);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LO-FI PLAYER',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        color: const Color.fromARGB(31, 51, 44, 44),
        child: Column(
          children: [
            const SizedBox(
              height: 24.0,
            ),
            Center(
              child: SizedBox(
                width: 280.0,
                height: 280.0,
                child: Image.network(
                    'https://64.media.tumblr.com/2474f73eb9e1f6026a0ca8882ed696e1/0d80a09f5022bf82-f9/s128x128u_c1/8c2a062aa5c5412cc7712f92341062f9be31e001.jpg'),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Center(
              child: Text(
                'Lo-Fi Beats',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            const Center(
              child: Text(
                'Study!',
                style: TextStyle(
                  color: Color.fromARGB(221, 0, 0, 0),
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 45.0,
                      color: const Color.fromARGB(255, 9, 255, 0),
                      onPressed: () {},
                      icon: const Icon(Icons.skip_previous),
                    ),
                    IconButton(
                      iconSize: 50.0,
                      color: const Color.fromARGB(255, 9, 255, 0),
                      onPressed: () {
                        getAudio(URL);
                      },
                      icon: Icon(
                        playButton,
                      ),
                    ),
                    IconButton(
                      iconSize: 45.0,
                      color: const Color.fromARGB(255, 9, 255, 0),
                      icon: const Icon(Icons.skip_next),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
