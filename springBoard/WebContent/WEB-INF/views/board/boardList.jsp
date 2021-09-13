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
	//페이지 로드
	$j(document).ready(function(){
		
 		// '전체' 선택 시, 모든 codeId 선택
		$j(".typeCk").click(function(){
			
			var flag = $j(this).val(); // 클릭한 체크박스 구분
			var totalCnt = $j("input[name='codeId']").length; // a01 ~ a04 체크박스
			var checkCnt = $j("input[name='codeId']:checked").length; // 체크된 a01 ~ a04 체크박스
			
			if(flag == "all"){ // '전체'가 체크된 경우
				if($j("#checkAll").prop("checked")){
					$j("input[name='codeId']").prop("checked", true); // a01 ~ a04 모두 체크
				} else{ // '전체'가 체크해제된 경우
					$j("input[name='codeId']").prop("checked", false); // a01 ~ a04 모두 체크해제
				}
			} else{ // '전체' 외 체크된 경우
				if(totalCnt == checkCnt){ // a01 ~ a04 체크박스 갯수와 현재 체크된 체크박스 갯수가 같을 경우
					$j("#checkAll").prop('checked', true); // '전체' 체크
				} else{
					$j("#checkAll").prop('checked', false); // '전체' 체크해제
				}
			}
			
		});
		
 		// 게시글 작성
 		$j("#boardWrite_btn").on("click", function(){
 			if(${userInfo == null}){ // 비로그인 시, 글 작성 막기
 				alert("로그인이 필요합니다.");
 				return false;
 			}else if(${userInfo != null}){ // 로그인 시, 글 작성하기
 				location.href = "/board/boardWrite.do";
 			}
 		});
 		
		// 타입별 조회
		$j("#search_btn").on("click", function(){
			var len = $j("input[name='codeId']:checked").length;
			var checkArr = [];
			
			// 체크된 타입의 값을 배열에 넣기
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
			<!-- 비로그인 화면 -->
			<c:if test="${userInfo eq null}">
				<a href="/user/userLogin.do" class="left">login</a>
				<a href="/user/userJoin.do" class="left">join</a>
				total : ${totalCnt}
			</c:if>
			
			<!-- 로그인 화면 -->
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
				<a href="#" id="boardWrite_btn">글쓰기</a>
				<!-- 로그인 시, 로그아웃 보이기 -->
				<c:if test="${userInfo ne null}">
					<a href="#" onclick="location.href='/user/userLogout.do'">로그아웃</a>
				</c:if>
			</td>
		</tr>
		<tr>
			<td>
				<!-- 타입별 조회 -->
 				<form id="selectType" class="selectType" method="get" action="/board/boardList.do">
					<input type="hidden" id="searchArr" name="searchArr"/>
					
					<input type="checkbox" class="typeCk" id="checkAll" value="all">전체
					<c:forEach items="${comCodeList}" var="code" varStatus="status">
						<input type="checkbox" class="typeCk" name="codeId" value="${code.codeId}">${code.codeName}</>
					</c:forEach>
					<button type="button" id="search_btn">조회</button>
				</form>
			</td>
		</tr>
	</table>	
</body>

</html>
