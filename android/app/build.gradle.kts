import java.io.File
import java.io.FileInputStream
import java.util.*

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val keyProperties = Properties().apply {
    load(FileInputStream(File("keystore.properties")))
}
val detKeyAlias = keyProperties.getProperty("keyAlias")
require(detKeyAlias != null) { "keyAlias not found in key.properties file." }
val detKeyPassword = keyProperties.getProperty("keyPassword")
val detStoreFile = keyProperties.getProperty("storeFile")
val detStorePassword = keyProperties.getProperty("storePassword")

android {
    namespace = "com.moazsalem.playground"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    defaultConfig {
        applicationId = "com.moazsalem.playground"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = detKeyAlias
            keyPassword = detKeyPassword
            storeFile = file(detStoreFile)
            storePassword = detStorePassword
        }
    }
    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now,
            // so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}
