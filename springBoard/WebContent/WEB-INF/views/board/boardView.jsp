<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardView</title>
</head>

<style>
	#creator{
		border: none;
		outline: none;
		font-size: 16px;
	}
</style>

<script type="text/javascript">
	// ������ �ε�
	$j(document).ready(function(){
		
		// �Խñ� ����
		$j("#update_btn").on("click", function(){
			if( $j("#creator").val() != '${userInfo.userName}' ){
				alert("�ۼ��� ���θ� ������ �����մϴ�.");
				return false;
			}
		});

		// �Խñ� ����
		$j("#delete_btn").on("click",function(){
			
			// �� �ۼ��� ��� = �α��� ������ ���ƾ� ���� ����
			if( $j("#creator").val() != '${userInfo.userName}' ){
				alert("�ۼ��� ���θ� ������ �����մϴ�.");
				return false;
			} else if(confirm('���� �����Ͻðڽ��ϱ�?')){
				
				var param = $j('#f').serialize();
				
				$j.ajax({
				    url : "/board/boardDeleteAction.do",
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
			}
		});
		
	});
</script>

<body>
<form id="f">
	<input type="hidden" name="boardType" value="${board.boardType}" />
	<input type="hidden" name="boardNum" value="${board.boardNum}" />
	
	<table align="center">
		<tr>
			<td>
				<table border="1">
					<tr>
						<td width="130" align="center">Title</td>
						<td width="400">${board.boardTitle}</td>
					</tr>
					<tr>
						<td height="300" align="center">Comment</td>
						<td>${board.boardComment}</td>
					</tr>
					<tr>
						<td align="center">Writer</td>
						<td width="130">
							<input type="text" name="creator" id="creator" value="${board.creator}" readonly>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="/board/${boardType}/${boardNum}/boardUpdate.do" id="update_btn">Update</a>
				<a href="#" id="delete_btn">Delete</a>
				<a href="/board/boardList.do">List</a>
			</td>
		</tr>
	</table>	
</form>
</body>

</html>
