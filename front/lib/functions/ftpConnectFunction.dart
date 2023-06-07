// import 'dart:io';
// import 'package:ftpconnect/ftpconnect.dart';

// void uploadFile() {
//   main() async {
//     FTPConnect ftpConnect =
//         FTPConnect('13.37.244.2', user: 'ftp_project', pass: 'ftp_project');
//     String fileName = 'Oui';
//     await ftpConnect.connect();
//     bool res = await ftpConnect.downloadFileWithRetry(fileName,
//         File('CAP7821576622128196130_compressed4653756340276791981.jpg'));
//     await ftpConnect.disconnect();
//     print(res);
//   }
// }

// void downloadFile() {
//   main() async {
//     FTPConnect ftpConnect =
//         FTPConnect('example.com', user: 'user', pass: 'pass');
//     String fileName = 'toDownload.txt';
//     await ftpConnect.connect();
//     bool res = await ftpConnect.downloadFileWithRetry(
//         fileName, File('myFileFromFTP.txt'));
//     await ftpConnect.disconnect();
//     print(res);
//   }
// }
