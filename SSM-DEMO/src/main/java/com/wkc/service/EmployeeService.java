package com.wkc.service;

import com.wkc.bean.Employee;
import com.wkc.bean.EmployeeExample;
import com.wkc.dao.DepartmentMapper;
import com.wkc.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    private EmployeeMapper emp;

    public List<Employee> getAll() {
        List<Employee> employees = emp.selectByExampleWithDept(null);
        return employees;
    }

    public void saveEmp(Employee employee) {
        emp.insertSelective(employee);
    }

    public boolean checkName(String empName) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = emp.countByExample(example);
        return count == 0;
    }

    public Employee getEmp(Integer empId) {
        return  emp.selectByPrimaryKey(empId);
    }

    public void updateEmp(Employee employee) {
       emp.updateByPrimaryKeySelective(employee);
    }

    public void delete(Integer empId) {
        emp.deleteByPrimaryKey(empId);
    }

    public void deletes(List<Integer> empIds) {
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(empIds);
        emp.deleteByExample(example);
    }
}
