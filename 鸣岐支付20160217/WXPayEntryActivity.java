package �㵱ǰ�İ���.wxapi;

import android.os.Bundle;

import com.mq.pay.wx.WxPayActivity;

/**
 * ��Ҫ��������ֻ��Ҫ�޸�Ϊ��Ӧ�İ�����΢��appid���ɣ�
 * 
 * AndroidManifest.xml�е��������£�
 * 
 *  <activity android:name=".wxapi.WXPayEntryActivity" android:exported="true"
 *           android:launchMode="singleTop"/> 
 *          
 */
public class WXPayEntryActivity extends WxPayActivity {

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		super.init("wx28e6aaa8d86aaa08");// ΢��appID
	}
}