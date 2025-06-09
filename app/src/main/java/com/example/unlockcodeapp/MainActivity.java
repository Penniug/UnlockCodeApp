package com.example.unlockcodeapp;

import android.os.Bundle;
import android.util.Base64;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.ScrollView;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;

import java.io.DataOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;

public class MainActivity extends AppCompatActivity {

    private static final String AES_KEY = "ASDFGHJKLASDFGHI";
    private TextView logView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        LinearLayout layout = new LinearLayout(this);
        layout.setOrientation(LinearLayout.VERTICAL);

        Button execButton = new Button(this);
        execButton.setText("执行解锁指令");
        layout.addView(execButton);

        logView = new TextView(this);
        ScrollView scrollView = new ScrollView(this);
        scrollView.addView(logView);
        layout.addView(scrollView);

        setContentView(layout);

        execButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String vin = "00000000000000000";
                String currentDate = getCurrentDate();
                String input = vin + currentDate;
                String unlockCode = generateUnlockCode(input);

                log("生成解锁码: " + unlockCode);

                String shellCommand = "settings put global dev_adb_auth_passwd " + unlockCode;
                executeShellCommandAsRoot(shellCommand);
                log("已执行系统设置命令");
            }
        });
    }

    private String getCurrentDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.getDefault());
        return sdf.format(new Date());
    }

    private String generateUnlockCode(String input) {
        try {
            SecretKeySpec keySpec = new SecretKeySpec(AES_KEY.getBytes(), "AES");
            Cipher cipher = Cipher.getInstance("AES/ECB/PKCS5Padding");
            cipher.init(Cipher.ENCRYPT_MODE, keySpec);
            byte[] encrypted = cipher.doFinal(input.getBytes("UTF-8"));
            String base64Encrypted = Base64.encodeToString(encrypted, Base64.NO_WRAP);
            return base64Encrypted.substring(base64Encrypted.length() - 9);
        } catch (Exception e) {
            e.printStackTrace();
            log("加密失败: " + e.getMessage());
            return "ERROR";
        }
    }

    private void executeShellCommandAsRoot(String command) {
        try {
            Process su = Runtime.getRuntime().exec("su");
            DataOutputStream os = new DataOutputStream(su.getOutputStream());
            os.writeBytes(command + "\n");
            os.writeBytes("exit\n");
            os.flush();
            su.waitFor();
        } catch (Exception e) {
            e.printStackTrace();
            log("执行命令失败: " + e.getMessage());
        }
    }

    private void log(String message) {
        logView.append(message + "\n");
    }
}
