package com.feng.controller;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.ShearCaptcha;
import cn.hutool.core.map.MapUtil;
import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpUtil;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @Author shf
 * @Date 2020/11/24 10:02
 */
@RestController
@RequestMapping("/index")
public class IndexController {
    @GetMapping("/user")
    public String getIndex(){
        return "hello,i am shf";
    }

    @GetMapping("/data")
    public Object getData(){
        return MapUtil.builder().put("name","shf").put("age",21).build();
    }

    @GetMapping("/getCode")
    public void getCode(HttpServletResponse response){
        ShearCaptcha shearCaptcha = CaptchaUtil.createShearCaptcha(200, 100, 4, 4);
        System.out.println(shearCaptcha.getCode());
        try {
            shearCaptcha.write(response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @GetMapping("/get")
    public void get(){
        String s = HttpUtil.get("http://localhost:8888/index/getCode");
        System.out.println(s);
    }
    @GetMapping("/getString")
    public void getString(){
        String body = HttpRequest.get("http://www.baidu.com").execute().body();
        System.out.println(body);
    }
    @GetMapping("/getJson")
    public void getJson(){
        String body = HttpUtil.get("http://localhost:8888/index/data");
        System.out.println(body);
    }
    @GetMapping("/shfGetJson")
    public void shfGetJson(){
        String body = HttpUtil.get("http://localhost:8888/index/data");
        System.out.println(body);

    }
}
