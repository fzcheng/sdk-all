1.在AndroidManifest.xml中添加权限配置:可从《SDK需要的权限.txt》中直接复制。
2.在AndroidManifest.xml中增加Activity配置:可从《SDK需要的配置.txt》中直接复制。
3.环境配置—将libs目录下所有的文件添加到工程的libs文件中
4.环境配置-将asserts目录下所有的文件添加到工程的asserts目录下（若是cocos2d工程，则应添加到resource之类的资源文件下）
5.计费样式配置—将values下的文件放到放到res/values目录下
6.配置AndroidManifest.xml属性
	a).AndroidManifest.xml中“应用包名”的字样，替换成应用真正的包名
	b).<meta-data
            android:name="COOL_PAY_PACKAGE_ID"
            android:value=“gf10002" />   将“gf10002”替换成平台提供包id
	c).<meta-data
            android:name="COOL_PAY_APP_ID"
            android:value="10002" />	将“10002”替换成平台提供的appid
7.初始化代码：
	//10002平台提供的appid	
	CocoPayManager.getInstance().init(AppActivity.this, 10002);
	//1001平台提供的idmsid channelid:可任意填写
	IDMSSdkMgr.Init(mContext, “1001”,”channelid”);
	IDMSSdkMgr.showLogin(this);
	IDMSSdkMgr.showFloat(this, 0);
8.代码调用计费：
	private void startPay() {
		JSONObject jsonObject = new JSONObject();
		try {
			jsonObject.put("propsName", mPropsName);	//道具描述名称—若开启二次确认作为二次确认展示使用
			jsonObject.put("chargeId”,”13000103”);		//平台分配的计费点id
			jsonObject.put("chargePrice”,3*100);	//道具价格—单位分（包月3元则填写：300）
			jsonObject.put("exData","ex Data");	//拓展数据，作为透传所用
			jsonObject.put("letuChargeId", "0");	//备份sdkid，由平台提供备份sdk的计费点id
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		CocoPayOrderInfo info = new CocoPayOrderInfo(jsonObject.toString());
		CocoPayManager.getInstance().startPay(AppActivity.this, info, new CocoPayCallbackListener() {
			
			@Override
			public void callback(int statusCode, CocoPayOrderInfo arg1) {
				// TODO Auto-generated method stub
				if (CocoPayStatusCode.CG_PAY_STATUS_CODE_SUCCEED == statusCode) {
					Toast.makeText(mContext, "购买成功！",
							Toast.LENGTH_LONG).show();
					
				} else {
					Toast.makeText(mContext, "购买失败", Toast.LENGTH_LONG)
							.show();
				}
			}
		});
	}
	