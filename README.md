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

1. ارفع المشروع على GitHub (إن لم يكن مرفوعاً):
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/engmohamedkhedrCv.git
   git push -u origin main
   ```

2. في GitHub: **Settings** → **Pages** → **Build and deployment**:
   - **Source**: اختر **GitHub Actions**.

3. عند أي **push** على الفرع `main` سيتم البناء والنشر تلقائياً.

4. بعد دقائق، افتح الرابط:
   **https://YOUR_USERNAME.github.io/engmohamedkhedrCv/**

يمكنك مشاركة هذا الرابط من أي جهاز أو متصفح.
