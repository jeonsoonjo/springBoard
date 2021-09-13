<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardList</title>
</head>

<style>
	.left{
		float: left;
	}
	.left:nth-child(2){
		margin-left: 10px;
	}
	.userName{
		float: left;
	}
</style>

<script type="text/javascript">
	//������ �ε�
	$j(document).ready(function(){
		
 		// '��ü' ���� ��, ��� codeId ����
		$j(".typeCk").click(function(){
			
			var flag = $j(this).val(); // Ŭ���� üũ�ڽ� ����
			var totalCnt = $j("input[name='codeId']").length; // a01 ~ a04 üũ�ڽ�
			var checkCnt = $j("input[name='codeId']:checked").length; // üũ�� a01 ~ a04 üũ�ڽ�
			
			if(flag == "all"){ // '��ü'�� üũ�� ���
				if($j("#checkAll").prop("checked")){
					$j("input[name='codeId']").prop("checked", true); // a01 ~ a04 ��� üũ
				} else{ // '��ü'�� üũ������ ���
					$j("input[name='codeId']").prop("checked", false); // a01 ~ a04 ��� üũ����
				}
			} else{ // '��ü' �� üũ�� ���
				if(totalCnt == checkCnt){ // a01 ~ a04 üũ�ڽ� ������ ���� üũ�� üũ�ڽ� ������ ���� ���
					$j("#checkAll").prop('checked', true); // '��ü' üũ
				} else{
					$j("#checkAll").prop('checked', false); // '��ü' üũ����
				}
			}
			
		});
		
 		// �Խñ� �ۼ�
 		$j("#boardWrite_btn").on("click", function(){
 			if(${userInfo == null}){ // ��α��� ��, �� �ۼ� ����
 				alert("�α����� �ʿ��մϴ�.");
 				return false;
 			}else if(${userInfo != null}){ // �α��� ��, �� �ۼ��ϱ�
 				location.href = "/board/boardWrite.do";
 			}
 		});
 		
		// Ÿ�Ժ� ��ȸ
		$j("#search_btn").on("click", function(){
			var len = $j("input[name='codeId']:checked").length;
			var checkArr = [];
			
			// üũ�� Ÿ���� ���� �迭�� �ֱ�
			if(len > 0){
				 $j("input[name='codeId']:checked").each(function(e){
					 var value = $j(this).val();
					 checkArr.push(value);
				 })
			}
			$j("#searchArr").val(checkArr);
			$j("#selectType").submit();
		});
		
	});
</script>

<body>
	<table align="center">
		<tr>
			<td align="right">
			<!-- ��α��� ȭ�� -->
			<c:if test="${userInfo eq null}">
				<a href="/user/userLogin.do" class="left">login</a>
				<a href="/user/userJoin.do" class="left">join</a>
				total : ${totalCnt}
			</c:if>
			
			<!-- �α��� ȭ�� -->
			<c:if test="${userInfo ne null}">
				<span class="userName">${userInfo.userName}</span>
				total : ${totalCnt}
			</c:if>
			</td>
		</tr>
		<tr>
			<td>
				<table id="boardTable" border="1">
					<tr>
						<td width="80" align="center">Type</td>
						<td width="40" align="center">No</td>
						<td width="300" align="center">Title</td>
					</tr>
					<c:forEach items="${boardList}" var="list">
						<tr>
							<td align="center">${list.boardTypeNm}</td>
							<td align="center">${list.boardNum}</td>
							<td>
								<a href="/board/${list.boardType}/${list.boardNum}/boardView.do?pageNo=${pageNo}" id="listView_btn">${list.boardTitle}</a>
							</td>
						</tr>	
					</c:forEach>
				</table>
			</td>
		</tr>
		<tr>
			<td align="right">
				<a href="#" id="boardWrite_btn">�۾���</a>
				<!-- �α��� ��, �α׾ƿ� ���̱� -->
				<c:if test="${userInfo ne null}">
					<a href="#" onclick="location.href='/user/userLogout.do'">�α׾ƿ�</a>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>
				<!-- Ÿ�Ժ� ��ȸ -->
 				<form id="selectType" class="selectType" method="get" action="/board/boardList.do">
					<input type="hidden" id="searchArr" name="searchArr"/>
					
					<input type="checkbox" class="typeCk" id="checkAll" value="all">��ü
					<c:forEach items="${comCodeList}" var="code" varStatus="status">
						<input type="checkbox" class="typeCk" name="codeId" value="${code.codeId}">${code.codeName}</>
					</c:forEach>
					<button type="button" id="search_btn">��ȸ</button>
				</form>
			</td>
		</tr>
	</table>	
</body>

</html>
