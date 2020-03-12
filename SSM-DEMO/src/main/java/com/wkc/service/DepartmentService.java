package com.wkc.service;

import com.wkc.bean.Department;
import com.wkc.bean.msg;
import com.wkc.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;
    public List<Department> getDets() {
      return   departmentMapper.selectByExample(null);
    }
}
