plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // Appliquer le plugin Google services
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

android {
    compileSdkVersion(31) // Remplace par la version cible que tu utilises

    defaultConfig {
        applicationId = "com.example.mon_app_rencontre" // Remplace par ton ID d'application
        minSdkVersion(21) // Choisis la version minimale supportée
        targetSdkVersion(31) // Remplace par la version cible que tu utilises
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

dependencies {
    implementation("com.google.firebase:firebase-analytics-ktx") // Firebase Analytics
    implementation("com.google.firebase:firebase-auth-ktx") // Firebase Authentication
    implementation("com.google.firebase:firebase-firestore-ktx") // Firebase Firestore
    implementation("com.google.firebase:firebase-storage-ktx") // Firebase Storage si nécessaire

    // Autres dépendances de Firebase ou de ton projet si besoin
    implementation("com.google.android.gms:play-services-auth:20.1.0") // Google sign-in (si utilisé)

    // Ajoute tes autres dépendances ici si nécessaire
}

// Appliquer le plugin Google Services
apply(plugin = "com.google.gms.google-services")
 