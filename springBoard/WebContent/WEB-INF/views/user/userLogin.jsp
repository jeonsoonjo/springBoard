<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>userLogin</title>
</head>

<style>
	.login{
		font-size: 16px;
		border: 0;
		outline: 0;
		background-color: white;
	}
	.login:hover{
		cursor: pointer;
	}
</style>

<script type="text/javascript">
	// ������ �ε�
	$j(document).ready(function(){
		
		// �α��� ��ȿ�� �˻�, ���̵� Ȯ��
		$j("#login_btn").on("click", function(){
			
			if($j("#userId").val() == ""){
				alert("���̵� �Է��ϼ���.");
				$j("#userId").focus();
				return false;
			}
			if($j("#userPw").val() == ""){
				alert("��й�ȣ�� �Է��ϼ���.");
				$j("#userPw").focus();
				return false;
			}
			
			$j.ajax({
			    url : "/user/idCheck.do",
			    type: "POST",
			    data : {
			    		"userId" : $j("#userId").val()
			    	    },
			    success: function(data, textStatus, jqXHR)
			    {
			    	if(data == 1){
			    		fn_login();
					} else if(data == 0){
						alert("�������� �ʴ� ���̵��Դϴ�.");
					}
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("����");
			    }
			});
			
		});
		
		// �α���
		function fn_login(){
			$j.ajax({
			    url : "/user/userLoginAction.do",
			    type: "POST",
			    data : {
			    		"userId" : $j("#userId").val(),
			    		"userPw" : $j("#userPw").val()
			    	    },
			    success: function(data, textStatus, jqXHR)
			    {
			    	if(data == 1){
			    		alert("�α��� �Ǿ����ϴ�.");
			    		location.href = "/board/boardList.do?pageNo=1";
					} else if(data == 0){
						alert("��й�ȣ�� ��ġ���� �ʽ��ϴ�. Ȯ���ϼ���.");
					}
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("����");
			    }
			});
		}
		
	});
</script>

<body>
	<form id="f">
		<table align="center">
			<tr>
				<td>
					<table border ="1">
						<tr>
							<td width="100" align="center">id</td>
							<td width="200">
								<input type="text" name="userId" id="userId">
							</td>
						</tr>
						<tr>
							<td width="100" align="center">pw</td>
							<td width="200">
								<input type="password" name="userPw" id="userPw">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
					<input type="button" id="login_btn" class="login" value="login">
				</td>
			</tr>
		</table>
	</form>
</body>

</html>
