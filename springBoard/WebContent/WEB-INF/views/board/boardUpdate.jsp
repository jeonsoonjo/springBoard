<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardUpdate</title>
</head>

<script type="text/javascript">
	// ������ �ε�
	$j(document).ready(function(){
		
		// �Խñ� ����
		$j("#submit").on("click",function(){
			var $frm = $j('.boardUpdate :input');
			var param = $frm.serialize();
			
			$j.ajax({
			    url : "/board/boardUpdateAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("�����Ϸ�");
					location.href = "/board/boardList.do?pageNo=1";
			    },
			    error: function (jqXHR, textStatus, errorThrown)
			    {
			    	alert("����");
			    }
			});
		});
		
	});
</script>

<body>
	<form class="boardUpdate">
		<input type="hidden" name="boardNum" value="${boardNum}">
		<input type="hidden" name="boardType" value="${boardType}">
								
		<table align="center">
			<tr>
				<td align="right">
					<input id="submit" type="button" value="����">
				</td>
			</tr>
			<tr>
				<td>
					<table border ="1"> 
						<tr>
							<td width="120" align="center">Title</td>
							<td width="400">
								<input name="boardTitle" type="text" size="50" value="${board.boardTitle}"> 
							</td>
						</tr>
						<tr>
							<td height="300" align="center">Comment</td>
							<td valign="top">
								<textarea name="boardComment" rows="20" cols="55">${board.boardComment}</textarea>
							</td>
						</tr>
						<tr>
							<td align="center">Writer</td>
							<td>
								<input type="text" name="creator" value="${userInfo.userName}" readonly>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
					<a href="/board/boardList.do">��Ϻ���</a>
				</td>
			</tr>
		</table>
	</form>	
</body>

</html>
