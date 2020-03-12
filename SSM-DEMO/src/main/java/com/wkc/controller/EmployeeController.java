package com.wkc.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.wkc.bean.Employee;
import com.wkc.bean.msg;
import com.wkc.dao.EmployeeMapper;
import com.wkc.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {
    @Autowired
    EmployeeService employeeService;

    @RequestMapping("/jsonEmps")
    @ResponseBody
    public msg getEmpsWithJson(@RequestParam (value = "pn",defaultValue = "1")Integer pn) {
    PageHelper.startPage(pn, 5);
    List<Employee> employeeList= employeeService.getAll();
    PageInfo page = new PageInfo(employeeList,5);
        return msg.success().add("pageInfo", page);
    }

  @RequestMapping("/checkName")
  @ResponseBody
    public  msg checkName(@RequestParam("empName") String empName){
      String reg = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
      boolean matches = empName.matches(reg);
       if(!matches)
           return msg.fail().add("va", "用户名不符合规范:用户名2-5中文或6-16英文和数字的组合");
      if(employeeService.checkName(empName)) {
           return msg.success();
       }
      return msg.fail().add("va", "用户名已存在");
    }

@RequestMapping(value = "/emp",method= RequestMethod.POST)
@ResponseBody
    public msg saveEmp(@Valid  Employee employee, BindingResult result){
    Map<String, Object> map = new HashMap<>();
        if(result.hasErrors()){
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                System.out.println(fieldError.getField());
                System.out.println(fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
        }
        else{ employeeService.saveEmp(employee);
            return  msg.success();
        }
    return msg.fail().add("error",map);
    }

    @RequestMapping("/emps")
    public  String getEmps(@RequestParam (value = "pn",defaultValue = "1")Integer pn, Model model){
        PageHelper.startPage(pn, 5);
       List<Employee> employeeList= employeeService.getAll();
        PageInfo page = new PageInfo(employeeList,5);
        model.addAttribute("pageInfo", page);
        return "list";
    }

    @RequestMapping(value = "/emp/{empId}",method= RequestMethod.GET)
    @ResponseBody
    public  msg getEmp( @PathVariable("empId")Integer empId){
        Employee employee=employeeService.getEmp(empId);
       return msg.success().add("emp", employee);
    }

 @RequestMapping(value = "/emp/{empId}",method= RequestMethod.PUT)
 @ResponseBody
    public msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
     return msg.success();
    }

    @RequestMapping(value = "/emp/{empIds}",method= RequestMethod.DELETE)
    @ResponseBody
    public  msg delete(@PathVariable("empIds")String empIds){
        if(empIds.contains("-")) {
            List<Integer> ids = new ArrayList<>();
            String[] split = empIds.split("-");
            for (String s : split) {
                ids.add(Integer.parseInt(s));
            }
            employeeService.deletes(ids);
        }
        else {
            int id= Integer.parseInt(empIds);
            employeeService.delete(id);
        }
        return msg.success();
    }
}
