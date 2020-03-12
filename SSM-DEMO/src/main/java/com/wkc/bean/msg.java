package com.wkc.bean;

import java.util.HashMap;
import java.util.Map;

public class msg {
    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Map<String, Object> getExtend() {
        return extend;
    }

    public void setExtend(Map<String, Object> extend) {
        this.extend = extend;
    }

    private int code;
    private String msg;
    private Map<String, Object> extend = new HashMap<>();

    public static msg success() {
        com.wkc.bean.msg msg = new msg();
        msg.setCode(100);
        msg.setMsg("处理成功");
        return msg;
    }

     public  static  msg fail(){
         msg msg = new msg();
         msg.setCode(200);
         msg.setMsg("处理失败");
         return msg;
     }
    public msg add(String key,Object object){
        this.extend.put(key, object);
        return this;
    }

}
