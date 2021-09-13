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
	// 페이지 로드
	$j(document).ready(function(){
		
		// 로그인 유효성 검사, 아이디 확인
		$j("#login_btn").on("click", function(){
			
			if($j("#userId").val() == ""){
				alert("아이디를 입력하세요.");
				$j("#userId").focus();
				return false;
			}
			if($j("#userPw").val() == ""){
				alert("비밀번호를 입력하세요.");
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
						alert("존재하지 않는 아이디입니다.");
					}
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});
			
		});
		
		// 로그인
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
			    		alert("로그인 되었습니다.");
			    		location.href = "/board/boardList.do?pageNo=1";
					} else if(data == 0){
						alert("비밀번호가 일치하지 않습니다. 확인하세요.");
					}
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
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
