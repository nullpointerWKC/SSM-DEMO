package com.wkc.test;

import com.github.pagehelper.PageInfo;
import com.wkc.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class mvcTest {
    @Autowired
    WebApplicationContext webApplicationContext;
    MockMvc mockMvc;
    @Before
    public  void init(){
        mockMvc  = MockMvcBuilders.webAppContextSetup(webApplicationContext).build();
    }
    @Test
    public  void testPage() throws Exception {
        MvcResult pn = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "6")).andReturn();
        MockHttpServletRequest request = pn.getRequest();
        PageInfo pageinfo =(PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码:" + pageinfo.getPageNum());
        System.out.println("总页码:"+pageinfo.getPages());
        System.out.println("总记录数"+pageinfo.getTotal());
        System.out.println("连续页码");
        int[] navigatepageNums = pageinfo.getNavigatepageNums();
        for (int navigatepageNum : navigatepageNums) {
            System.out.println(navigatepageNum);
        }
        List<Employee> list = pageinfo.getList();
        for (Employee employee : list) {
            System.out.println(employee.getEmpName());
        }

    }

}
