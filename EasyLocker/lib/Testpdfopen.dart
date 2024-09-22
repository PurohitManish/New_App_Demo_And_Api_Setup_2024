import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FilePickerScreen extends StatelessWidget {
  const FilePickerScreen({super.key});

  Future<void> _openFilePicker(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ViewPDFScreen(pdfPath: result.files.single.path!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No file selected'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Reader'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _openFilePicker(context);
              },
              child: const Text('Pick a PDF file'),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewPDFScreen extends StatelessWidget {
  const ViewPDFScreen({super.key, required this.pdfPath});
  final String pdfPath;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pdfPath.split('/').last),
      ),
      body:
          // SfPdfViewer.asset(pdfPath
          //     // 'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'
          //     )
          PDFView(
        filePath: pdfPath,
        enableSwipe: true,
        autoSpacing: true,
        pageFling: true,
        preventLinkNavigation: true,
        defaultPage: 0,
      ),
    );
  }
}
