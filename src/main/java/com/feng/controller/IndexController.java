package com.feng.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

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

}
