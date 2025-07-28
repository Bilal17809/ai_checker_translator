# =============================
# Keep Google Mobile Ads SDK
# =============================
-keep class com.google.android.gms.ads.** { *; }
-keep interface com.google.android.gms.ads.** { *; }
-keep class com.google.android.gms.internal.ads.** { *; }
-dontwarn com.google.android.gms.internal.ads.**

# =============================
# Keep Firebase (if used)
# =============================
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# =============================
# Flutter & Dart rules (safe default)
# =============================
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**
