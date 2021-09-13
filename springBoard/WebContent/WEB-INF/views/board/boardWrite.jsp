<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
</head>

<script type="text/javascript">
	// ������ �ε�
	$j(document).ready(function(){
		
		// �Խñ� �ۼ�
		$j("#submit").on("click",function(){
			
			if($j("#boardTitle").val() == ""){
				alert("������ �Է��ϼ���.");
				return false;
			}
			if($j("#boardComment").val() == ""){
				alert("������ �Է��ϼ���.");
				return false;
			}
			
			var $frm = $j('.boardWrite :input');
			var param = $frm.serialize();
			
			$j.ajax({
			    url : "/board/boardWriteAction.do",
			    dataType: "json",
			    type: "POST",
			    data : param,
			    success: function(data, textStatus, jqXHR)
			    {
					alert("�ۼ��Ϸ�");
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
	<form class="boardWrite">
		<table align="center">
			<tr>
				<td align="right">
					<input id="submit" type="button" value="�ۼ�">
					<input id="row" type="button" value="���߰�">
				</td>
			</tr>
			<tr>
				<td>
					<table border="1"> 
						<tr>
							<td width="120" align="center">Type</td>
							<td>
								<select name="boardType">
									<c:forEach items="${comCodeList}" var="list">
										<option value="${list.codeId}">${list.codeName}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<td width="120" align="center">Title</td>
							<td width="400">
								<input type="text" name="boardTitle" id="boardTitle" size="50" value="${board.boardTitle}"> 
							</td>
						</tr>
						<tr>
							<td height="300" align="center">Comment</td>
							<td valign="top">
								<textarea name="boardComment"  id="boardComment" rows="20" cols="55">${board.boardComment}</textarea>
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
					<a href="/board/boardList.do">List</a>
				</td>
			</tr>
		</table>
	</form>	
</body>

</html>
