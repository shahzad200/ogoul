package com.example.ogule

import io.flutter.embedding.android.FlutterActivity
import android.content.Intent
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.ogoul.driver/driver"
    private var result: MethodChannel.Result? = null
    var serviceIntent: Intent? = null
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        serviceIntent = Intent(this@MainActivity, LocationService::class.java)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "driverOnline") {
                val driverId = call.argument<String>("driverId")
                val token = call.argument<String>("token")
                val role = call.argument<String>("role")
                print("DERIVERID------{$driverId}")
                SocketIO.getInstance().connectSocket(driverId.toString());
                println("DRIVER IIIDDDDD$driverId")
                serviceIntent!!.putExtra("spec_id", driverId)
                serviceIntent!!.putExtra("token", token)
                serviceIntent!!.putExtra("role", role)
                startService(serviceIntent)
                result.success("success")
            }
            if (call.method == "driverOffline") {
//                val driverId = call.argument<String>("driverId")
//                println("DRIVER IIIDDDDD$driverId")
//                serviceIntent!!.putExtra("spec_id", driverId)
                stopService(serviceIntent)
                SocketIO.getInstance().disconnectSocket()
                result.success("success")
            }
        }
    }

}

