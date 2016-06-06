package cn.cmgame.demo;


import android.app.ListActivity;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.view.KeyEvent;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.*;
import android.widget.AdapterView.OnItemClickListener;
import cn.cmgame.billing.api.BillingResult;
import cn.cmgame.billing.api.GameInterface;
import cn.cmgame.billing.api.LoginResult;
import cn.cmgame.gamepad.api.Gamepad;
import cn.cmgame.gamepad.api.KeyState;
import cn.cmgame.leaderboard.api.GameLeaderboard;

import java.io.File;

public class MainActivity extends ListActivity {

  static final String[] BUTTONS = new String[]{
    "00.购买计费点：001",
    "01.购买计费点：002",
    "02.购买计费点：003",
    "03.购买计费点：004",
    "04.购买计费点：005",
    "05.购买计费点：006",
    "06.购买计费点：007",
    "07.购买计费点：008",
    "08.购买计费点：009",
    "09.购买计费点：010",
    "10.购买计费点：011",
    "11.购买计费点：012",
    "12.购买计费点：013",
    "13.购买计费点：014",
    "14.购买计费点：015",
    "15.更多游戏",
    "16.游戏音效",
    "17.截屏分享1",
    "18.截屏分享2",
    "19.退出游戏",
    "20.自定义事件"
  };


  /**
   * Called when the activity is first created.
   */
  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    //不显示程序的标题栏
    requestWindowFeature(Window.FEATURE_NO_TITLE);
    //不显示系统的标题栏
    getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);

    // 登陆流水号，CP自定义，可不填
    String loginNo = "0123456789012345";

    // 初始化SDK，并完成自动登陆
    GameInterface.initializeApp(this, "游戏名称", "提供商信息", "客服电话信息", loginNo, new GameInterface.ILoginCallback() {
      @Override
      public void onResult(int result, String userId, Object o) {
        if(result== LoginResult.SUCCESS_EXPLICIT || result==LoginResult.SUCCESS_IMPLICIT){
          Toast.makeText(MainActivity.this, "登陆成功!", Toast.LENGTH_SHORT).show();
        } else{
          Toast.makeText(MainActivity.this, "登陆失败!", Toast.LENGTH_SHORT).show();
        }
      }
    });
    
    // 计费结果的监听处理，合作方通常需要在收到SDK返回的onResult时，告知用户的购买结果
    final GameInterface.IPayCallback payCallback = new GameInterface.IPayCallback() {
      @Override
      public void onResult(int resultCode, String billingIndex, Object obj) {
        String result = "";
        switch (resultCode) {
          case BillingResult.SUCCESS:
		    if((BillingResult.EXTRA_SENDSMS_TIMEOUT+"").equals(obj.toString())){
	           result = "短信计费超时";
	        }else{
			   result = "购买道具：[" + billingIndex + "] 成功！";
		    }
            break;
          case BillingResult.FAILED:
            result = "购买道具：[" + billingIndex + "] 失败！";
            break;
          default:
            result = "购买道具：[" + billingIndex + "] 取消！";
            break;
        }
        Toast.makeText(MainActivity.this, result, Toast.LENGTH_SHORT).show();
      }
    };

    setListAdapter(new ArrayAdapter<String>(this, R.layout.main_menu_item, BUTTONS));
    ListView lv = getListView();
    lv.setOnItemClickListener(new OnItemClickListener() {
      public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        if (position==15) {
          // 主菜单界面添加：《更多游戏》入口，可选
          GameInterface.viewMoreGames(MainActivity.this);
        } else if (16 == position) {
          // 进入游戏后，游戏需要根据移动SDK启动页的音效设置结果，设置游戏音乐关闭还是开启
          Toast.makeText(MainActivity.this, "游戏是否开启音效：" + GameInterface.isMusicEnabled(), Toast.LENGTH_SHORT).show();
        }  else if (17 == position) {
          // 移动截屏分享功能：可选，需要接入时，请参考开发文档说明
          GameInterface.doScreenShotShare(MainActivity.this, null);
        } else if (18 == position) {
          // 移动截屏分享功能：可选，需要接入时，请参考开发文档说明
          GameInterface.doScreenShotShare(MainActivity.this, Uri.fromFile(new File(Environment
            .getExternalStorageDirectory()
            + "/Download/abc.png")));
        } else if (19 == position) {
          exitGame();
        }//自定义事件查询
        else if (20 == position) {
        	GameInterface.cpCustomEvent("DEC0001");
        }else{
        	// 计费功能
          String billingIndex =  getBillingIndex(position);
          GameInterface.doBilling(MainActivity.this, true, true, billingIndex, null, payCallback);
        }
      }
    });
  }

  private String getBillingIndex(int i) {
    if (i < 9) {
      return "00" + (++i);
    } else {
      return "0" + (++i);
    }
  }

  @Override
  public void onResume() {
    super.onResume();
  }

  private void exitGame() {
    // 移动退出接口，含确认退出UI
    // 如果外放渠道（非移动自有渠道）限制不允许包含移动退出UI，可用exitApp接口（无UI退出）
    GameInterface.exit(this, new GameInterface.GameExitCallback() {
      @Override
      public void onConfirmExit() {
        MainActivity.this.finish();
        System.exit(0);
      }

      @Override
      public void onCancelExit() {
        Toast.makeText(MainActivity.this, "取消退出", Toast.LENGTH_SHORT).show();
      }
    });
  }

  @Override
  public boolean onKeyDown(int keyCode, KeyEvent event) {
    if (keyCode == KeyEvent.KEYCODE_BACK) {
      exitGame();
      return true;
    }
    return super.onKeyDown(keyCode, event);
  }
}
