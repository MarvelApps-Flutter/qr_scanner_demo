import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class ScanQR extends StatefulWidget {
  @override
  _ScanQRState createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  String qrCodeResult = "Not Yet Scanned";
  TextEditingController textEditingController = TextEditingController();
  GlobalKey _one = GlobalKey();

  @override
  void initState() {
    super.initState();
    textEditingController.text = qrCodeResult;
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      ShowCaseWidget.of(context)?.startShowCase([_one]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade400,
        title: Text("Scan QR Code"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fetch QR Data",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            ),
            Row(
              children: [
                Text(
                  "Please scan your QR code",
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                Expanded(child: Container()),
                Icon(
                  Icons.qr_code_outlined,
                  //  Icons.ballot_rounded,
                  size: 50,
                  color: Colors.indigo.shade400,
                )
              ],
            ),
            Expanded(child: Container()),
            Center(
              child: TextFormField(
                controller: textEditingController,
                decoration: InputDecoration(
                  suffixIcon: Showcase(
                    key: _one,
                    description: 'Click here to scan QR code',
                    child: IconButton(
                      onPressed: () async {
                        final codeSanner = (await BarcodeScanner.scan());
                        textEditingController.text =
                            codeSanner.rawContent.toString();
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.qr_code_scanner_rounded,
                        color: Colors.indigo.shade400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(flex: 2, child: Container()),
          ],
        ),
      ),
    );
  }
}
