package com.wjbrain.live;

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import android.Manifest;
import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
//import android.os.Bundle;
//import io.flutter.embedding.android.FlutterActivity;
//import io.flutter.plugin.common.MethodChannel;
//import com.fiture.ai.bridge.Callback; //
//import com.fiture.aiinfra.bean.Mode; //
//import com.fiture.aiinfra.logger.LogReport; //
//import com.fiture.aiinfra.utils.Constant; //
//import com.fiture.aiinfra.utils.Logs; //
//import com.fiture.aivision.FitureAI;
//import com.fiture.visionservicedemo.R; //
//import com.fiture.visionservicedemo.constant.Constants; //
//import com.fiture.visionservicedemo.util.SPUtils; //
//import com.fiture.visionservicedemo.util.ToastUtils; //
//import com.fiture.visionservicedemo.widget.RecyclerData; //
//import com.fiture.visionservicedemo.widget.RecyclerViewAdapter; //

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "live.wjbrain.com/fiture";
//
//    private static final String TAG = "HomeActivity";
//
//    private static final int PERMISSION_REQUEST_CODE = 200;
//
//    private Context mContext;
//    private final String[] permissions = {Manifest.permission.CAMERA,
//            Manifest.permission.WRITE_EXTERNAL_STORAGE,
//            Manifest.permission.READ_PHONE_STATE,
//            Manifest.permission.INTERNET};


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
//        System.out.println("FitureAI = " + FitureAI);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // This method is invoked on the main thread.
                            // TODO
                            if (call.method.equals("getBatteryLevel")) {
                                int batteryLevel = getBatteryLevel();
                                if (batteryLevel != -1) {
                                    result.success(batteryLevel);
                                } else {
                                    result.error("UNAVAILABLE", "Battery level not available.", null);
                                }
                            } else if (call.method.equals("initVisionSDK")) {
                                result.success(initVisionSDK());
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    private int getBatteryLevel() {
        int batteryLevel = -1;
        if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }

        return batteryLevel;
    }


//    private final Callback mSDKInitCallback = new Callback() {
//        @Override
//        public void onResult(int type, @NonNull Object result) {
//            Logs.d(TAG, "sdk init result: " + Integer.toHexString(type));
//            if (type == Constant.RESULT_VERSION_INFO) {
//                SPUtils.putBool(mContext, Constants.AISDK_INIT, true);
//                ToastUtils.toast(mContext, "SDK 初始化成功 ！！！");
//            }
//        }
//
//        @Override
//        public void onError(int code, @NonNull String msg) {
//            Logs.e(TAG, "sdk init error: " + Integer.toHexString(code) + " msg: " + msg);
//        }
//    };

    private String initVisionSDK() {
        return "success";
//        mContext = getApplicationContext();
//        //2：此处模拟在应用进程创建的时候就去初始化SDK
//        LogReport.getInstance().initNetWork(mContext);
//        FitureAI.getInstance().init(mContext, mSDKInitCallback);
    }
}
