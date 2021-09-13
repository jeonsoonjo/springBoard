<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>userJoin</title>
</head>

<style>
	.phone{
		width: 10%;   
	}
	.join{
		font-size: 16px;
		border: 0;
		outline: 0;
		background-color: white;
	}
	.join:hover{
		cursor: pointer;
	}
	span{
		font-size: 10px;
	}
</style>

<script type="text/javascript">
	// 페이지 로드
	$j(document).ready(function(){
		
		// 아이디 중복체크
		var idPass = false;
		$j("#idCheck_btn").on("click", function(){
			
			// 아이디 입력 안 했을 경우
			if($j("#userId").val() == ""){
				alert("아이디를 입력하세요.");
				return false;
			}
			
			// 아이디 정규식
			var regId = /^[a-zA-Z][a-zA-Z0-9]{4,19}$/;
			if(!regId.test($j("#userId").val())){
				alert('아이디는 영어/숫자 5~20자리만 입력 가능합니다.');
				return false;
			}
			
			$j.ajax({
			    url : "/user/idCheck.do",
			    type: "POST",
			    data : {
			    		"userId" : $j("#userId").val()
			    	    }, // 보내는 data
			    success: function(data, textStatus, jqXHR)
			    {
			    	if(data == 1){
						alert("이미 사용중인 아이디입니다.");
						idPass = false;
					} else if(data == 0){
						alert("사용가능한 아이디입니다.");
						idPass = true;
					}
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});

		});

		// 비밀번호 검증
		var pwPass = false;
		$j("#userPw").on("keyup", function(){
			
			// 비밀번호 정규식
			var regPw = /^[0-9]{6,12}$/;
			if(regPw.test($j("#userPw").val())){
				$j(".pw_result").text("사용 가능한 비밀번호입니다.");
				$j(".pw_result").css("color", "green");
				pwPass = true;
			} else{
				$j(".pw_result").text("비밀번호는 숫자 6~12자리만 입력 가능합니다.");
				$j(".pw_result").css("color", "red");
				pwPass = false;
			}
			
		});
		
		// 비밀번호 재확인
		var pwPass2 = false;
		$j("#userPw2").on("keyup", function(){
			if($j("#userPw").val() == $j("#userPw2").val()){
				$j(".pw_result2").text("비밀번호가 일치합니다.");
				$j(".pw_result2").css("color", "green");
				pwPass2 = true;
			} else{
				$j(".pw_result2").text("입력하신 비밀번호가 일치하지 않습니다.");
				$j(".pw_result2").css("color", "red");
				pwPass2 = false;
			}
		});
		
		// 핸드폰 번호 정규식
		$j("#userPhone2").on("keyup", function(){
			var regPhone2 = /^[0-9]{1,4}$/;
			if(!regPhone2.test($j("#userPhone2").val())){
				$j(".phone_result").text("숫자만 입력하세요.");
				$j(".phone_result").css("color", "red");
				return false;
			} else{
				$j(".phone_result").text(" ");
			}
		});
		$j("#userPhone3").on("keyup", function(){
			var regPhone3 = /^[0-9]{1,4}$/;
			if(!regPhone3.test($j("#userPhone3").val())){
				$j(".phone_result").text("숫자만 입력하세요.");
				$j(".phone_result").css("color", "red");
				return false;
			} else{
				$j(".phone_result").text(" ");
			}
		});
		
		// 우편번호(postNo = userAddr1) 정규식
		$j("#userAddr1").on("keyup", function(){
			
			var postNo = $j("#userAddr1").val().replace(/(\d{3})(\d{3})/, '$1-$2');
			
			$j("#userAddr1").val(postNo);
			
		/* 	var regPost = /^[0-9]{1,3}-[0-9]{1,3}$/;
			if(!regPost.test($j("#userAddr1").val())){
				$j(".postNo_result").text("숫자만 입력하세요. xxx-xxx 형식으로 작성하세요.");
				$j(".postNo_result").css("color", "red");
			} else{
				$j(".postNo_result").text(" ");
			} */
		});
		
		// 회원가입
 		$j("#join_btn").on("click", function(){
 			
 			// 회원가입 유효성 검사
			if(!idPass || $j("#userId").val() == ""){
				alert("아이디를 확인하세요(중복확인 필수)");
				$j("#userId").focus();
				return false;
			} 
			if(!pwPass || $j("#userPw").val() == ""){
				alert("비밀번호를 확인하세요.");
				$j("#userPw").focus();
				return false;
			} 
			if(!pwPass2 || $j("#userPw2").val() == ""){
				alert("비밀번호 확인을 검증하세요.");
				$j("#userPw2").focus();
				return false;
			} 
			if($j("#userName").val() == ""){
				alert("이름을 입력하세요.");
				$j("#userName").focus();
				return false;
			} 
			if($j("#userPhone2").val() == "" || $j("#userPhone3").val() == ""){
				alert("전화번호를 입력하세요.");
				$j("#userPhone2").focus();
				return false;
			} 
			
			$j.ajax({
			    url : "/user/userJoinAction.do",
			    dataType: "json",
			    type: "POST",
			    data : $j("#f").serialize(),
			    success: function(data, textStatus, jqXHR)
			    {
					alert("회원가입 완료");
					location.href = "/board/boardList.do?pageNo=1";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("실패");
			    }
			});

		});
		
	});
</script>

<body>
	<form id="f" method="post">
		<table align="center">
			<tr>
				<td>
					<a href="/board/boardList.do">List</a>
				</td>
			</tr>
			<tr>
				<td>
					<table border ="1">
						<tr>
							<td width="100" align="center">id</td>
							<td width="400">
								<input type="text" name="userId" id="userId">
								<input type="button" id="idCheck_btn" value="중복확인">
							</td>
						</tr>
						<tr>
							<td width="100" align="center">pw</td>
							<td>
								<input type="password" name="userPw" id="userPw">
								<span class="pw_result"></span>
							</td>
							
						</tr>
						<tr>
							<td width="100" align="center">pw check</td>
							<td>
								<input type="password" id="userPw2">
								<span class="pw_result2"></span>
							</td>
						</tr>
						<tr>
							<td width="100" align="center">name</td>
							<td><input type="text" name="userName" id="userName"></td>
						</tr>
						<tr>
							<td width="100" align="center">phone</td>
							<td>
								<!-- userPhone1 데이터 select 출력 -->
								<select name="userPhone1">
	                               <c:forEach items="${phoneList}" var="p">
	                               		<option value="${p.codeName}">${p.codeName}</option>
	                               </c:forEach>
                           		</select>
                           		 - 
	                            <input type="text" name="userPhone2" id="userPhone2" class="phone" maxlength="4">
	                             - 
	                            <input type="text" name="userPhone3" id="userPhone3" class="phone" maxlength="4">
	                            <span class="phone_result"></span>
							</td>
						</tr>
						<tr>
							<td width="100" align="center">postNo</td>
							<td>
								<input type="text" name="userAddr1" id="userAddr1" maxlength="7">
								<span class="postNo_result"></span>
							</td>
						</tr>
						<tr>
							<td width="100" align="center">address</td>
							<td><input type="text" name="userAddr2"></td>
						</tr>
						<tr>
							<td width="100" align="center">company</td>
							<td><input type="text" name="userCompany"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
					<input type="button" id="join_btn" class="join" value="join">
				</td>
			</tr>
		</table>
	</form>
</body>

</html>
