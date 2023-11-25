// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:audioplayers/audio_cache.dart';
//
// // ignore: must_be_immutable
// class SelectedAudioPreview extends StatefulWidget {
//   final dynamic user;
//   List<File> audioList = [];
//
//   SelectedAudioPreview({Key key, this.audioList, this.user}) : super(key: key);
//
//   @override
//   _SelectedAudioPreviewState createState() => _SelectedAudioPreviewState();
// }
//
// class _SelectedAudioPreviewState extends State<SelectedAudioPreview> {
//   bool _isDownloading = false;
//   int _sliderValue = 0;
//   Duration _duration = Duration.zero;
//   Duration _position = Duration.zero;
//   bool _isPlaying = false;
//
//   List<File> _audiofiles = [];
//   List<double> _audioListDurations = [];
//   List<double> _audioListPositions = [];
//   // List<AudioPlayer> _audioPlayerList = [];
//   ScrollController _scrollController;
//   AudioPlayer _audioPlayer;
//   AudioCache _audioCache;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         brightness: Brightness.dark,
//         backgroundColor: Colors.blueGrey[800],
//         automaticallyImplyLeading: false,
//         titleSpacing: 0,
//         elevation: 1,
//         title: Row(
//           children: [
//             IconButton(
//               icon: Icon(Icons.arrow_back),
//               color: Colors.white,
//               iconSize: 25.0,
//               onPressed: () => Navigator.pop(
//                 context,
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(top: 7.5, bottom: 7.5),
//               child: Row(
//                 children: [
//                   Container(
//                     child: CircleAvatar(
//                       radius: 20.0,
//                       backgroundImage: AssetImage(widget.user.imageUrl),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 10.0),
//                     width: MediaQuery.of(context).size.width * .4,
//                     child: Text(
//                       widget.user.name,
//                       style: TextStyle(
//                           fontSize: 21.0,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w500),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.send, color: Colors.grey[300]),
//             iconSize: 25.0,
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           _uploadPdfFile().then((value) => loading()).then(
//                 (value) => Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => SelectedAudioPreview(
//                             audioList: widget.audioList,
//                             user: widget.user,
//                           )),
//                 ),
//               );
//         },
//         child: Icon(Icons.add),
//       ),
//       body: Container(
//         color: Color.fromRGBO(161, 202, 241, .15),
//         child: ListView(
//           controller: _scrollController,
//           children: [
//             SizedBox(height: 15),
//             for (var audioNum = 0; audioNum < widget.audioList.length; audioNum++)
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     height: 60,
//                     width: MediaQuery.of(context).size.width * .85,
//                     margin: EdgeInsets.only(left: 10, top: 5),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                       border: Border.all(
//                           width: 1.0, color: Color.fromRGBO(0, 0, 0, .4)),
//                     ),
//                     child: Material(
//                       child: Container(
//                         padding: EdgeInsets.all(5.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Row(
//                               children: [
//                                 Container(
//                                   padding: EdgeInsets.only(left: 5.0, right: 5.0),
//                                   child: Icon(
//                                     Icons.headset_rounded,
//                                     color: Colors.orange[500],
//                                     size: 30,
//                                   ),
//                                 ),
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       width: MediaQuery.of(context).size.width * .55,
//                                       padding: EdgeInsets.only(left: 10.0),
//                                       child: Text(
//                                         '${basename(widget.audioList[audioNum].path)}',
//                                         style: TextStyle(
//                                           color: Colors.black54,
//                                           fontSize: 14,
//                                         ),
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           child: GestureDetector(
//                                             onTap: (){
//                                               setState(() {
//                                                 // _isPlaying? _isPlaying=false:_isPlaying=true;
//                                                 _sliderValue = audioNum;
//                                                 _isPlaying?_audioPlayer.pause():
//                                                 _audioPlayer.play(widget.audioList[audioNum].path,isLocal: true);
//                                               });
//                                             },
//                                             child: Icon(
//                                               _sliderValue==audioNum?(_isPlaying?Icons.pause:Icons.play_arrow):
//                                               Icons.play_arrow,
//                                               color: Colors.blueGrey,
//                                               size: 30,
//                                             ),
//                                           ),
//                                         ),
//                                         Container(
//                                           child: Text(
//                                             (_isPlaying && _sliderValue==audioNum)?'${_position.toString().substring(2,7)}':'00:00',
//                                             style: TextStyle(
//                                               fontSize: 10,
//                                               fontWeight: FontWeight.w500,
//                                               color: Colors.black.withOpacity(.5),
//                                             ),
//                                           ),
//                                         ),
//                                         SliderTheme(
//                                           data: SliderTheme.of(context).copyWith(
//                                               activeTrackColor: Colors.orange[500],
//                                               inactiveTrackColor: Colors.blueGrey[200],
//                                               thumbColor: Colors.orange[500],
//                                               thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4.0),
//                                               trackHeight: 1.0,
//                                               overlayShape: RoundSliderOverlayShape(overlayRadius: 8.0)),
//                                           child: Slider(
//                                             min: 0.0,
//                                             max: (/*_isPlaying && */_sliderValue==audioNum)?_duration.inSeconds.toDouble():5.0,
//                                             value: (/*_isPlaying &&*/ _sliderValue==audioNum)?_position.inSeconds.toDouble():0.0,
//                                             onChanged: (v) {
//                                               setState(() {
//                                                 seekTo(v.toInt());
//                                               });
//                                             },
//                                           ),
//                                         ),
//                                         Container(
//                                           child: Text(
//                                             _sliderValue==audioNum?'${_duration.toString().substring(2,7)}':'05:00',
//                                             style: TextStyle(
//                                               fontSize: 10,
//                                               fontWeight: FontWeight.w500,
//                                               color:
//                                               Colors.black.withOpacity(.5),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.blueGrey,
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10.0)),
//                               ),
//                               padding: EdgeInsets.all(2.0),
//                               child: ClipOval(
//                                 child: Material(
//                                   color: Colors.white,
//                                   child: InkWell(
//                                     splashColor: Colors.blueGrey[300],
//                                     onTap: () {
//                                       widget.audioList.removeAt(audioNum);
//                                       widget.audioList.isEmpty
//                                           ? Navigator.pop(context)
//                                           : Navigator.pushReplacement(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     SelectedAudioPreview(
//                                                   audioList: widget.audioList,
//                                                   user: widget.user,
//                                                 ),
//                                               ),
//                                             );
//                                     },
//                                     child: SizedBox(
//                                       width: 30,
//                                       height: 30,
//                                       child: Icon(
//                                         Icons.close,
//                                         color: Colors.blueAccent,
//                                         size: 22,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             SizedBox(height: 15),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget loading() {
//     return Container(
//       child: Center(child: CircularProgressIndicator()),
//     );
//   }
//
//   Future _uploadPdfFile() async {
//     _audiofiles.clear();
//     FilePickerResult result = await FilePicker.platform.pickFiles(
//       allowMultiple: true,
//       type: FileType.custom,
//       allowedExtensions: ['mp3'],
//     );
//     if (result != null) {
//       _audiofiles = result.paths.map((path) => File(path)).toList();
//
//       for (var num = 0; num < _audiofiles.length; ++num) {
//         File audio = _audiofiles[num];
//         widget.audioList.add(audio);
//       }
//       print('length: ${widget.audioList.length}');
//     }
//     else print('not uploaded');
//   }
//
//   void seekTo(int seconds){
//     Duration newDuration = Duration(seconds: seconds);
//     _audioPlayer.seek(newDuration);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _scrollController = new ScrollController();
//     _audioCache = new AudioCache(fixedPlayer: _audioPlayer);
//
//       _audioPlayer = new AudioPlayer();
//       _audioPlayer.onDurationChanged.listen((duration) {
//         setState(() {
//           _duration = duration;
//           // print('duration: $duration');
//         });
//       });
//       _audioPlayer.onAudioPositionChanged.listen((position) {
//         setState(() {
//           _position = position;
//           print('position: ${position.toString().substring(2,7)}');
//         });
//         _audioPlayer.onPlayerStateChanged.listen((state) {
//           setState(() {
//             if (state == AudioPlayerState.PLAYING) _isPlaying = true;
//             else _isPlaying = false;
//           });
//         });
//         _audioPlayer.onPlayerError.listen((msg) {
//           print('player Error: $msg');
//           _duration = Duration.zero;
//           _position = Duration.zero;
//           _isPlaying = false;
//         });
//       });
//
//     // for(var i=0; i<widget.audioList.length; ++i) {
//     //   _audioListPositions.add(_position);
//     //   _audioListDurations.add(_duration);
//     // }
//   }
//   @override
//   void dispose() {
//     super.dispose();
//     _audioPlayer.dispose();
//     _audioPlayer.release();
//   }
// }
//
//
