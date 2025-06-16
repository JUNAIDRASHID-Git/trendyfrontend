// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get totalCarted => 'إجمالي المنتجات في العربة';

  @override
  String get deliveryAddress => 'عنوان التوصيل';

  @override
  String get tapToEditDeliveryInfo => 'اضغط لتعديل معلومات التوصيل';

  @override
  String get address => 'العنوان';

  @override
  String get location => 'الموقع';

  @override
  String get country => 'البلد';

  @override
  String get editAddress => 'تعديل العنوان';

  @override
  String get updateYourDeliveryInformation => 'تحديث معلومات التوصيل الخاصة بك';

  @override
  String get phone => 'رقم الهاتف';
}
