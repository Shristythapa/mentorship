import 'package:app/config/routes/app_routes.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/video_call/presentation/viewmodel/SignalingViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class JoinView extends ConsumerStatefulWidget {
  SessionEntity sessionEntity;
  JoinView({required this.sessionEntity, Key? key}) : super(key: key);

  @override
  ConsumerState<JoinView> createState() => _JoinViewState();
}

class _JoinViewState extends ConsumerState<JoinView> {
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    ref.read(signalingViewModelProvider).onAddRemoteStream = ((stream) {
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
        title: const Text("Join Call"),
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
                      ref
                          .read(signalingViewModelProvider)
                          .openUserMedia(_localRenderer, _remoteRenderer);
                      setState(() {});
                    },
                    child: const Text("Open camera & microphone"),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref.read(signalingViewModelProvider).joinRoom(
                          widget.sessionEntity.id!, _remoteRenderer, context);
                    },
                    child: const Text("Join room"),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(signalingViewModelProvider)
                          .hangUp(_localRenderer, context);
                      Navigator.pushNamed(context, AppRoutes.menteeDashboard);
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
