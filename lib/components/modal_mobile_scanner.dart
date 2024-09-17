import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ModalMobileScanner extends StatefulWidget {
  final Function(String?) onDetect;
  final Widget? buttonLabel;
  final Color? backgroundColor;

  const ModalMobileScanner(
      {super.key,
      required this.onDetect,
      this.buttonLabel,
      this.backgroundColor});

  @override
  State<ModalMobileScanner> createState() => _ModalMobileScannerState();
}

class _ModalMobileScannerState extends State<ModalMobileScanner> {
  Widget cameraLabelOn = const Icon(Icons.camera_alt);

  bool cameraStarted = false;
  late MobileScannerController mobileScannerController;

  @override
  void initState() {
    super.initState();

    if (widget.buttonLabel != null) {
      cameraLabelOn = widget.buttonLabel!;
    }

    mobileScannerController = MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates, autoStart: false);
  }

  @override
  void dispose() {
    super.dispose();
    mobileScannerController.dispose();
    cameraStarted = false;
  }

  void toggleCamera(BuildContext context) async {
    if (cameraStarted) {
      _closeCameraModal(context);
      mobileScannerController.stop();
    } else {
      mobileScannerController.start();
      _openCameraModal(context);
    }

    setState(() {
      cameraStarted = !cameraStarted;
    });
  }

  void _onDetect(BarcodeCapture? capture, BuildContext context) {
    if (capture != null) {
      toggleCamera(context);
      widget.onDetect(capture.barcodes[0].rawValue);
    }
  }

  void _openCameraModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(10), // Apply rounded corners
                  child: MobileScanner(
                    controller: mobileScannerController,
                    onDetect: (capture) => _onDetect(capture, context),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildCameraButton(context)
            ],
          ),
        );
      },
    );
  }

  void _closeCameraModal(BuildContext context) {
    Navigator.of(context).pop();
  }

  Widget _buildCameraButton(BuildContext context) {
    return Visibility(
      visible: true,
      child: FloatingActionButton(
        backgroundColor: !cameraStarted ? widget.backgroundColor : null,
        onPressed: () => toggleCamera(context),
        tooltip: 'Start/stop camera',
        child:
            !cameraStarted ? cameraLabelOn : const Icon(Icons.no_photography),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildCameraButton(context);
  }
}
