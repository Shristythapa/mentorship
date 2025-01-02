import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/video_call/presentation/view/signal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:peerdart/peerdart.dart';
// import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
// import 'package:peerdar';

class VideoCallPage extends StatefulWidget {
  SessionEntity sessionEntity;
  bool isMentor;
  VideoCallPage({required this.sessionEntity,required this.isMentor, Key? key}) : super(key: key);

  @override
  _VideoCallPageState createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  Signaling signaling = Signaling();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sessionEntity.title),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      signaling.openUserMedia(_localRenderer, _remoteRenderer);
                      setState(() {});
                    },
                    child: const Text("Open camera & microphone"),
                  ),
                   SizedBox(
                    width: 8,
                  ),
                 widget.isMentor?  ElevatedButton(
                    onPressed: () async {
                      roomId = await signaling.createRoom(
                          _remoteRenderer, widget.sessionEntity.id!);

                      setState(() {});
                    },
                    child: const Text("Create room"),
                  )
                   : SizedBox(),
                 !widget.isMentor ? ElevatedButton(
                    onPressed: () {
                      // Add roomId
                      signaling.joinRoom(
                        widget.sessionEntity.id!,
                        _remoteRenderer,
                      );
                      setState(() {});
                    },
                    child: const Text("Join room"),
                  ): SizedBox(),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      signaling.hangUp(_localRenderer);
                    },
                    child: const Text("Hangup"),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: RTCVideoView(_localRenderer, mirror: true)),
                  Expanded(child: RTCVideoView(_remoteRenderer)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
