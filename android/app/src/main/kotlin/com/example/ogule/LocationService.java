package com.example.ogule;



import android.Manifest;
import android.annotation.SuppressLint;
import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.os.Build;
import android.os.IBinder;
import android.os.Looper;
import android.util.Log;
import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.app.NotificationCompat;
import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationCallback;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationResult;
import com.google.android.gms.location.LocationServices;

import java.util.List;
import java.util.Locale;


public class LocationService extends Service {
    private static final String TAG = "LocationService";
    private FusedLocationProviderClient mFusedLocationClient;
    private final static long UPDATE_INTERVAL = 2000;
    private final static long FASTEST_INTERVAL = 500;
    String CHANNEL_ID = "Driver";
    String driverId;
    String token;
    String role;
    LocationCallback mLocationCallback;
    @Override
    public void onCreate() {
        super.onCreate();
        mFusedLocationClient = LocationServices.getFusedLocationProviderClient(this);
        createNotificationChannel();
        System.out.print("HELLOOOOEE");
        Intent notificationIntent = new Intent(this, MainActivity.class);
        PendingIntent pendingIntent = PendingIntent.getActivity(this,
                0, notificationIntent, 0);
        Notification notification = new NotificationCompat.Builder(this, CHANNEL_ID)
                .setContentTitle("Ogule Driver")
                .setContentText("You are currently Online")
                .setSmallIcon(R.mipmap.ic_launcher)
                .setContentIntent(pendingIntent)
                .build();
        startForeground(1, notification);
    }
    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }


    ///////////////////////////
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        driverId = intent.getStringExtra("spec_id");
        token = intent.getStringExtra("token");
        role = intent.getStringExtra("role");
        getLocation();
        return START_NOT_STICKY;

    }

    /////////////
    @SuppressLint("MissingPermission")
    private void getLocation() {
        LocationRequest mLocationRequestHighAccuracy = new LocationRequest();
        mLocationRequestHighAccuracy.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
        mLocationRequestHighAccuracy.setInterval(UPDATE_INTERVAL);
        mLocationRequestHighAccuracy.setFastestInterval(FASTEST_INTERVAL);
        if (ActivityCompat.checkSelfPermission(this,
                Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            Log.d(TAG, "getLocation: stopping the location service.");
            stopSelf();
            return;
        }
        Log.d(TAG, "getLocation: getting location information.");
        mFusedLocationClient.requestLocationUpdates(mLocationRequestHighAccuracy, mLocationCallback = new LocationCallback() {
                    @Override
                    public void onLocationResult(LocationResult locationResult) {
                        Log.d(TAG, "onLocationResult: got location result.");
                        Location location = locationResult.getLastLocation();
                        if (location != null) {
                            getAddress(getApplicationContext(), location.getLatitude(),location.getLongitude());
                            Log.d(TAG, location.getLatitude()+"onLocationResult: got location result."+location.getLongitude());
                            Log.d(TAG, "onLocationResult: "+location.getLatitude()+"-----"+location.getLongitude());
                            SocketIO.Companion.getInstance().sendLocation(driverId,token,
                                    role,String.valueOf(location.getLatitude()),
                                    String.valueOf(location.getLongitude()),getAddress(getApplicationContext(), location.getLatitude(),location.getLongitude()));
                        }
                    }
                },
                Looper.myLooper());// Looper.myLooper tells this to repeat forever until thread is destroyed
    }
    @Override
    public void onDestroy() {
        super.onDestroy();
        stopLocationUpdates();
    }

    private void stopLocationUpdates(){
        if (mFusedLocationClient != null) {
            mFusedLocationClient.removeLocationUpdates(mLocationCallback);
        }
    }






    private void createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel serviceChannel = new NotificationChannel(
                    CHANNEL_ID,
                    "Foreground Service Channel",
                    NotificationManager.IMPORTANCE_DEFAULT
            );
            NotificationManager manager = getSystemService(NotificationManager.class);
            manager.createNotificationChannel(serviceChannel);
        }
    }

    String getAddress(Context context, Double lat,Double lng){
        System.out.print("THIS IS IN ADDRESS SECTION---->");
        String address = "";
        try{
            Geocoder geo = new Geocoder(context , Locale.getDefault());
            List<Address> addresses = geo.getFromLocation(lat,lng,1);
            if(!addresses.isEmpty()){
                address = addresses.get(0).getAddressLine(0);
            }

        }catch (Exception e){
            System.out.print("EXCEPTION ON ADDRESS---->"+e.toString());
        }
        System.out.print("ADDRESS SUCCESS---->"+address);
        return address;
    }

}

