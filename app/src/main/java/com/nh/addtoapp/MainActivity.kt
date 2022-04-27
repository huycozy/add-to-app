package com.nh.addtoapp

import android.annotation.SuppressLint
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.TextView

class MainActivity : AppCompatActivity() {
    private lateinit var counterLabel: TextView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        counterLabel = findViewById(R.id.counter_label)

        val button = findViewById<Button>(R.id.launch_button)

        button.setOnClickListener {
//            val intent = FlutterActivity
//                    .withCachedEngine(ENGINE_ID)
//                    .build(this)
//            startActivity(intent)
            startActivity(Intent(this, DynamicLinkFlutterActivity::class.java))
        }

    }

    @SuppressLint("SetTextI18n")
    override fun onResume() {
        super.onResume()
        val app = application as App
        counterLabel.text = "Current count: ${app.count}"
    }
}