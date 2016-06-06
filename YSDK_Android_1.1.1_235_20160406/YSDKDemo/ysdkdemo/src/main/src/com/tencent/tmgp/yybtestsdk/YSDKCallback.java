package com.tencent.tmgp.yybtestsdk;

import android.app.Activity;
import android.util.Log;
import android.widget.Toast;

import com.tencent.ysdk.framework.common.eFlag;
import com.tencent.ysdk.module.bugly.BuglyListener;
import com.tencent.ysdk.module.pay.PayListener;
import com.tencent.ysdk.module.pay.PayRet;
import com.tencent.ysdk.module.user.PersonInfo;
import com.tencent.ysdk.module.user.UserListener;
import com.tencent.ysdk.module.user.UserLoginRet;
import com.tencent.ysdk.module.user.UserRelationRet;
import com.tencent.ysdk.module.user.WakeupRet;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/** 
 * TODO GAME 游戏需要根据自己的逻辑实现自己的YSDKCallback对象。 
 * YSDK通过UserListener抽象类中的方法将授权或查询结果回调给游戏。
 * 游戏根据回调结果调整UI等。只有设置回调，游戏才能收到YSDK的响应。
 * 这里是Java层回调(设置了Java层回调会优先调用Java层回调, 如果要使用C++层回调则不能设置Java层回调)
 */
public class YSDKCallback implements UserListener, BuglyListener,PayListener {
    public static MainActivity mainActivity;

    
    public YSDKCallback(Activity activity) {
    	mainActivity = (MainActivity) activity;
    }
    
    public void OnLoginNotify(UserLoginRet ret) {
        Log.d(MainActivity.LOG_TAG,"called");
        Log.d(MainActivity.LOG_TAG,ret.getAccessToken());
        Log.d(MainActivity.LOG_TAG,"ret.flag" + ret.flag);
        mainActivity.stopWaiting();
        switch (ret.flag) {
            case eFlag.Succ:
                mainActivity.letUserLogin();
                break;
            // 游戏逻辑，对登陆失败情况分别进行处理
            case eFlag.User_QQ_NetworkErr:
            case eFlag.User_WX_UserCancel:
            case eFlag.User_WX_NotInstall:
            case eFlag.User_WX_NotSupportApi:
            case eFlag.User_WX_LoginFail:
            case eFlag.User_QQ_LoginFail:
            case eFlag.User_LocalTokenInvalid:
                Toast.makeText(mainActivity.getApplicationContext(), "login error : ret=" + ret.flag + " msg=" + ret.msg, Toast.LENGTH_LONG).show();
                Log.d(MainActivity.LOG_TAG,ret.toString());
                // 显示登陆界面
                mainActivity.letUserLogout();
                break;
            default:
                // 显示登陆界面
                mainActivity.letUserLogout();
                break;
        }
    }

    public void OnWakeupNotify(WakeupRet ret) {
        Log.d(MainActivity.LOG_TAG,"called");
        Log.d(MainActivity.LOG_TAG,"flag:" + ret.flag);
        Log.d(MainActivity.LOG_TAG,"msg:" + ret.msg);
        Log.d(MainActivity.LOG_TAG,"platform:" + ret.platform);
        MainActivity.platform = ret.platform;
        // TODO GAME 游戏需要在这里增加处理异账号的逻辑
        if (eFlag.Succ == ret.flag
                || eFlag.User_NeedSelectAccount == ret.flag) {
            //eFlag_AccountRefresh代表 刷新微信票据成功
            Log.d(MainActivity.LOG_TAG,"login success flag:" + ret.flag);
            mainActivity.letUserLogin();
        } else if (eFlag.User_UrlLogin == ret.flag) {
            // 用拉起的账号登录，登录结果在OnLoginNotify()中回调
        } else if (ret.flag == eFlag.User_NeedSelectAccount) {
            // 异账号时，游戏需要弹出提示框让用户选择需要登陆的账号
            Log.d(MainActivity.LOG_TAG,"diff account");
            mainActivity.showDiffLogin();
        } else if (ret.flag == eFlag.User_NeedLogin) {
            // 没有有效的票据，登出游戏让用户重新登录
            Log.d(MainActivity.LOG_TAG,"need login");
            mainActivity.letUserLogout();
        } else {
            Log.d(MainActivity.LOG_TAG,"logout");
            mainActivity.letUserLogout();
        }
    }

