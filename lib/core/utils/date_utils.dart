import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime? {
  String toYmd() {
    if (this != null) {
      final df = DateFormat('yyyy-MM-dd');
      return df.format(this!);
    } else {
      return 'NA';
    }
  }

  String toDm() {
    if (this != null) {
      final df = DateFormat('dd MMM');
      return df.format(this!);
    } else {
      return 'NA';
    }
  }

  String toDmHm() {
    if (this != null) {
      final df = DateFormat('dd MMM hh:mm');
      return df.format(this!);
    } else {
      return 'NA';
    }
  }

  String toHm() {
    if (this != null) {
      final df = DateFormat('hh:mm');
      return df.format(this!);
    } else {
      return 'NA';
    }
  }
}
