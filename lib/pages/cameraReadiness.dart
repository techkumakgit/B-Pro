import 'dart:io';
import 'dart:io' as Io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CameraReadiness extends StatefulWidget {

  @override
  _CameraReadinessState createState() => _CameraReadinessState();
}



class _CameraReadinessState extends State<CameraReadiness> {
  Future<void> _initializeControllerFuture;
  bool _isReady = false;
  CameraController controller;
  File imageFile;
  String imagePath;
  @override
  Widget build(BuildContext context) {

    if (!_isReady) return new Container();
    if (!controller.value.isInitialized) return new Container();


    return new Scaffold(
      body: new Container(
        color: Colors.amber,
        child: new AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: new CameraPreview(controller),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _isReady
            ? () async {
                // Take the Picture in a try / catch block. If anything goes wrong,
                // catch the error.
                try {
                  // Ensure that the camera is initialized.
                  await _initializeControllerFuture;

                  // Attempt to take a picture and get the file `image`
                  // where it was saved.
                  final image = await controller.takePicture();

                  // If the picture was taken, display it on a new screen.
                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        // Pass the automatically generated path to
                        // the DisplayPictureScreen widget.
                        imagePath: image.path,
                      ),
                    ),
                  );
                } catch (e) {
                  // If an error occurs, log the error to the console.
                  print(e);
                }
              }
            : null,
        child: const Icon(
          Icons.camera,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key,  this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}