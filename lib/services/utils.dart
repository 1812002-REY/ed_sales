import 'package:ed_sales/services/models/notification.dart';
import 'package:ed_sales/services/models/vfd_device.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pointycastle/export.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'models/efd_device.dart';

class AppUtils {
  static const String encryptedBaseUrl =
      "TxM2gP+Y1AROg1vkybQ1muHgT3sWevpakKloa1RPrtmTFETEoRJdDcgD3wuF+eUxkkWNGqEM6ySeiLX/2r9sFg==";
  static final Uint8List key = Uint8List.fromList([
    0x02,
    0xa5,
    0xf8,
    0xf0,
    0xeb,
    0xca,
    0xa0,
    0x10,
    0x71,
    0x95,
    0x33,
    0x06,
    0xb2,
    0x29,
    0x2d,
    0x99,
    0x27,
    0x1e,
    0xf0,
    0x31,
    0xc4,
    0x23,
    0xf8,
    0xd5,
    0x5f,
    0x56,
    0xea,
    0x90,
    0xb3,
    0x8e,
    0xfa,
    0x32,
  ]);
  static String decrypt(String base64Str) {
    final encryptedData = base64.decode(base64Str);
    final iv = encryptedData.sublist(0, 16);
    final encryptedBytes = encryptedData.sublist(16);

    final cipher = CBCBlockCipher(AESFastEngine())
      ..init(false, ParametersWithIV(KeyParameter(key), iv));

    final output = Uint8List(encryptedBytes.length);
    for (
      int offset = 0;
      offset < encryptedBytes.length;
      offset += cipher.blockSize
    ) {
      cipher.processBlock(encryptedBytes, offset, output, offset);
    }

    return utf8.decode(output).trim();
  }

  static const packages =
      "2bPKSbBaHYCiveEZ3JqHae869txv8lXWVX+7QmY7ZogUK0feFpRkCzmAw371ZT70";
  static const paymentModes =
      "/jfjm7Yh7sPqFK1ZzcZd9RCX040zvniIeBoJym8N/EMcLHEAiF3982C3RBVKcZMc";
  // static const paymentMode=
  // "jfjm7Yh7sPqFK1ZzcZd9RCX040zvniIeBoJym8N/EMcLHEAiF3982C3RBVKcZMc";
  static const client =
      "9oONJzKtK7q2RLY6aeCIMGivJ/KP4lKz/iwCcNj8Wul0ONOOOHtCu9ZDVbfR4sX4";
  static const transDeviceByRequestId =
      "pI5AtktdDb2Wi3a3mubGh8GtB/Tq+wiRP1oxn2KI27YJw7PtAtyFYPKnCqkrZ51U";
  static const getDevicesByOfficeId =
      "xsz8geW/tmawVAAHQkQjc2XgA0DS3fA762spleNS30I4M7myWZ3u8Qk6QHdnBGra";
  static const getDashboard =
      "WLV+EEo0+EC+1P+9nZvNCXuHQXNUcniDn/RG/ReBccGKZUYElcIbGwZXK66CpEiE";
  static const getTopSeller =
      "Can13Is39tNRe6sYnPFX94vajIOiUwqx+hoM0EkzVz9jimMhfM7yW+USl1YsCs4A";
  static const clientById =
      "wJI2Af+nIpfjuj0MiEreqljwOopcDa0jbxY5Hudc/lkjNiSYcyWRqiYQuryMj1Oq";
  static const verifiedPaymentById =
      "RzDQVfDsHZdlhx7+D5CMI464dcbdmcwA73knkFgLH08QDz8TdBTp9fzmloH0oEQhcHi98WoJ6ahP3Iqy9Vz0Bg==";
  static const efd =
      "T/YJOmpQ2z/k1r5GnkIVa3V/xnf67sHGNlTTQCsKcvFj+BNPMq7we31+dG/9j933";
  static const notEfd =
      "LQUWVVzWfYfug2H/olJcGyrijMAcPA8xwsYuOoxHURbS8nuUHON44nRdVLaw4AeI";
  static const deviceByOffice =
      "/TX8hslyJ6H9aBNKXETWYE7FeDnYYZZii9JtkWXV+ckAKdT2LZjRBetCqIRPSrR2";
  static const regions =
      "cbdqeOMb/fqWF2Z5v7PUWo2EOYCzAwqTyx0IcB/kEZDtnz/xiKma83Pav4MuvTPv";
  static const documentType =
      "LhmAWgQrg8+wcUeToM4c68eaQePaYbA9CWFNgSpWFVXLr9TmYACsCoh4nndGpWJ1";
  static const registerClient =
      "7/1SHg255tLgO6aaPrKjDGnlkQm28AI5lmo5sckAfFqO24xvzfFznzPkLXRXkVyV";
  static const offices =
      "qxBpUxWYrjvW2ZrM/cdbkSy9VlISybhYGejKquuVH0x981OL/z+4P//IQBSuy8Qx";
  static const staffs =
      "qjxJPdC/ipDNqxzZ53hEf+LbwasyQ2Fm29xv93C1NTFNn+Lh7uAGsauNFJGLnAU+";
  static const reasons =
      "fqsTlhhkPRhLuVfJjInugN1Bqaq2VyU4B6UhJJqMozF0+LIt1tYpt3lRu9XOlo+p";
  static const transfer =
      "wMVLWLfE8sQhV0XWep+n+MKb9h6n+mcVkmXH0hd7qRQ5W+0u2ltrfQgAOVU42/w5";

