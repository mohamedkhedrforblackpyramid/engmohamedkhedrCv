# Mohamed Omar Khedr – CV / Portfolio

موقع تعريفي (ويب + موبايل) لـ Mohamed Khedr – Lead Mobile Developer.

## الرابط (بعد النشر على GitHub Pages)

بعد رفع المشروع على GitHub وتفعيل GitHub Pages، الرابط سيكون:

**https://YOUR_USERNAME.github.io/engmohamedkhedrCv/**

(استبدل `YOUR_USERNAME` باسم مستخدمك في GitHub)

## تشغيل محلياً

```bash
flutter pub get
flutter run -d chrome   # ويب
# أو
flutter run             # أي جهاز متصل
```

## بناء نسخة الويب للنشر

```bash
flutter build web --base-href "/engmohamedkhedrCv/"
```

الملفات الجاهزة للنشر في `build/web/`.

## النشر على GitHub Pages (رابط يفتح من أي مكان)

1. في المستودع على GitHub اذهب إلى: **Settings** → **Pages** (من القائمة الجانبية).

2. تحت **Build and deployment** → **Source** اختر **Deploy from a branch**.

3. تحت **Branch** اختر **gh-pages** والمجلد **/ (root)** ثم **Save**.

4. شغّل الـ workflow مرة واحدة:
   - اذهب إلى تبويب **Actions**
   - اختر **Deploy CV to gh-pages branch**
   - اضغط **Run workflow** → **Run workflow**

5. انتظر 2–3 دقائق حتى يكتمل التشغيل، ثم افتح الرابط:
   **https://mohamedkhedrforblackpyramid.github.io/engmohamedkhedrCv/**

بعد ذلك، كل **push** على الفرع `main` سينشر الموقع تلقائياً.
