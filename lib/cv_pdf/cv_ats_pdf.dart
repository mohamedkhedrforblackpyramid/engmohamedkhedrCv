import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../data/cv_data.dart';

/// ATS-oriented résumé: single column, embedded Noto Sans TTF (Unicode), plain text,
/// Latin-friendly text (no mixed-script issues), no images.
/// Mirrors [CvData] used by the web/mobile CV.
class CvAtsPdf {
  CvAtsPdf._();

  static const double _nameSize = 20;
  static const double _titleSize = 11;
  static const double _bodySize = 10;
  static const double _sectionSize = 11;
  static const double _gapSm = 6;
  static const double _gapMd = 10;
  static const double _gapLg = 14;

  /// Normalizes punctuation and keeps ATS-friendly Latin text.
  static String _latinAts(String text) {
    var t = text.replaceAll('\u2013', '-').replaceAll('\u2014', '-');
    if (t.contains('|')) {
      t = t.split('|').first.trim();
    }
    t = t.replaceAll(
      RegExp(r'[\u0600-\u06FF\u0750-\u077F\uFB50-\uFDFF\uFE70-\uFEFF]'),
      '',
    );
    return t.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  static Future<pw.Font> _font(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    return pw.Font.ttf(data);
  }

  static Future<Uint8List> build() async {
    final regular = await _font('fonts/NotoSans-Regular.ttf');
    final bold = await _font('fonts/NotoSans-Bold.ttf');

    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(48),
        theme: pw.ThemeData.withFont(
          base: regular,
          bold: bold,
        ),
        build: (context) => [
          _header(),
          pw.SizedBox(height: _gapLg),
          _section('PROFESSIONAL SUMMARY'),
          _body(_latinAts(CvData.summary)),
          pw.SizedBox(height: _gapMd),
          _section('CORE SKILLS'),
          ...CvData.coreSkills.entries.expand((e) {
            final skills = e.value.map(_latinAts).join(', ');
            return [
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: _gapSm),
                child: pw.RichText(
                  text: pw.TextSpan(
                    style: _bodyStyle(bold: false),
                    children: [
                      pw.TextSpan(
                        text: '${_latinAts(e.key)}: ',
                        style: _bodyStyle(bold: true),
                      ),
                      pw.TextSpan(text: skills),
                    ],
                  ),
                ),
              ),
            ];
          }),
          pw.SizedBox(height: _gapMd),
          _section('PROFESSIONAL EXPERIENCE'),
          ...CvData.experience.expand(_experienceWidgets),
          pw.SizedBox(height: _gapMd),
          _section('EDUCATION'),
          ...CvData.education.map((e) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: _gapSm),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    _latinAts(e.degree),
                    style: _bodyStyle(bold: true),
                  ),
                  pw.Text(_latinAts(e.school), style: _bodyStyle()),
                  pw.Text(_latinAts(e.period), style: _bodyStyle()),
                ],
              ),
            );
          }),
          pw.SizedBox(height: _gapMd),
          _section('PUBLISHED APPLICATIONS'),
          ...CvData.publishedApps.expand((app) {
            return [
              pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: _gapSm),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(_latinAts(app.name), style: _bodyStyle(bold: true)),
                    ...app.stores.map(
                      (s) => pw.Text(
                        '${_latinAts(s.label)}: ${s.url}',
                        style: _bodyStyle(),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          }),
          pw.SizedBox(height: _gapMd),
          _section('LANGUAGES'),
          pw.Text(
            CvData.languages
                .map((l) => '${_latinAts(l.name)} (${_latinAts(l.level)})')
                .join(' | '),
            style: _bodyStyle(),
          ),
        ],
      ),
    );

    return doc.save();
  }

  static pw.Widget _header() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          _latinAts(CvData.name),
          style: pw.TextStyle(
            fontSize: _nameSize,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Text(
          _latinAts(CvData.title),
          style: pw.TextStyle(fontSize: _titleSize),
        ),
        pw.SizedBox(height: _gapSm),
        pw.Text(
          'Email: ${CvData.email} | Phone: ${_latinAts(CvData.phone)}',
          style: _bodyStyle(),
        ),
        pw.Text(
          'LinkedIn: ${_latinAts(CvData.linkedIn)}',
          style: _bodyStyle(),
        ),
      ],
    );
  }

  static pw.Widget _section(String title) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: _gapSm, top: 4),
      child: pw.Text(
        title,
        style: pw.TextStyle(
          fontSize: _sectionSize,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  static pw.TextStyle _bodyStyle({bool bold = false}) {
    return pw.TextStyle(
      fontSize: _bodySize,
      fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal,
      lineSpacing: 1.25,
    );
  }

  static pw.Widget _body(String text) {
    return pw.Text(text, style: _bodyStyle());
  }

  static Iterable<pw.Widget> _experienceWidgets(ExperienceItem item) {
    return [
      pw.Padding(
        padding: const pw.EdgeInsets.only(bottom: _gapMd),
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              '${_latinAts(item.company)} - ${_latinAts(item.location)}',
              style: _bodyStyle(bold: true),
            ),
            pw.Text(
              '${_latinAts(item.role)} | ${_latinAts(item.period)}',
              style: _bodyStyle(),
            ),
            pw.SizedBox(height: 4),
            ...item.highlights.map((h) => _bullet(_latinAts(h))),
            if (item.keyProjects.isNotEmpty) ...[
              pw.SizedBox(height: 4),
              pw.Text('Key projects:', style: _bodyStyle(bold: true)),
              ...item.keyProjects.map((p) => _bullet(_latinAts(p))),
            ],
          ],
        ),
      ),
    ];
  }

  static pw.Widget _bullet(String line) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 3),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('- ', style: _bodyStyle()),
          pw.Expanded(child: pw.Text(line, style: _bodyStyle())),
        ],
      ),
    );
  }
}
