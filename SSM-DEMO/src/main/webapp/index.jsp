<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>员工列表</title>
    <script src="/static/js/jquery-1.12.4.min.js"></script>
    <link href="/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empNameInput" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text"  name="empName" class="form-control" id="empNameInput" placeholder="empName">
                            <span class="help-block"  ></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text"  name="email" class="form-control" id="email" placeholder="825708370@qq.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                    <label class="col-sm-2 control-label">gender</label>
                    <div class="col-sm-10">
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gender1" value="M" checked="checked"> 男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" id="gender2" value="F"> 女
                        </label>
                    </div>
                </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="deptSelect">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button"  class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="empSaveBtn">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empNameInput" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="updateEmpName"></p>
                            <span class="help-block"  ></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text"  name="email" class="form-control" id="updateEmail" placeholder="825708370@qq.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="updateGender1" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="updateGender2" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="updateDeptSelect">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button"  class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateEmpBtn">修改</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-md-12">
            <h1>SSM查询</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="empAddBtn">新增</button>
            <button class="btn btn-danger" id="empDel">删除</button>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_tab">
                <thead>
                <tr>
                    <th>
                    <input type="checkbox" id="checkAll">
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>departName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6" id="pageInfo">
        </div>
        <div class="col-md-6" id="pageNav">
        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRes;
    var nowRes;

    $(function () {
      toPage(1)
    })

    function build_table(msg) {
           totalRes=msg.extend.pageInfo.total;
        nowRes = msg.extend.pageInfo.pageNum;
        $("#emps_tab tbody").empty()
        var emps = msg.extend.pageInfo.list;
        $.each(emps,function (index,item) {
            var checkbox=$("<td><input type='checkbox' class='Check'></input></td>")
            var empIdTd= $("<td></td>").append(item.empId)
            var empNameTd= $("<td></td>").append(item.empName)
            var gender=item.gender;
            if(gender=='M')
                gender='男'
            else
                gender='女'
            var empGenderTd= $("<td></td>").append(gender)
            var empEmailTd= $("<td></td>").append(item.email)
            var empDeptTd= $("<td></td>").append(item.department.deptName)
            var editBtn=$("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .attr("editId",item.empId)
            .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑")
            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm del_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除")
            delBtn.attr("delId",item.empId)
            var btnTd=$("<td></td>").append(editBtn)
                .append(" ")
                .append(delBtn)
            $("<tr></tr>")
                .append(checkbox)
                .append(empIdTd)
                .append(empNameTd)
                .append(empGenderTd)
                .append(empEmailTd)
                .append(empDeptTd)
                .append(btnTd)
                .appendTo("#emps_tab tbody");
        })
    }

    function build_pageInfo(msg) {
        $("#pageInfo").empty();
        $("#pageInfo").append(" 当前记录： 第"+msg.extend.pageInfo.pageNum+"页，总共"+msg.extend.pageInfo.pages+"页,总共"+msg.extend.pageInfo.total+"条")
    }

    function build_pageNav(msg) {
        var preNum=msg.extend.pageInfo.pageNum-1;
        var nextNum=msg.extend.pageInfo.pageNum+1;
        $("#pageNav").empty();
        var ul=$("<ul></ul>").addClass("pagination")
        if(msg.extend.pageInfo.pageNum==1) {
            var firstli=$("<li></li>").addClass("disabled").append($("<a></a>").attr("href","#").append("首页"))
            var pre=$("<li></li>").addClass("disabled").append($("<a></a>").append("&laquo;"))
        }
        else {
            var firstli=$("<li></li>").append($("<a></a>").append("首页").attr("href","javascript:toPage(1)"))
            var pre=$("<li></li>").append($("<a></a>").attr("href","javascript:toPage("+preNum+")").append("&laquo;"))
        }
       if(msg.extend.pageInfo.pageNum==msg.extend.pageInfo.pages) {
           var next=$("<li></li>").addClass("disabled").append($("<a></a>").append("&raquo;"))
           var lastli=$("<li></li>").addClass("disabled").append($("<a></a>").append("末页").attr("href","#"))
       }
       else {
               var next=$("<li></li>").append($("<a></a>").attr("href","javascript:toPage("+nextNum+")").append("&raquo;"))
           var lastli=$("<li></li>").append($("<a></a>").append("末页").attr("href","javascript:toPage("+msg.extend.pageInfo.pages+")"))
       }

         ul.append(firstli).append(pre)
        $.each(msg.extend.pageInfo.navigatepageNums,function (index,item) {
            if(item==msg.extend.pageInfo.pageNum)
             ul.append($("<li></li>").addClass("active").append($("<a></a>").attr("href","javascript:toPage("+item+")").append(item)))
            else
                ul.append($("<li></li>").append($("<a></a>").attr("href","javascript:toPage("+item+")").append(item)))
        })
        ul.append(next).append(lastli)
        var nav=$("<nav></nav>").append(ul)
        nav.appendTo($("#pageNav"))
    }

    function toPage(pn) {
        var data="pn="+pn
        $.ajax({
            url:"/jsonEmps",
            data:data,
            type:"GET",
            success:function (msg) {
                //  console.log(msg);
                build_table(msg)
                build_pageInfo(msg)
                build_pageNav(msg)
            }
        })
    }

 function resetForm(ele) {
     $(ele).find("*").removeClass("has-error has-success")
     $(ele).find(".help-block").text("")

 }

    $("#empAddBtn").click(function () {
        resetForm("#empAddModal form")
         $("#empNameInput").val("")
         $("#email").val("")
        getDepts();
           $("#empAddModal").modal({
               backdrop:"static"
           })
    })

   function getDepts() {
       $("#deptSelect").empty();
       $.ajax({
           url:"/depts",
           type:"GET",
           success:function (res) {
            $.each(res.extend.depts,function (index,item) {
                var option =$("<option></option>").append(item.deptName).attr("value",item.deptId)
                $("#deptSelect").append(option)
            })

           }
       })

   }

   $("#empNameInput").change(function () {
       $.ajax({
           url:"/checkName",
           type:"GET",
           data: "empName=" + this.value,
           success:function (res) {
                  if(res.code==100){
                      showMsg("#empNameInput","success","用户名可用")
                      $("#empSaveBtn").attr("ajax-va","success")
                  }
                  else{
                      showMsg("#empNameInput","error",res.extend.va)
                      $("#empSaveBtn").attr("ajax-va","error")}
               }
           })
       })

function validateForm(){
  var empName=$("#empNameInput").val()
    var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
    if(!regName.test(empName)) {
        //alert("用户名2-5中文或6-16英文和数字的组合")
        showMsg("#empNameInput","error","用户名2-5中文或6-16英文和数字的组合")
        return false
    }
    else {
        showMsg("#empNameInput","success","")
    }
    var email=$("#email").val()
    var regEmail=/([A-Za-z0-9\-]+\.)+[A-Za-z]{2,6}/
    if(!regEmail.test(email)) {
        showMsg("#email","error","邮箱不符合规范，请重新输入")
        return false
    }
    else {
        showMsg("#email","success","")
    }
    return  true
}

    $("#empSaveBtn").click(function () {
         //alert($("#empAddModal form").serialize())
       if($(this).attr("ajax-va")=="error")
          return;
        if(validateForm()){$.ajax({
            url: "/emp",
            type: "POST",
            data: $("#empAddModal form").serialize(),
            success: function (res) {
                if(res.code==100){
                    alert(res.msg);
                    $("#empAddModal").modal("hide")
                    toPage(totalRes)
                }
                else {
                    console.log(res)
                 if(undefined!=res.extend.error.email){
                      showMsg("#email","fail",res.extend.error.email)
                 }
                    if(undefined!=res.extend.error.empName){
                        showMsg("#empNameInput","fail",res.extend.error.empName)
                    }
                }

            }
        }) }
        else
            return
        })

 function showMsg(ele,status,msg) {
     $(ele).parent().removeClass("has-success has-error")
     $(ele).next("span").text("")
 if(status=="success"){
     $(ele).parent().addClass("has-success")
     $(ele).next("span").text(msg)
 }
 else{
     $(ele).parent().addClass("has-error")
     $(ele).next("span").text(msg)
 }
 }
    $(document).on("click",".edit_btn",function () {
        $("#updateEmail").parent().removeClass("has-success has-error")
        $("#updateEmail").next("span").text("")
        //alert("?")
        $("#updateEmpBtn").attr("editId",$(this).attr("editId"))
        $("#empUpdateModal").modal({
            backdrop:"static"
        })
        $("#updateDeptSelect").empty();
        $.ajax({
            url:"/depts",
            type:"GET",
            success:function (res) {
                $.each(res.extend.depts,function (index,item) {
                    var option =$("<option></option>").append(item.deptName).attr("value",item.deptId)
                    $("#updateDeptSelect").append(option)
                })
            }
        })
        getEmp($(this).attr("editId"));

    })
    $(document).on("click",".del_btn",function () {
        var name=   $(this).parents("tr").find("td:eq(2)").text();
        var id=  $(this).parents("tr").find("td:eq(1)").text();
        if(confirm("确认删除"+name+"?")){
            $.ajax({
                url:"/emp/"+id,
                type:"DELETE",
                success:function (res) {
                  alert(res.msg)
                    toPage(nowRes)
                }
            })
        }
    })

    function getEmp(ele) {

        $.ajax({
            url:"/emp/"+ele,
            type:"GET",
            success:function (res) {
              //console.log(res)
                var emp = res.extend.emp;
                $("#updateEmpName").text(emp.empName )
                $("#updateEmail").val(emp.email)
                $("#empUpdateModal input[name=gender]").val([emp.gender])
                    $("#empUpdateModal select").val([emp.dId])

            }
        })
    }
$("#updateEmpBtn").click(function () {
    var email=$("#updateEmail").val()
    var regEmail=/([A-Za-z0-9\-]+\.)+[A-Za-z]{2,6}/
    if(!regEmail.test(email)) {
        showMsg("#updateEmail","error","邮箱不符合规范，请重新输入")
        return false
    }
    else {
        showMsg("#updateEmail","success","")
    }
    $.ajax({
        url:"/emp/"+$(this).attr("editId"),
        type:"PUT",
        data: $("#empUpdateModal form").serialize() ,//+"&_method=PUT",
        success:function (res) {
            //console.log(res)
            alert(res.msg)
            $("#empUpdateModal").modal("hide")
            toPage(nowRes)

        }
    })


})
    $("#checkAll").click(function () {
          //alert($(this).prop("checked"))
        $(".Check").prop("checked",$(this).prop("checked"))
    })

    $(document).on("click",".Check",function (){
        if($(".Check:checked").length==5){
            $("#checkAll").prop("checked",true)
        }
        else{
            $("#checkAll").prop("checked",false)
        }
        }
    ) 

    $("#empDel").click(function () {
        empname = "";
        $.each($(".Check:checked"),function () {
          empname+=$(this).parents("tr").find("td:eq(2)").text()+","
        })
        empname=empname.substring(0,empname.length-1)
        if(confirm("确认删除["+empname+"]?")){
           var subStr = "";
           $.each($(".Check:checked"),function(){
               subStr += '-'+ $(this).parents("tr").find("td:eq(1)").text();
           })
            subStr=subStr.substring(1,subStr.length)
            alert(subStr)
            $.ajax({
                url:"/emp/"+subStr,
                type:"DELETE",
                success:function (res) {
                    alert(res.msg)
                    toPage(nowRes)
                }
            })
        }
    })

</script>
</body>
</html>
