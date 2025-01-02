import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class VideoChatScreen extends StatefulWidget {
  @override
  _VideoChatScreenState createState() => _VideoChatScreenState();
}

class _VideoChatScreenState extends State<VideoChatScreen> {
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  Map<String, RTCVideoRenderer> _remoteRenderers = {};

  IO.Socket? socket;
   String userId = "65bdf4cb75202db82b373116";
  @override
  void initState() {
    super.initState();
    _initRenderers();
    _createPeerConnection();
    _connectToSignalingServer();
  }

  void _initRenderers() async {
    await _localRenderer.initialize();
  }

  Future<RTCPeerConnection> _createPeerConnection() async {
    final Map<String, dynamic> configuration = {
      'iceServers': [
        {'url': 'stun:stun.l.google.com:19302'},
      ]
    };
    final Map<String, dynamic> constraints = {
      'mandatory': {},
      'optional': [],
    };
    RTCPeerConnection pc =
        await createPeerConnection(configuration, constraints);
    pc.onIceCandidate = (candidate) {
      // Send ICE candidate to peer
      socket!.emit('ice-candidate', {'candidate': candidate.toMap()});
    };
    pc.onAddStream = (stream) {
      setState(() {
        RTCVideoRenderer renderer = RTCVideoRenderer();
        renderer.initialize().then((_) {
          renderer.srcObject = stream;
          setState(() {
            _remoteRenderers[userId] = renderer;
          });
        });
      });
    };
    return pc;
  }

  void _connectToSignalingServer() {
    socket = IO.io('http://localhost:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();

    socket!.on('user-connected', (data) {
      // Handle new user connection
      // You can call _createPeerConnection() here to initiate a call
    });

    socket!.on('user-disconnected', (data) {
      // Handle user disconnection
      // You can remove the corresponding RTCVideoRenderer from _remoteRenderers list
    });
  }

  void _connectToNewUser(String userId, MediaStream stream) {
    print("Calling user: $userId");

    // Check if a video element with the same userId already exists
    if (!_remoteRenderers.containsKey(userId)) {
      RTCPeerConnection peerConnection =
          _createPeerConnection() as RTCPeerConnection;
      if (peerConnection != null) {
        RTCVideoRenderer renderer = RTCVideoRenderer();
        renderer.initialize().then((_) {
          renderer.srcObject = stream;
          setState(() {
            _remoteRenderers[userId] = renderer;
          });
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _localRenderer.dispose();
    // _remoteRenderers.forEach((renderer) => renderer.dispose());
    socket!.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: RTCVideoView(_localRenderer),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: _remoteRenderers.length,
              itemBuilder: (context, index) {
                return RTCVideoView(_remoteRenderers[index]!);
              },
            ),
          ),
        ],
      ),
    );
  }
}
