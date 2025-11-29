package com.alerwann.password_robust_creator

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import androidx.core.view.WindowCompat // Nouvel import requis pour le Edge-to-Edge

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Définir la fenêtre pour dessiner derrière les barres système.
        // C'est l'étape nécessaire pour l'affichage Edge-to-Edge.
        WindowCompat.setDecorFitsSystemWindows(window, false) 
        
        super.onCreate(savedInstanceState)
    }
}