package com.wkc.controller;

import com.wkc.bean.Department;
import com.wkc.bean.msg;
import com.wkc.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Vector;

@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;

    @RequestMapping("/depts")
    @ResponseBody
    public msg getDepts(){
        List<Department> departments = departmentService.getDets();
        return msg.success().add("depts", departments);
    }
}
