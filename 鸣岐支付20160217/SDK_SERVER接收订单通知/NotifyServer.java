 /**
     * 通知CP订单实例
     */
    public void callback(){
        Map<String,String> params = new HashMap<String,String>();
        Map<String,String[]> parameters = request.getParameterMap();
        for (Iterator<String> it = parameters.keySet().iterator(); it.hasNext();) {
            String k = it.next();
            String[] value = parameters.get(k);
            String v = (value == null) ? "": value[0];
            params.put(k, v);
            System.out.println(k+"="+v);
        }
        String secret = "h7dxh8iaivsbtddebo28kgiw8gfkd040";
        String queryString = getQueryString(params);
        log.info(queryString);
        String newSign = MD5.encodeUTF8(queryString+secret);
        String orderId = params.get("orderId");
        String ext = "";
        try {
             ext = URLEncoder.encode(params.get("ext"), "UTF-8");
        } catch (UnsupportedEncodingException e) {
        }
        String cpOrderId = params.get("cpOrderId");
        String appid = params.get("appid");
        String market = params.get("market");
        String nickname = params.get("nickname");
        String orderTime = params.get("orderTime");
        String payMode = params.get("payMode");
        String payTime = params.get("payTime");
        String status = params.get("status");
        String totalFee = params.get("totalFee");
        String userId = params.get("userId");
        String wares = params.get("wares");
        String waresId = params.get("waresId");
        String sign = params.get("sign");
        String returnMsg = "failure";
        if (sign.equals(newSign)) {
            log.info("验证签名通过");
            if ("200".equals(status)) {
                log.info("购买成功");
            }else {
                log.info("购买失败");
            }
            returnMsg = "success";
        } else {
            log.info("签名验证失败");
        }
        
        PrintWriter pw = null;
        try {
            response.setContentType("text/html;charset=UTF-8");
            pw = response.getWriter();
            pw.println(returnMsg);
            pw.flush();
        } catch (IOException e) {
            log.error("重新通知", e);
        } finally {
            if (pw != null) {
                pw.close();
            }
        }
    }
    
    /**
     * 
     * @param parameters
     * @return
     */
    private String getQueryString(Map<String,String> parameters) {
        Object[] keys = parameters.keySet().toArray();
        Arrays.sort(keys);
        StringBuffer buf = new StringBuffer();
        for (int index = 0; index < keys.length; index ++) {
            String key= (String)keys[index];
            if (key.equals("sign")) {
                continue;
            }
            String value = parameters.get(key);
            if (value == null) {
                value = "";
            }
            try {
                buf.append("&").append(key).append("=").append(URLEncoder.encode(value, "UTF-8"));;
            } catch (UnsupportedEncodingException e) {
            }
        }
        String queryString = buf.toString();
        if (!queryString.isEmpty()) {
            queryString = queryString.substring(1);
        }
        return queryString;
    }