  static const VFD_devices =
      "cuIvtfD1Dse2KFYBZ+bj/KDHTmBcQcC/A/vFauJ2w2DDa9kQ6ZM+UA8WZLJ1V/Xj";

  static decryptUrls() {
    List urls = [
       transfer,
      registerClient,
      packages,
      paymentModes,
      client,
      VFD_devices,
      getTopSeller,
      clientById,
      verifiedPaymentById,
      efd,
      notEfd,
      deviceByOffice,
      regions,
      documentType,
      offices,
      staffs,
      reasons,
     
      transDeviceByRequestId,
      getDevicesByOfficeId,
      getDashboard,
    ];
    for (var url in urls) {
      print("url: ${decrypt(url)}");
    }
  }

  static String getDecryptedBaseUrl(String endpoint) {
    return decrypt(endpoint);
  }

  static final String baseUrl = 'http://efd.softnet.co.tz:8090/api';

  static String getFullDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, MMMM d, y').format(now);
  }

  // → Monday, September 8, 2025
  static String getMonthYear() {
    final now = DateTime.now();
    return DateFormat("MMMM, ''y").format(now);
  }

  static String formatDate(String date) {
    final dt = DateTime.parse(date);

    // 2. Format to “Month day, year”  →  December 2, 2024
    final formatted = DateFormat('MMMM d, y').format(dt);
    return formatted;
  }

  static String getButtonLabel(int status, int paymentStatus, bool isEfd) {
    switch (status) {
      case 1:
        return 'Received';
      case 2:
        return 'Distributing';
      case 3:
        return paymentStatus == 3 ? 'Rejected' : 'Paid';
      case 4:
        return 'Configured';
      case 5:
        return 'Sale';
      case 6:
        return 'Sold';
      case 7:
        return 'Payment Confirmed';
      case 8:
        return 'Fiscalization';
      case 9:
        return isEfd ? 'UIN Applied' : 'CertKey Applied';
      case 10:
        return isEfd ? 'UIN Ready' : 'CertKey Ready';
      case 11:
        return paymentStatus == 4 ? 'Rejected' : '';
      default:
        return 'Unknown Status';
    }
  }
  // → September, '2025

  static Widget get getLoader =>
      CupertinoActivityIndicator(radius: 16, color: Colors.black);

  static String notificationstate(int operationStatus, bool isEfd) {
    switch (operationStatus) {
      case 1:
        return "Received";
      case 2:
        return "Distributing";
      case 3:
        return "Paid";
      case 4:
        return "Configured";
      case 5:
        return "Distributed";
      case 6:
        return "Sold";
      case 7:
        return "Payment Confirmed";
      case 8:
        return "Fiscalization";
      case 9:
        return isEfd ? "UIN Applied" : "CertKey Applied";
      case 10:
        return isEfd ? "UIN Ready" : "CertKey Ready";
      default:
        return "";
    }
  }

  static String userDateFormat(String date) {
    try {
      DateTime inputDate = DateTime.parse(
        date,
      ); // parse incoming ISO date string
      DateTime now = DateTime.now();

      int compare = compareDate(inputDate, now);

      if (compare == 0) {
        return "Today";
      } else if (compare == 1) {
        return "Yesterday";
      } else {
        return convertToTime(inputDate);
      }
    } catch (e) {
      return "";
    }
  }

  /// Compares two dates and returns:
  /// 0 if same day,
  /// 1 if yesterday,
  /// >1 for older
  static int compareDate(DateTime inputDate, DateTime now) {
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime input = DateTime(inputDate.year, inputDate.month, inputDate.day);

    return today.difference(input).inDays;
  }

  /// Converts a date into readable string format
  static String convertToTime(DateTime date) {
    try {
      return DateFormat("MMMM d, yyyy").format(date); // e.g. September 30, 2025
    } catch (e) {
      return "";
    }
  }

  static List<NotificationOffice> getNotificationsFromVfd(
    List<VfdDevice> devices,
  ) {
    return devices.map((device) {
      NotificationOffice notificationOffice = NotificationOffice(
        deviceSerialNumber: device.deviceId.toString(),
        createDate: device.createDate.toString(),
        operationStatus: device.operationStatus!,
        notificationState: AppUtils.notificationstate(
          device.operationStatus!,
          false,
        ),
        formattedDate: AppUtils.formatDate(device.createDate.toString()),
      );
      return notificationOffice;
    }).toList();
  }

  static List<NotificationOffice> getNotificationsFromEfd(
    List<EfdDevice> devices,
  ) {
    return devices.map((device) {
      NotificationOffice notificationOffice = NotificationOffice(
        deviceSerialNumber: device.serialNumber.toString(),
        createDate: device.createDate.toString(),
        operationStatus: device.operationStatus!,
        notificationState: AppUtils.notificationstate(
          device.operationStatus!,
          true,
        ),
        formattedDate: AppUtils.formatDate(device.createDate.toString()),
      );
      return notificationOffice;
    }).toList();
  }

  static List<NotificationOffice> mergeNotifications(
    List<NotificationOffice> efdNotifications,
    List<NotificationOffice> vfdNotifications,
  ) {
    List<NotificationOffice> combined = [];
    combined.addAll(efdNotifications);
    combined.addAll(vfdNotifications);

    // Optional: sort by date (newest first)
    combined.sort((a, b) => b.createDate.compareTo(a.createDate));

    return combined;
  }
}

class Resource<T> {
  final T? data;
  final String? message;
  final Status status;

  Resource.loading() : data = null, message = null, status = Status.loading;
  Resource.success(this.data) : message = null, status = Status.success;
  Resource.error(this.message) : data = null, status = Status.error;
}

enum Status { loading, success, error }
