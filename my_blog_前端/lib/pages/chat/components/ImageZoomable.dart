import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class ImageZoomable extends StatefulWidget {
  ImageZoomable(this.image, {Key? key, this.scale = 2.0, required this.onTap}) : super(key: key);

  ImageProvider image;
  double scale;
  GestureTapCallback onTap;

  @override
  _ImageZoomableState createState() => new _ImageZoomableState();
}

class _ImageZoomableState extends State<ImageZoomable> {
  ImageStream? _imageStream;
  ui.Image? _image;

  Offset? _startingFocalPoint;
  Offset? _previousOffset;
  Offset _offset = Offset.zero;

  double? _previousZoom;
  double _zoom = 1.0;

  void _handleScaleStart(ScaleStartDetails details) {
    if (_image == null) {
      return;
    }
    _startingFocalPoint = details.focalPoint / widget.scale;
    _previousOffset = _offset;
    _previousZoom = _zoom;
  }

  void _handleScaleUpdate(Size size, ScaleUpdateDetails details) {
    if (_image == null) {
      return;
    }
    double newZoom = _previousZoom! * details.scale;
    bool tooZoomedIn = _image!.width * widget.scale / newZoom <= size.width ||
        _image!.height * widget.scale / newZoom <= size.height || newZoom <= 0.8;
    if (tooZoomedIn) {
      return;
    }

    setState(() {
      _zoom = newZoom;
      final Offset normalizedOffset = (_startingFocalPoint! - _previousOffset!) / _previousZoom!;
      _offset = details.focalPoint / widget.scale - normalizedOffset * _zoom;
    });
  }

  @override
  void didChangeDependencies() {
    _resolveImage();
    super.didChangeDependencies();
  }

  @override
  void reassemble() {
    _resolveImage();
    super.reassemble();
  }

  void _resolveImage() {
    _imageStream = widget.image.resolve(createLocalImageConfiguration(context));
    _imageStream!.addListener(ImageStreamListener(_handleImageLoaded));
  }

  void _handleImageLoaded(ImageInfo info, bool synchronousCall) {
    setState(() {
      _image = info.image;
    });
  }

  @override
  void dispose() {
    _imageStream!.removeListener(ImageStreamListener(_handleImageLoaded));
    super.dispose();
  }

  Widget? _drawImage() {
    if (_image == null) {
      return null;
    }

    return new Transform(
        transform: new Matrix4.diagonal3Values(widget.scale, widget.scale, widget.scale),
        child: new CustomPaint(
            painter: new _ImageZoomablePainter(
              image: _image,
              offset: _offset,
              zoom: _zoom / widget.scale,
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: _drawImage(),
      onTap: widget.onTap,
      onScaleStart: _handleScaleStart,
      onScaleUpdate: (d) => _handleScaleUpdate(context.size!, d),
    );
  }
}

class _ImageZoomablePainter extends CustomPainter {
  _ImageZoomablePainter({this.image, this.offset, this.zoom});

  ui.Image? image;
  Offset? offset;
  double? zoom;

  @override
  void paint(Canvas canvas, Size size) {
    paintImage(canvas: canvas, rect: offset! & (size * zoom!), image: image!);
  }

  @override
  bool shouldRepaint(_ImageZoomablePainter old) {
    return old.image != image || old.offset != offset || old.zoom != zoom;
  }
}