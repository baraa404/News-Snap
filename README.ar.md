[English](./README.md) · **العربية**

# News Snap (نيوز سناب)

<p align="center">
  <img src="assets/images/blackLogo.png" alt="News Snap" width="120" />
</p>

<p align="center">
  <b>عناوين سريعة.</b><br/>
  قارئ أخبار Flutter داكن وبسيط مدعوم بـ NewsAPI — خلاصات حسب الفئة، بحث بالكلمات، وعرض المقالات داخل التطبيق.
</p>

<p align="center">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-02569B?style=flat-square&logo=flutter&logoColor=white" />
  <img alt="Dart" src="https://img.shields.io/badge/Dart-3.8-0175C2?style=flat-square&logo=dart&logoColor=white" />
  <img alt="NewsAPI" src="https://img.shields.io/badge/NewsAPI-org-1A1A2E?style=flat-square" />
  <img alt="Theme" src="https://img.shields.io/badge/Theme-Dark-111111?style=flat-square" />
  <img alt="Platforms" src="https://img.shields.io/badge/Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-success?style=flat-square" />
</p>

---

## لماذا أُنشئ هذا التطبيق

معظم تطبيقات الأخبار تغرقك في التفاصيل بلا قيمة. يحافظ News Snap على الحلقة ضيقة:

**اختر فئة ← اسحب عبر الأخبار ← افتح المقال كاملًا داخل التطبيق.**

بُني لإبراز حرفية واجهة Flutter النظيفة: وودجت حركة مخصصة، وصور مخزّنة مؤقتًا، وشبكات عبر Dio، وفصل واضح بين services → models → screens.

## الميزات

| المجال | ما الذي تحصل عليه |
|------|----------------|
| العناوين | أهم الأخبار حسب الفئة عبر NewsAPI |
| الفئات | عام · صحة · رياضة · أعمال |
| البحث | بحث نصي شامل في المقالات |
| القراءة | WebView داخل التطبيق للمقالات الكاملة |
| واجهة الحركة | `AnimatedTabSelector` + `SwipeableStack` مخصصان |
| الصور | تحميل سلس مع `cached_network_image` |
| السمة | الوضع الداكن افتراضيًا |
| المنصات | Android، iOS، Web، Desktop |

## تدفق المستخدم

```text
التشغيل (شاشة إقلاع داكنة)
  → الرئيسية: تبويبات فئات + كروت أخبار قابلة للسحب
  → اضغط الكارت ← مقال WebView
  → تبويب البحث ← استعلام → نتائج
  → مداخل القائمة الجانبية / الإعدادات
```

## عرض توضيحي

![عرض التطبيق](showcase/video.gif)

## لقطات الشاشة

<p>
  <img alt="الرئيسية" src="showcase/screenshot1.png" width="30%" />
  <img alt="الفئات" src="showcase/screenshot2.png" width="30%" />
  <img alt="المقال" src="showcase/screenshot3.png" width="30%" />
</p>

## المعمارية

```text
┌─────────────────┐     ┌──────────────────┐     ┌─────────────────────┐
│  Screens / UI   │ ──▶ │  Services        │ ──▶ │  NewsAPI (REST)     │
│  views + widgets│     │  NewsApiService  │     │  top-headlines /    │
└─────────────────┘     └──────────────────┘     │  everything         │
         │                       │               └─────────────────────┘
         │                       ▼
         │              ArticleModel DTOs
         ▼
   Custom widgets (تبويبات، رصة سحب) + WebView
```

**تدفق البيانات**
1. يجلب `NewsApiService` بيانات JSON عبر Dio
2. تُربَط الاستجابات في `ArticleModel` / `FullArticelsModel`
3. تُنشئ الـ Builders رصص الكروت؛ واللمس يفتح `WebViewScreen`

## هيكل المشروع

```text
lib/
├── main.dart                      # تشغيل MaterialApp داكن
├── modules/
│   └── article.module.dart        # Article · Source · غلاف الاستجابة
├── services/
│   └── news_api.service.dart      # عناوين الفئات + البحث
├── screens/
│   ├── views/
│   │   ├── main_view.dart         # الهيكل + تنقل تبويبات متحرك
│   │   ├── home.view.dart         # تبويبات الفئات + الخلاصات
│   │   ├── search_view.dart       # البحث بالكلمة
│   │   └── webview_screen.dart    # قارئ المقالات داخل التطبيق
│   └── widgets/                   # شريط التطبيق، الكروت، القائمة، التبويبات
└── widgets/
    ├── animated_tab_selector.dart # شريط تبويبات حركة قابل لإعادة الاستخدام
    └── swipeable_stack.dart       # رصة كروت تعمل بالإيماءات

assets/images/                     # الشعار والهوية
showcase/                          # لقطات شاشة + GIF توضيحي
```

## التقنيات المستخدمة

| الطبقة | الاختيار |
|-------|--------|
| الإطار | Flutter · Dart `^3.8.1` |
| الشبكات | `dio` → NewsAPI (`top-headlines`, `everything`) |
| الصور | `cached_network_image` |
| القراءة | `webview_flutter` · `url_launcher` |
| الخطوط | `google_fonts` |
| الهوية | `flutter_native_splash` · `flutter_launcher_icons` |

القائمة الكاملة: [`pubspec.yaml`](pubspec.yaml)

## الوودجت المخصصة

قطع قابلة لإعادة الاستخدام داخل `lib/widgets/` — قابلة للنقل إلى مشروعات أخرى.

### AnimatedTabSelector
مؤشر دائري سلس فوق شريط أيقونات مدمج. ألوان وأحجام ومدة ومنحنيات قابلة للتهيئة.

### SwipeableStack
رصة كروت ذات فيزياء: سحب، إلقاء، دوران، تقدم. إزاحة ودوران خلفي قابلان للتهيئة.

## البدء

**المتطلبات الأساسية**
- Flutter SDK (Dart 3.8+)
- مفتاح [NewsAPI.org](https://newsapi.org)

```bash
git clone https://github.com/baraa404/News-Snap.git
cd News-Snap
flutter pub get
```

ضع مفتاح NewsAPI الخاص بك في `lib/services/news_api.service.dart` (أو الأفضل عبر env/`--dart-define` — لا ترفع الأسرار إلى نسخ عامة).

**التشغيل**

```bash
flutter devices
flutter run -d android   # أو ios / chrome / linux / macos / windows
```

## أوامر مفيدة

```bash
flutter clean && flutter pub get
flutter analyze
flutter test
```

## ملاحظات للمراجعين

- اسم الحزمة هو `news_app`؛ الاسم التجاري للمنتج هو **News Snap**.
- مفاتيح NewsAPI الطبقة المجانية مخصصة للتطوير؛ والإنتاج يحتاج مفتاحًا حقيقيًا وبروكسي خلفي.
- يُفضَّل استخدام روابط المقالات HTTPS لسلامة نقل البيانات في iOS.

## الشكر

- بيانات الأخبار من [NewsAPI.org](https://newsapi.org)
- فريقا Flutter و Dart

## الترخيص

MIT — مشروع بورتفوليو / شخصي.