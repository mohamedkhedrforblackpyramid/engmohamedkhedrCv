/// Static CV/portfolio data for Mohamed Omar Khedr.

class CvData {
  static const String name = 'Mohamed Omar Khedr';
  static const String title = 'Lead Mobile Developer | Software Engineer';
  static const String email = 'mohamed.khedr0001@gmail.com';
  static const String phone = '+20 106 836 1867';
  static const String linkedIn = 'https://www.linkedin.com/in/mohamed-khedr-71bb41242/';

  static const String summary = 
      'Lead Flutter Developer with 6+ years of experience building scalable '
      'cross-platform iOS & Android applications. Expert in SaaS, SCADA industrial '
      'systems, fintech, healthcare, and dashboards. Skilled in Flutter, Dart, '
      'Firebase, BLoC, Provider, RESTful APIs, payment integration, admin panel '
      'development, and full App Store & Google Play deployment. Proven ability '
      'to optimize performance, enhance UI/UX, and deliver enterprise-level solutions.';

  static const Map<String, List<String>> coreSkills = {
    'Languages & Frameworks': ['Flutter', 'Dart', 'Clean Architecture', 'Swift', 'Java', 'Kotlin'],
    'State Management': ['BLoC', 'Provider', 'Riverpod', 'MobX'],
    'Backend & Database': ['RESTful APIs', 'Firebase (FCM, Auth, Firestore)', 'MySQL'],
    'Payments & Subscriptions': [
      'Multi-tenant SaaS',
      'Payment Gateway Integration',
      'Subscription Systems',
    ],
    'Admin & Dashboards': [
      'Admin Panel Development',
      'Dashboards',
      'SCADA Integration',
    ],
    'Deployment & CI/CD': [
      'App Store & Google Play Deployment',
      'CI/CD',
      'Release Management',
    ],
    'Version Control': ['Git', 'GitHub', 'GitLab', 'Bitbucket'],
    'Other Skills': ['UI/UX Optimization', 'Performance Tuning', 'Agile Development'],
  };

  static const List<ExperienceItem> experience = [
    ExperienceItem(
      company: 'Together Apps',
      location: 'Canada',
      role: 'Lead Flutter Developer',
      period: 'Jan 2025 – Present',
      highlights: [
        'Led development of a large-scale multi-tenant SaaS platform with dashboards, '
            'admin panel, notifications, and integrated payment system.',
        'Managed full release cycles for App Store & Google Play, including '
            'certificates, versioning, and compliance.',
        'Optimized performance and scalability for enterprise-level applications.',
        'Collaborated with international agile teams and ensured clean modular architecture.',
      ],
      keyProjects: [
        'Enterprise SaaS Platform: Subscription billing, real-time notifications, '
            'analytics dashboards, and admin panel.',
      ],
    ),
    ExperienceItem(
      company: 'AlexApps',
      location: 'Alexandria, Egypt',
      role: 'Flutter Developer',
      period: 'Sep 2019 – Present',
      highlights: [
        'Delivered fintech, sales, healthcare, HR, university, and industrial SCADA applications.',
        'Managed full development lifecycle, optimized UI/UX, and app performance.',
      ],
      keyProjects: [
        'AlexSeeds: SCADA production monitoring system for oil factories – 5 apps '
            'for real-time monitoring, breakdown logging, performance analytics, dashboards.',
        'Moola Pay: Mobile payment solution with secure, real-time transactions.',
        'Sales App: Order tracking, customer management, reporting.',
        'Quicky Clean: Service booking & scheduling app with notifications.',
        'Pronto: On-demand service management platform.',
        'Power Look: Healthcare operational management and reporting.',
        'Healthcare App: Patient management, appointments, analytics.',
        'HR Management System: Attendance, leave, permission, task/project management, dashboards.',
        'E-Just University Booking: Lab booking, professor scheduling, student communication, analytics.',
        'El-Gharably: Resource & Collection Management, invoice requests, real-time tracking, dashboards.',
      ],
    ),
    ExperienceItem(
      company: 'Freelance',
      location: 'Saudi Arabia',
      role: 'Flutter Developer',
      period: 'Oct 2020 – Present',
      highlights: [
        'Delivered custom applications, fixed technical issues, optimized performance '
            'and user experience for clients.',
      ],
      keyProjects: [],
    ),
  ];

  static const String educationDegree = 'B.Sc. Software Engineering';
  static const String educationSchool = 'AUA University';
  static const String educationPeriod = '2014 – 2018';

  static const List<LanguageItem> languages = [
    LanguageItem(name: 'Arabic', level: 'Native'),
    LanguageItem(name: 'English', level: 'Professional'),
  ];

  /// تطبيقات منشورة على المتاجر (اسم التطبيق + روابط المتاجر)
  static const List<PublishedApp> publishedApps = [
    PublishedApp(
      name: 'Quicky Clean | كويكي كلين',
      stores: [
        StoreLink(label: 'Google Play', url: 'https://play.google.com/store/apps/details?id=com.quickyclean.quickycleanapp'),
      ],
    ),
    PublishedApp(
      name: 'MOOLA: Cards & Expenses',
      stores: [
        StoreLink(label: 'Google Play', url: 'https://play.google.com/store/apps/details?id=com.moolapay.moola'),
        StoreLink(label: 'App Store', url: 'https://apps.apple.com/us/app/moola-cards-expenses/id6450668915'),
      ],
    ),
    PublishedApp(
      name: 'The Health Care | الرعاية الصحية',
      stores: [
        StoreLink(label: 'Google Play', url: 'https://play.google.com/store/apps/details?id=co.itplus.co'),
        StoreLink(label: 'App Store', url: 'https://apps.apple.com/us/app/%D8%A7%D9%84%D8%B1%D8%B9%D8%A7%D9%8A%D8%A9-%D8%A7%D9%84%D8%B5%D8%AD%D9%8A%D8%A9/id941346493'),
      ],
    ),
    PublishedApp(
      name: 'Master Tip',
      stores: [
        StoreLink(label: 'Google Play', url: 'https://play.google.com/store/apps/details?id=com.alexapps.masterTip.master_tip'),
      ],
    ),
    PublishedApp(
      name: 'Beaat بيعات',
      stores: [
        StoreLink(label: 'Google Play', url: 'https://play.google.com/store/apps/details?id=com.alexapps.beaat'),
        StoreLink(label: 'App Store', url: 'https://apps.apple.com/us/app/beaat-%D8%A8%D9%8A%D8%B9%D8%A7%D8%AA/id1602350262'),
      ],
    ),
  ];
}

class StoreLink {
  final String label;
  final String url;
  const StoreLink({required this.label, required this.url});
}

class PublishedApp {
  final String name;
  final List<StoreLink> stores;

  const PublishedApp({required this.name, required this.stores});
}

class ExperienceItem {
  final String company;
  final String location;
  final String role;
  final String period;
  final List<String> highlights;
  final List<String> keyProjects;

  const ExperienceItem({
    required this.company,
    required this.location,
    required this.role,
    required this.period,
    required this.highlights,
    required this.keyProjects,
  });
}

class LanguageItem {
  final String name;
  final String level;

  const LanguageItem({required this.name, required this.level});
}
