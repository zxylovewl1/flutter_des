package com.zerogis.plugin;

import android.content.Context;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class FlutterDesPlugin implements MethodCallHandler
{
    private Context ctx;

    private FlutterDesPlugin(Context context)
    {
        ctx = context;
    }

    public static void registerWith(Registrar registrar)
    {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_des");
        channel.setMethodCallHandler(new FlutterDesPlugin(registrar.context()));
    }

    @Override
    public void onMethodCall(MethodCall call, final Result result)
    {
        switch (call.method)
        {
            case "encrypt":
                int _major = call.argument("_major");
                int _minor = call.argument("_minor");
                String cmd = call.argument("cmd").toString();
                String sessionId = call.argument("sessionid").toString();

                int count = call.argument("count");
                String majorMinorCmd = "cmd="+ cmd + "&_major=" + _major + "&_minor=" + _minor;

                String secretKey = ((!isEmpty(sessionId) ? sessionId.substring(0, 2) : "") + count + "-whzbcx").substring(0, 8);
                DesUtil.setPassword(secretKey);
                String code = DesUtil.encrypt(majorMinorCmd);
                result.success(code);
                break;
            default:
                result.notImplemented();
                break;
        }
    }


    /**
     * 校验是否为空
     *
     * @param value 值
     * @return true = 为空
     */
    public boolean isEmpty(Object value)
    {
        if (value == null)
        {
            return true;
        }
        else if (0 == value.toString().length())
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}
