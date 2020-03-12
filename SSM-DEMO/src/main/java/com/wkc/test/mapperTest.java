package com.wkc.test;

import com.wkc.bean.Department;
import com.wkc.bean.Employee;
import com.wkc.dao.DepartmentMapper;
import com.wkc.dao.EmployeeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class mapperTest {
    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private EmployeeMapper employeeMapper;
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;
   @Test
    public  void test() {
       System.out.println(departmentMapper);
       // ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
       //DepartmentMapper dept = ioc.getBean(DepartmentMapper.class);

      // departmentMapper.insertSelective(new Department(null, "开发部"));
     //  departmentMapper.insertSelective(new Department(null, "测试部"));
      // employeeMapper.insertSelective(new Employee(null, "王明", "男", "825708370@qq.com", 1, new Department(null, "开发部")));
       EmployeeMapper mapper = sqlSessionTemplate.getMapper(EmployeeMapper.class);
       for (int i = 0; i < 1000; i++) {
           String uid = UUID.randomUUID().toString().substring(0, 5) ;
           mapper.insertSelective(new Employee(null, uid+"号员工", "男", uid+"@qq.com", 1, null));
   }
   }
}
