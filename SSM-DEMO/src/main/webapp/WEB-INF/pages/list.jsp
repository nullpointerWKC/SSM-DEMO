<%--
  Created by IntelliJ IDEA.
  User: W
  Date: 2020/3/4
  Time: 18:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <title>员工列表</title>
        <link href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
        <script src="/static/js/jquery-1.12.4.min.js"></script>
    </head>
<body>
<div class="container">
    <div class="row">
    <div class="col-md-12">
        <h1>SSM查询</h1>
    </div>
    </div>
    <div class="row">
     <div class="col-md-4 col-md-offset-8">
         <button class="btn btn-primary">新增</button>
         <button class="btn btn-danger">删除</button>
     </div>
    </div>
    <div class="row">
    <div class="col-md-12">
           <table class="table table-hover">
           <tr>
               <th>#</th>
               <th>empName</th>
               <th>gender</th>
               <th>email</th>
               <th>departName</th>
               <th>操作</th>
           </tr>

               <c:forEach items="${pageInfo.list}" var="emp">
                   <tr>
                   <th>${emp.empId}</th>
                   <th>${emp.empName}</th>
                   <th>${emp.gender=="M"?"男":"女"}</th>
                   <th>${emp.email}</th>
                   <th>${emp.department.deptName}</th>
                   <th>
                       <button class="btn btn-primary btn-sm" >
                           <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                           编辑
                       </button>
                       <button class="btn btn-danger btn-sm">
                           <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                           删除
                       </button>
                   </th>
               </tr>
               </c:forEach>

           </table>
    </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            当前记录：${pageInfo.pageNum}页，总共${pageInfo.pages}页,总共${pageInfo.total}条
        </div>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">

                    <c:if test="${pageInfo.pageNum==1}">
                        <li class="disabled"><a href="#">首页</a></li>
                        <li class="disabled">
                            <a href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:if test="${pageInfo.pageNum!=1}">
                        <li><a href="/emps?pn=1">首页</a></li>
                        <li>
                            <a href="/emps?pn=${pageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach items="${pageInfo.navigatepageNums}" var="pageNum">
                        <c:if test="${pageNum==pageInfo.pageNum}">
                            <li class="active"><a href="/emps?pn=${pageNum}">${pageNum}</a></li>
                        </c:if>

                        <c:if test="${pageNum!=pageInfo.pageNum}">
                            <li><a href="/emps?pn=${pageNum}">${pageNum}</a></li>
                        </c:if>

                    </c:forEach>

                    <c:if test="${pageInfo.pageNum==pageInfo.pages}">
                        <li class="disabled">
                            <a href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                        <li class="disabled"><a href="#">末页</a></li>
                    </c:if>

                    <c:if test="${pageInfo.pageNum!=pageInfo.pages}">
                        <li>
                            <a href="/emps?pn=${pageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                        <li><a href="/emps?pn=${pageInfo.pages}">末页</a></li>
                    </c:if>

                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
