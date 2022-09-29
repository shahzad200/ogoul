package com.example.ogule

import android.util.Log
import com.github.nkzawa.engineio.client.transports.WebSocket
import com.github.nkzawa.socketio.client.Ack
import com.github.nkzawa.socketio.client.IO
import com.github.nkzawa.socketio.client.Socket
import com.google.gson.JsonObject
import org.json.JSONObject


class SocketIO private constructor() {
    private val TAG = this.javaClass.simpleName
    var socket: Socket? = null


    companion object {
        private var instance: SocketIO? = null

        @Synchronized
        fun getInstance(): SocketIO {
            if (instance == null) {
                instance = SocketIO()
            }
            return instance as SocketIO
        }
    }

    fun connectSocket(id: String) {
        if (socket?.connected() == true) {
            return
        }
        val opts = IO.Options()
        opts.forceNew = true
        opts.query = "user_id=${id}"
        opts.transports = arrayOf(WebSocket.NAME)
        socket = IO.socket("https://nodeapi.ogoullms.com/", opts)
        socket?.connect()

        socket?.on(Socket.EVENT_CONNECT) {
            logE("===============NEW SOCKET CONNECTED===============")
        }?.on(Socket.EVENT_DISCONNECT) {
            logE("===============NEW SOCKET DISCONNECTED===============")
        }
        logE("New Socket is connected")
    }

    fun disconnectSocket(){
        socket?.off()
    }


    fun sendLocation(userId: String, token: String, role: String,
                     lat: String?, lng : String, address : String?) {
//        val theMap = HashMap<String, String>()
        logE("UserId :$userId , ---:$token")

//        theMap["user_id"] = "683"
//        theMap["two"] = "683"

        val json = JsonObject()
        json.addProperty("user_id", userId)
        json.addProperty("token", token)
        json.addProperty("role", role)
        json.addProperty("lat", lat)
        json.addProperty("lng", lng)
        json.addProperty("address", address)
        logE("exchangeKeys :$json")

        socket?.emit("app_driver_location", json, Ack {
            val data = it[0] as JSONObject
            logE("ack of sendLocation :$data")
        })
    }

    fun returnFun(){

    }

    private fun logE(msg: String) {
        Log.e(TAG, msg)
    }
}