    @Override
    public void OnRelationNotify(UserRelationRet relationRet) {
    	String result = "";
        result = result +"flag:" + relationRet.flag + "\n";
        result = result +"msg:" + relationRet.msg + "\n";
        result = result +"platform:" + relationRet.platform + "\n";
        if (relationRet.persons != null && relationRet.persons.size()>0) {
            PersonInfo personInfo = (PersonInfo)relationRet.persons.firstElement();
            StringBuilder builder = new StringBuilder();
            builder.append("UserInfoResponse json: \n");
            builder.append("nick_name: " + personInfo.nickName + "\n");
            builder.append("open_id: " + personInfo.openId + "\n");
            builder.append("userId: " + personInfo.userId + "\n");
            builder.append("gender: " + personInfo.gender + "\n");
            builder.append("picture_small: " + personInfo.pictureSmall + "\n");
            builder.append("picture_middle: " + personInfo.pictureMiddle + "\n");
            builder.append("picture_large: " + personInfo.pictureLarge + "\n");
            builder.append("provice: " + personInfo.province + "\n");
            builder.append("city: " + personInfo.city + "\n");
            builder.append("country: " + personInfo.country + "\n");
            builder.append("is_yellow_vip: " + personInfo.is_yellow_vip + "\n");
            builder.append("is_yellow_year_vip: " + personInfo.is_yellow_year_vip + "\n");
            builder.append("yellow_vip_level: " + personInfo.yellow_vip_level + "\n");
            builder.append("is_yellow_high_vip: " + personInfo.is_yellow_high_vip + "\n");
            result = result + builder.toString();
        } else {
            result = result + "relationRet.persons is bad";
        }
        Log.d(MainActivity.LOG_TAG,"OnRelationNotify" + result);

        // 发送结果到结果展示界面
       mainActivity.sendResult(result);
    }


    @Override
    public String OnCrashExtMessageNotify() {
        // 此处游戏补充crash时上报的额外信息
        Log.d(MainActivity.LOG_TAG,String.format(Locale.CHINA, "OnCrashExtMessageNotify called"));
        Date nowTime = new Date();
        SimpleDateFormat time = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        return "new Upload extra crashing message for bugly on " + time.format(nowTime);
    }

	@Override
	public byte[] OnCrashExtDataNotify() {
		// TODO Auto-generated method stub
		return null;
	}

    @Override
    public void OnPayNotify(PayRet ret) {
        Log.d(MainActivity.LOG_TAG,ret.toString());
        if(PayRet.RET_SUCC == ret.ret){
            //支付流程成功
            switch (ret.payState){
                //支付成功
                case PayRet.PAYSTATE_PAYSUCC:
                    mainActivity.sendResult(
                            "用户支付成功，支付金额"+ret.realSaveNum+";" +
                            "使用渠道："+ret.payChannel+";" +
                            "发货状态："+ret.provideState+";" +
                            "业务类型："+ret.extendInfo+";建议查询余额："+ret.toString());
                    break;
                //取消支付
                case PayRet.PAYSTATE_PAYCANCEL:
                    mainActivity.sendResult("用户取消支付："+ret.toString());
                    break;
                //支付结果未知
                case PayRet.PAYSTATE_PAYUNKOWN:
                    mainActivity.sendResult("用户支付结果未知，建议查询余额："+ret.toString());
                    break;
                //支付失败
                case PayRet.PAYSTATE_PAYERROR:
                    mainActivity.sendResult("支付异常"+ret.toString());
                    break;
            }
        }else{
            switch (ret.flag){
                case eFlag.User_LocalTokenInvalid:
                    //用户取消支付
                    mainActivity.sendResult("登陆态过期，请重新登陆："+ret.toString());
                    mainActivity.letUserLogout();
                    break;
                case eFlag.Pay_User_Cancle:
                    //用户取消支付
                    mainActivity.sendResult("用户取消支付："+ret.toString());
                    break;
                case eFlag.Pay_Param_Error:
                    mainActivity.sendResult("支付失败，参数错误"+ret.toString());
                    break;
                case eFlag.Error:
                default:
                    mainActivity.sendResult("支付异常"+ret.toString());
                    break;
            }
        }
    }
}

