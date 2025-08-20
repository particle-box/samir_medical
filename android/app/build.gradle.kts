// android/app/build.gradle.kts
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.samir_medical_clean" // TODO: set to your actual package
    compileSdk = flutter.compileSdkVersion

    // Keep only if a plugin explicitly requires this NDK version
    ndkVersion = "28.1.13356709"

    defaultConfig {
        applicationId = "com.example.samir_medical" // TODO: set to your actual app id
        // Native multidex (>=21) since desugaring + plugins may exceed 64K methods
        minSdk = maxOf(21, flutter.minSdkVersion)
        targetSdk = flutter.targetSdkVersion

        versionCode = flutter.versionCode.toInt()
        versionName = flutter.versionName

        multiDexEnabled = true
    }

    compileOptions {
        // Java 17 for the app
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        // Needed for Java 8+ APIs/time APIs on older Android
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    buildTypes {
        debug {
            // Do NOT shrink in debug
            isMinifyEnabled = false
            isShrinkResources = false
        }
        release {
            // Keep off for now; enable together later when you add rules
            isMinifyEnabled = false
            isShrinkResources = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Kotlin BOM (optional)
    implementation(platform("org.jetbrains.kotlin:kotlin-bom:2.1.0"))

    // Multidex runtime
    implementation("androidx.multidex:multidex:2.0.1")

    // Core library desugaring (required by some plugins like package_info_plus)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
