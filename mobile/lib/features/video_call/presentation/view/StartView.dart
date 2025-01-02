import 'package:app/config/routes/app_routes.dart';
import 'package:app/features/sessions/domain/entity/session_entity.dart';
import 'package:app/features/video_call/presentation/view/signal.dart';
import 'package:app/features/video_call/presentation/viewmodel/SignalingViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class StartView extends ConsumerStatefulWidget {
  SessionEntity sessionEntity;
  StartView({required this.sessionEntity, Key? key}) : super(key: key);

  @override
  ConsumerState<StartView> createState() => _StartViewState();
}

class _StartViewState extends ConsumerState<StartView> {
  // Signaling signaling = Signaling();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController = TextEditingController(text: '');

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
        title: const Text("Start Call"),
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
                    onPressed: () async {
                      String room = widget.sessionEntity.id!;
                      roomId = await ref
                          .read(signalingViewModelProvider)
                          .createRoom(_remoteRenderer, room, context);
                      textEditingController.text = roomId!;
                      setState(() {});
                    },
                    child: const Text("Create room"),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      ref
                          .read(signalingViewModelProvider)
                          .hangUp(_localRenderer,context);
                      // signaling.hangUp(_localRenderer);
                      Navigator.pushNamed(context, AppRoutes.mentorDashboard);
                    },
                    child: const Text("Hangup"),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: RTCVideoView(_localRenderer, mirror: true)),
                  Expanded(child: RTCVideoView(_remoteRenderer)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
