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
	// 페이지 로드
	$j(document).ready(function(){
		
		// 게시글 작성
		$j("#submit").on("click",function(){
			
			if($j("#boardTitle").val() == ""){
				alert("제목을 입력하세요.");
				return false;
			}
			if($j("#boardComment").val() == ""){
				alert("내용을 입력하세요.");
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
					alert("작성완료");
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
	<form class="boardWrite">
		<table align="center">
			<tr>
				<td align="right">
					<input id="submit" type="button" value="작성">
					<input id="row" type="button" value="행추가">
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
