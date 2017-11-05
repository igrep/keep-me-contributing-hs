# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in C:\android-sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile

-keep public class keep_me_contributing_hs.keepmecontributinghs.Github {
  org.kohsuke.github.GHRepository getRepository();
}

# https://brianmckenna.org/blog/eta_android
-dontwarn base.**
-dontwarn eta.**
-dontwarn ghc_prim.**
-dontwarn integer.**
-dontwarn main.**

# https://github.com/typelead/eta/blob/master/proguard/eta.pro
-keep public class base.ghc.TopHandler {
  eta.runtime.stg.Closure flushStdHandles();
}
-keep public class base.ghc.conc.Sync {
  eta.runtime.stg.Closure runSparks() ;
}
-keep public class base.control.exception.Base {
  eta.runtime.stg.Closure nonTermination();
  eta.runtime.stg.Closure nestedAtomically();
}
-keep public class base.ghc.Weak {
  eta.runtime.stg.Closure runFinalizerBatch();
}

-keep class deepseq.control.** {
  eta.runtime.stg.Closure *;
}

# https://github.com/square/okhttp/issues/2230
-dontwarn com.squareup.okhttp.**
-keep class com.squareup.okhttp.* { *;}
-dontwarn com.squareup.okhttp3.**
-keep class com.squareup.okhttp3.* { *;}

-dontwarn okhttp3.**

-dontwarn edu.umd.cs.findbugs.annotations.**

-dontwarn javax.**

# https://github.com/FasterXML/jackson-databind/issues/1504
-keep @com.fasterxml.jackson.annotation.JsonIgnoreProperties class * { *; }
-keep class com.fasterxml.** { *; }
-keep class org.codehaus.** { *; }
-keepnames class com.fasterxml.jackson.** { *; }
-keepclassmembers public final enum com.fasterxml.jackson.annotation.JsonAutoDetect$Visibility {
    public static final com.fasterxml.jackson.annotation.JsonAutoDetect$Visibility *;
}

# For jackson
-dontwarn org.w3c.dom.bootstrap.**
-dontwarn java.beans.**
