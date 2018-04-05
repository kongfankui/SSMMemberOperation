<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>

<script type="text/javascript"
	src="${APP_PATH }/static/js/jquery-3.2.1.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

<title>会员列表</title>
</head>
<body>

    <!-- 添加修改模态框 -->
	<!-- Modal -->
	<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title"><strong>会员修改</strong></h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_update_input" class="col-sm-3 control-label">会员姓名：</label>
							<div class="col-sm-9">
								<p class="form-control-static" id="empName_update_static"></p>
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_update_input" class="col-sm-3 control-label">会员邮箱：</label>
							<div class="col-sm-9">
								<input type="email" name="email" class="form-control"
									id="email_update_input" placeholder="email@163.com">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="gender_update_input" class="col-sm-3 control-label">性别：</label>
							<div class="col-sm-9">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender_update_input1" value="M" checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender_update_input2" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="dept_update_input" class="col-sm-3 control-label">部门：</label>
							<div class="col-sm-4">
							<!-- 部门提交ID即可 -->
							<!-- 部门列表得从数据库中查 -->
								<select class="form-control" name="dId" id="dept_update_select"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>
    

	<!-- 添加会员模态框 -->
	<!-- Modal -->
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><strong>会员添加</strong></h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="empName_add_input" class="col-sm-3 control-label">会员姓名：</label>
							<div class="col-sm-9">
								<input type="text" name="empName" class="form-control"
									id="empName_add_input" placeholder="必填">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-3 control-label">会员邮箱：</label>
							<div class="col-sm-9">
								<input type="email" name="email" class="form-control"
									id="email_add_input" placeholder="必填">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-3 control-label">性别：</label>
							<div class="col-sm-9">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender_input1" value="M" checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender_input2" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label for="email_add_input" class="col-sm-3 control-label">部门：</label>
							<div class="col-sm-4">
							<!-- 部门提交ID即可 -->
							<!-- 部门列表得从数据库中查 -->
								<select class="form-control" name="dId" id="dept_add_select"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>


	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1 id="title-view">会员信息展示<small>Member information display</small></h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button type="button" class="btn btn-danger" id="emp_delete_modal_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emp_table">
					<thead>
						<tr>
						    <th>
						       <input type="checkbox" id ="check_all"/>
						    </th>
							<th>ID</th>
							<th>姓名</th>
							<th>性别</th>
							<th>邮箱</th>
							<th>所属部门</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>

					</tbody>

				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>

	<script type="text/javascript">
	
	    //全局变量记录总记录数
	    var totalRecord;
	    //全局变量记录当前页码
	    //var currentPageNum;
	
		$(function() {
			to_page(1);
		});

		function to_page(pn) {
			//清空属性值
			$("#check_all").prop("checked",false);
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//console.log(result);
					//1.解析并显示员工数据
					build_emps_table(result);
					//2.解析并显示分页信息
					build_page_info(result);
					//3.解析并显示分页条
					build_page_nav(result);
				}
			});
		}

		//解析并显示员工数据
		function build_emps_table(result) {
			//清空表格
			$("#emp_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var gender = item.gender == "M" ? "男" : "女";
				var genderTd = $("<td></td>").append(gender);
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>")
						.append(item.department.deptName);
				var editBtn = $("<button></button>").addClass(
						"btn btn-success btn-sm edit_btn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-pencil")).append("编辑");
				//给编辑按钮添加一个自定义属性，来记录当前会员的id
				editBtn.attr("edit-id",item.empId);
				var delBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm delete_btn").append(
						$("<span></span>")
								.addClass("glyphicon glyphicon-trash")).append(
						"删除");
				//给删除按钮添加一个自定义属性，来记录当前会员的id
				delBtn.attr("delBtn-id",item.empId);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(
						delBtn);

				$("<tr></tr>").append(checkBoxTd).append(empIdTd).append(empNameTd).append(
						genderTd).append(emailTd).append(deptNameTd).append(
						btnTd).appendTo("#emp_table tbody");
			});
		}

		//解析并显示分页信息
		function build_page_info(result) {
			//先清空
			$("#page_info_area").empty()
			$("#page_info_area").append(
					"当前第" + result.extend.pageInfo.pageNum + "页,总共"
							+ result.extend.pageInfo.pages + "页,总共"
							+ result.extend.pageInfo.total + "条记录");
			
			//给标题添加一个自定义属性，来记录当前页码，用于更新后跳转，或者添加全局变量
			//currentPageNum = result.extend.pageInfo.pageNum;
			$("#title-view").attr("page-id",result.extend.pageInfo.pageNum);
			
			totalRecord = result.extend.pageInfo.total;
		}
		//解析并显示分页条
		function build_page_nav(result) {
			//先清空
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;"));

			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));

			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}

			ul.append(firstPageLi).append(prePageLi);

			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append(
						$("<a></a>").append(item).attr("href", "#"));

				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				})

				ul.append(numLi);
			});

			ul.append(nextPageLi).append(lastPageLi);

			var navEle = $("<nav></nav>").append(ul).appendTo("#page_nav_area");
		}

		
		//查出部门信息展示在下拉列表中
		function get_depts(ele) {
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//$("#dept_add_select")
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}
		
		//点击新增按钮弹出模态框
		$("#emp_add_modal_btn").click(function() {
			//清除模态框中的数据
			$("#empAddModal form")[0].reset();
			$("#empAddModal form").find("*").removeClass("has-error has-success");
			$("#empName_add_input").next("span").text("");
			$("#email_add_input").next("span").text("");
			//发送ajax请求查出部门信息展示在下拉列表中
			get_depts("#dept_add_select");
			
			email_validate("#email_add_input");
			
			$("#empAddModal").modal();
		});
		
		//姓名框失去焦点时验证
		$("#empName_add_input").focusout(function () {
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(empName == "" || empName == null){
				show_validate_msg("#empName_add_input","error","会员名输入为空，请输入会员名！");
				return false;
			}else if(!regName.test(empName)){
				show_validate_msg("#empName_add_input","error","会员名输入格式错误，请重新输入！");
				return false;
			}else{
				$.ajax({
					url:"${APP_PATH}/checkuser",
					data:"empName="+empName,
					type:"GET",
					success:function(result){
						if(result.code == 1){
							show_validate_msg("#empName_add_input","success","用户名可用");
						}else {
							show_validate_msg("#empName_add_input","error","用户名已存在");
						}
					}
				});
				
				
			}
			
			return true;
		});
		
		//封装成函数
		//邮箱框失去焦点时验证
		function email_validate(ele) {
			$(ele).focusout(function () {
				var email = $(ele).val();
				var regEmail = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
				if(email == "" || email == null){
					show_validate_msg(ele,"error","邮箱为空，请输入邮箱！");
					return false;
				}else if(!regEmail.test(email)){
					show_validate_msg(ele,"error","邮箱输入格式错误，请重新输入！");
					return false;
				}else{
					show_validate_msg(ele,"success","");
				}
				return true;
			});
		}
		
		
		function show_validate_msg(ele,status,msg) {
			//清除校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		
		
		$("#emp_save_btn").click(function () {
			var empName = $("#empName_add_input").val();
			var empNameSpan = $("#empName_add_input").next("span").text();
			var email = $("#email_add_input").val();
			var emailSpan = $("#email_add_input").next("span").text();
			if(empName == "" || empName == null){
				show_validate_msg("#empName_add_input","error","会员名输入为空，请输入会员名！");
				return false;
			}
			if(email == "" || email == null){
				show_validate_msg("#email_add_input","error","邮箱为空，请输入邮箱！");
				return false;
			}
			if(empNameSpan != "用户名可用" || emailSpan != ""){
				return false;
			}
	
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				//serialize()序列表表格内容为字符串，用于 Ajax 请求。
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					if(result.code == 1){
						//会员保存成功后需要做：1、关闭模态框，2、跳转到最后一页展示新添加的数据
						$("#empAddModal").modal('hide');
						to_page(totalRecord);
					}else{
						//显示失败信息
						if(undefined == result.extend.errorFields.email){
							//显示会员名字错误信息
							show_validate_ms("#empName_add_input","error",result.extend.errorFields.empName);
						}else{
							//显示邮箱错误信息
							show_validate_ms("#email_add_input","error",result.extend.errorFields.email);
						}
					}
				}
			});
		});
		
		//如果和一般情况一样给更新绑定click时间是没效的（这是在按钮创建之前绑定）
		//解决方法：1.在创建按钮的时候绑定，但是耦合度太高，2.绑定live（）
		//jQuery新版本没有了live，使用on代替
		$(document).on("click",".edit_btn",function(){
			//查出员工信息和部门信息
			get_depts("#dept_update_select");
			
			getEmp($(this).attr("edit-id"));
			
			$("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
			
			$("#empUpdateModal").modal();
			
			//验证邮箱是否合法
			email_validate("#email_update_input");
		});
		
		function getEmp(id) {
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name = gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}
			});
		}
		
		//点击更新，更新会员信息
		$("#emp_update_btn").click(function () {
			
			//发送ajax请求保存更新的会员信息
			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
				//这种方式也是可以的
				//type:"POST",
				//data:$("#empUpdateModal form").serialize()+"&_method=PUT",
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					//关闭模态框
					//跳转到更新的页面
					$("#empUpdateModal").modal('hide');
					to_page($("#title-view").attr("page-id"));
					//to_page(currentPageNum);
				}
			});
			
		});
		
		//单个删除会员
        $(document).on("click",".delete_btn",function(){
			//alert($(this).parents("tr").find("td:eq(1)").text());
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("delBtn-id");
			if(confirm("确认删除会员 【"+empName+"】 吗？")){
				//确认删除，发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						to_page($("#title-view").attr("page-id"));
					}
				});
			}
		});
		
		//完成全选，全不选功能
		$("#check_all").click(function () {
			//DOM原生属性，attr用于获取自定义属性的值，prop用于修改和读取DOM原生属性的值
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		$(document).on("click",".check_item",function(){
			//判断当前选中的元素是否是本页的全部
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		
		//批量删除
		$("#emp_delete_modal_btn").click(function () {
			var empNames="";
			var del_idstr="";
			$.each($(".check_item:checked"),function(){
				//组装姓名
				empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
				//组装id
				del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
			});
		    //取出最后一个“，”
		    empNames = empNames.substring(0,empNames.length-1);
		    del_idstr = del_idstr.substring(0,del_idstr.length-1);
		    if(confirm("确认删除【"+empNames+"】吗？")){
		    	$.ajax({
		    		url:"${APP_PATH}/emp/"+del_idstr,
		    		type:"DELETE",
		    		success:function(result){
		    			alert(result.msg);
		    			to_page($("#title-view").attr("page-id"));
		    		}
		    	});
		    }
		});
		
	</script>

</body>
</html>