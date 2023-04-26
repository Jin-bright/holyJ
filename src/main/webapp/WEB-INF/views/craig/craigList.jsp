<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isErrorPage="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="중고거래" name="title"/>
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/craig/craig.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css">
<style>
	dl, ol, ul { text-align: center; margin-top: 5px; margin-bottom: 0;}
	a { text-decoration:none !important }
	a:hover { text-decoration:none !important }
	.notice-wrap, .non-login {margin-top: 5px;}
	button, input, optgroup, select, textarea { margin: 0; font-family: 'Arial', sans-serif; font-size: 14px; font-weight: 600; }
	
	.dropdown-toggle:hover{ color: black; background-color: white; -webkit-appearance:none; }
	
	#writeCraigbtn{
		height:39px; width: 80px; 
		background-color: white; 
		color:black; 
		border: 1.5px solid black;
		top:-1px; position: relative; left:10px;  
	}
	
	#writeCraigbtn:hover { border-color:  #28a745; }
	
	#memberInfo{
		width: 100px;
		border: 1.5px solid black;
		height: 38px;
		padding: 6px;
		padding-bottom : 12px;
		vertical-align :middle;
		border-radius: 5px 5px 5px 5px;
		margin-top: 2px;
	}
	
	#craigWholeListTbl{
		margin: auto;
		margin-top : 50px;
 		padding: 40px;
 		margin-left : -25px;		
		border: none;
/*		width : 700px;	
 		원래700 */
	}
	
	.explains{ margin-bottom: 50px; width : 240px; margin: auto; }
	
	#eachimg{ border-radius : 15px 15px 15px 15px;  margin-bottom: 15px; }
	
	.page-link{ color: green; }
	
	.pne{ margin: 0 auto; }
	
	.pagination{ text-align: center; justify-content: center; }
	
	#searchToWriteDiv{
		margin: 0 auto; text-align: center;
		display: flex; justify-content: center; margin-left: -110px;
	}
	
	.searchdiv { margin-left: 1px; display: inline-block; margin-left: -10px}
	
/* header */
.nav-link{ margin-top: -5px }
.profile-wrap{ margin-top: 5px }
.login-box { width: 140px;
    display: flex; align-items: center;
    justify-content: flex-end;  margin-top: -5px ;
}
</style>
<div style="height: 240px; background-color: #E3EDCD">
	<div class="seconddivv" >
	 	<div style="margin-top: 10px; margin-left: 54px; "><h1>우리 동네</h1><h1 style="margin-bottom: 40px"> 중고 직거래 마켓</h1>
	 	<p>동네 주민들과 가깝고 따뜻한 거래를 지금 경험해보세요.</p></div>
	</div>
</div>
	<%-- 글쓰기 / 카데고리 --%>
	<div id="searchToWriteDiv" style="margin-top: 10px;">
	   	<div class="btn-group" style="margin-left: 93px; margin-right: 10px ">
			<button type="button" style="width:160px; border: 1.5px solid black  ; height:36px; appearance:none; margin-top: 2px;" class="btn btn-success dropdown-toggle"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		    	중고거래 카테고리
			</button>
		  	<ul class="dropdown-menu">
			  <c:forEach items="${craigCategory}" var="category">
			    <li data-no="${category.CATEGORY_NO}"><a class="dropdown-item" data-ano="${category.CATEGORY_NO}"  href="#">${category.CATEGORY_NAME}</a></li>
		   	  </c:forEach>
  			    <li ><a class="dropdown-item"  href="${pageContext.request.contextPath}/craig/craigList.do"> 전체 </a></li>	   	  
			</ul>
		</div>

		<span id="memberInfo" ></span>
		<%--  검색 --%>		
	    <div class="searchdiv" style=""> <%-- 동일핸들러로 보내보자 --%>
		    <form:form action=""
	    		 id="keywordFrm" name="keywordFrm" style="display:inline" method="get">
		    	<input type="text"  name="searchKeyword" id="searchKeyword" placeholder=" 검색어를 입력해주세요 ">
		    	<button type="submit" class="searchButton"> <i class="fa fa-search"></i> </button>
	      	</form:form>
       	 	<button id="writeCraigbtn"  class="btn btn-success " style=""> 글쓰기</button>
	    </div>
	</div>
<section id="craigWhole" >	
<%-- whole List  --%>
	<c:if test="${searchCraigs == null  }">
		<h3 id="popularh3" style="margin: 80px 40px 80px 0; text-align: center; padding-left : 70px;"> 중고거래 인기 매물</h3>
	</c:if>
		
	<c:if test="${searchCraigs[0] != null && searchCraigs != '' && searchKeyword != null && searchKeyword != '' }">
		<h3 style="margin: auto; margin-top: 50px; text-align: center;"><span id="searchWord" style="color: green; text-decoration: underline;">${searchKeyword} </span>(으)로 검색한 결과</h3>
		<script>
		document.querySelector(".dropdown-toggle").addEventListener('click', e=>{
			alert("검색과 카테고리를 동시에 사용하실 수 없습니다😣");
			location.href = "${pageContext.request.contextPath}/craig/craigList.do";
		})
		</script>
	</c:if>
	<c:if test="${searchCraigs[0] == null && searchKeyword != null  }">
		<h3 style="margin: auto; margin-top: 80px; text-align: center;"><span id="searchWord" style="color: green; text-decoration: underline;">${searchKeyword} </span>(으)로 검색한 결과가 없습니다!</h3>
		<img  style="width:700px; height: 600px; margin:70px 0 0 280px " src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png" alt="First slide" >
		<script>
		document.querySelector(".dropdown-toggle").addEventListener('click', e=>{
			alert("검색과 카테고리를 동시에 사용하실 수 없습니다😣");
			location.href = "${pageContext.request.contextPath}/craig/craigList.do";
		})
		</script>
	</c:if>
	
<%-- ★★★★★ 걍 결과 ★★★★★--%>
		<table id="craigWholeListTbl" style="margin: 0 auto; text-align: center;">
			<tbody>
			<c:forEach items="${craigList}" var="craig" varStatus="vs">
				<c:if test="${vs.index%4==0}">
					<tr data-no="${craig.no}" style="padding-bottom : 30px; margin-bottom : 30px; ">
				</c:if>
					  <td class="crnotd" data-crno="${craig.no}" style="width:350px; height: 380px; padding: 30px; padding-right: 45px">
						<div class="explains">
							<%-- img --%>
							<c:if test="${craig.attachments[0].reFilename != null}">
							    <a><img id="eachimg"  style="display : inline-block; height : 250px; width:240px; " 
									    src="${pageContext.request.contextPath}/resources/upload/craig/${craig.attachments[0].reFilename}"/></a><br/>
							</c:if>
							<c:if test="${craig.attachments[0].reFilename==null}">
							    <a><img id="eachimg"  style="display : inline-block; height : 250px; width:240px;" 
									    src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"/></a><br/>
							</c:if>
								<p id="crtitle" class="crpp">${craig.title}</p>

							<%-- CR1 || CR3--%>
							<c:if test="${craig.state == 'CR1'}">
								<p style="text-align: left; margin: 0 0 0px 5px; "><span class="badge badge-success" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 예약중 </span></p>
							</c:if>
							<c:if test="${craig.state == 'CR2'}">
								<p style="text-align: left; margin: 0 0 0px 5px; "><span class="badge badge-secondary" style="height: 22px;font-size: 13px; text-align: left; bavertical-align: middle; background-color: white"> </span></p>
							</c:if>
							<c:if test="${craig.state == 'CR3' && craig.price != 0  }">
								<p style="text-align: left; margin: 0 0 0px 5px; "><span class="badge badge-secondary" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 거래완료 </span></p>
							</c:if>
							<c:if test="${craig.state == 'CR3' && craig.price == 0 && craig.categoryNo != 7  }">
								<p style="text-align: left; margin: 0 0 0px 5px; "><span class="badge badge-secondary" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 나눔완료 </span></p>
							</c:if>
							<c:if test="${craig.price > 0}">
								<p id="crprice" class="crpp" style="font-size:17px; margin-right: 20px;"> <fmt:formatNumber pattern="#,###" value="${craig.price}" />원</p>
							</c:if>		
							<c:if test="${craig.price == 0 && craig.categoryNo != 7 }">
								<p id="crPrice" class="crpp" style="margin-bottom: 3px; margin-top:0; margin-top: 15px; font-size: 17px;">나눔💚</p>
							</c:if>
								<p id="crdong" class="crpp">${craig.dong.dongName}</p> 
								<p style="text-align: left"><span id="crwishsp" class="crwishchat" >관심</span>  <span id="crwish">${wishCnt[vs.index]}</span>  <span id="crchat" class="crwishchat"> · 채팅</span><span id="crchat"> ${craigChatCnt[vs.index]} </span></p> 
							</div>
						</td>
					<c:if test="${vs.index %4==3}">
						</tr>
					</c:if>
				</c:forEach>
			
<%--  ★★★★★ 검색 결과 ★★★★★--%>
		<c:if test="${searchCraigs != null}">
			<c:forEach items="${searchCraigs}" var="searchcraig" varStatus="searchvs">
				<c:if test="${searchvs.index%4==0}">
					<tr data-no="${searchcraig.no}" style="padding-bottom : 30px; margin-bottom : 30px; ">
				</c:if>
					  <td class="crnotd" data-crno="${searchcraig.no}" style="width:350px; height: 380px; padding: 10px">
						<div class="explains">
							<%-- img --%>
							<c:if test="${searchcraig.attachments[0].reFilename != null}">
							    <a><img id="eachimg"  style="display : inline-block; height : 250px; width:240px; " 
									    src="${pageContext.request.contextPath}/resources/upload/craig/${searchcraig.attachments[0].reFilename}"/></a><br/>
							</c:if>
							<c:if test="${searchcraig.attachments[0].reFilename==null}">
							    <a><img id="eachimg"  style="display : inline-block; height : 250px; width:240px;" 
									    src="${pageContext.request.contextPath}/resources/images/OEE-LOGO2.png"/></a><br/>
							</c:if>

							<p id="crtitle" class="crpp">${searchcraig.title}</p>
							
							<%-- CR1 || CR3--%>
							<c:if test="${searchcraig.state == 'CR1'}">
								<p style="text-align: left; margin: 0 0 0px 5px; "><span class="badge badge-success" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 예약중 </span></p>
							</c:if>
							<c:if test="${searchcraig.state == 'CR2'}">
								<p style="text-align: left; margin: 0 0 0px 5px; "><span class="badge badge-secondary" style="height: 22px;font-size: 13px; text-align: left; bavertical-align: middle; background-color: white"> </span></p>
							</c:if>
							<c:if test="${searchcraig.state == 'CR3' && searchcraig.price != 0  }">
								<p style="text-align: left; margin: 0 0 0px 5px; "><span class="badge badge-secondary" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 거래완료 </span></p>
							</c:if>
							<c:if test="${searchcraig.state == 'CR3' && searchcraig.price == 0 && searchcraig.categoryNo != 7  }">
								<p style="text-align: left; margin: 0 0 0px 5px; "><span class="badge badge-secondary" style="height: 22px; font-size: 13px; text-align: left; vertical-align: middle;"> 나눔완료 </span></p>
							</c:if>
							
							<c:if test="${searchcraig.price > 0}">
								<p id="crprice" class="crpp" style="font-size:17px; margin-right: 20px;"> <fmt:formatNumber pattern="#,###" value="${searchcraig.price}" />원</p>
							</c:if>		
							<c:if test="${searchcraig.price == 0 && searchcraig.categoryNo != 7 }">
								<p id="crPrice" class="crpp" style="margin-bottom: 3px; margin-top:0; font-size: 17px;">나눔💚</p>
							</c:if>
								<p id="crdong" class="crpp">${searchcraig.dong.dongName}</p> 
								<p style="text-align: left"><span id="crwishsp" class="crwishchat" >관심</span>  <span id="crwish">${wishCnt[searchvs.index]}</span>  <span id="crchat" class="crwishchat"> · 채팅</span><span id="crchat">${craigChatCnt[searchvs.index]}</span></p>
							</div>
						</td>
					<c:if test="${searchvs.index %4==3}">
						</tr>
					</c:if>
				</c:forEach>
			</c:if>
	<%-- ★★★★★★★★★★--%>
			</tbody>
		</table><br><br><br><br><br>
</section>



		<%-- ◆◆◆ 페이징 ◆◆◆--%>
		<nav aria-label="Page navigation example">
			<ul class="pagination">
				<!--  pre   --> 
	            <c:if test="${searchCraigs == null}">
          			   <c:choose>
		   	          <c:when test="${ page  <= 1   }"> 			    
  							<li class="page-item"><a class="page-link" > 이전 </a></li>
  						  </c:when>
					  <c:otherwise>
            				<li class="page-item" ><a class="page-link" href="${pageContext.request.contextPath}/craig/craigList.do?cpage=${page-1}"> 이전 </a></li>					
					   </c:otherwise>
					</c:choose> 
				</c:if>
				<c:if test="${searchCraigs != null}">
         			   <c:choose>
		   	          <c:when test="${ page  <= 1   }"> 			    
  							<li class="page-item"><a class="page-link" > 이전 </a></li>
  						  </c:when>
					  <c:otherwise>
            				<li class="page-item" ><a class="page-link" href="${pageContext.request.contextPath}/craig/craigList.do?searchKeyword=${searchKeyword}&cpage=${page-1}"> 이전 </a></li>					
					   </c:otherwise>
					</c:choose> 
 				</c:if>

	 		<!--  now --> 
	        <c:forEach var="cpage"  begin="${craigPage.min}" end="${craigPage.max}">       
	          <c:choose>
				<c:when test="${cpage == craigPage.currentPage}">
					<c:if test="${searchCraigs == null}">
				      <li class="page-item nowpagegreen"><a style="background-color: #008200; color: white;"  class="page-link nowpagegreen" href="${pageContext.request.contextPath}/craig/craigList.do?cpage=${cpage}">${cpage}</a></li>
					</c:if>	
					
				    <c:if test="${searchCraigs != null}">
				      <li class="page-item"><a class="page-link" style="background-color: #008200; color: white;" href="${pageContext.request.contextPath}/craig/craigList.do?searchKeyword=${searchKeyword}&cpage=${cpage}">${cpage}</a></li>
					</c:if>
			    </c:when>	
			    		    
			    <c:otherwise>
			    	<c:if test="${searchCraigs == null}">
	    			    <li class="page-item"><a class="page-link"  href="${pageContext.request.contextPath}/craig/craigList.do?cpage=${cpage}">${cpage}</a></li>
			    	</c:if>
   			    	<c:if test="${searchCraigs != null}">
	    			    <li class="page-item"><a class="page-link"  href="${pageContext.request.contextPath}/craig/craigList.do?searchKeyword=${searchKeyword}&cpage=${cpage}">${cpage}</a></li>
			    	</c:if>
		 		</c:otherwise>
			 </c:choose>  
			</c:forEach>
			<%----- next  --%>
		    <c:if test= "${searchCraigs == null }">
			   <c:choose>
	   	          <c:when test="${ page  < craigPage.max  }"> 			    
	   			    <li class="page-item"><a class="page-link"  href="${pageContext.request.contextPath}/craig/craigList.do?cpage=${page+1}"> 다음 </a></li>			    
				  </c:when>
				  <c:otherwise>
				     <li class="page-item"><a class="page-link" >다음</a></li>
				   </c:otherwise>
				</c:choose>   
			</c:if>  	          
		    <c:if test= "${searchCraigs != null }">
		    	<c:choose>
		          <c:when test="${ page  < craigPage.max  }"> 			    
	   			    <li class="page-item"><a class="page-link"  href="${pageContext.request.contextPath}/craig/craigList.do?searchKeyword=${searchKeyword}&cpage=${page+1}"> 다음 </a></li>			    
				  </c:when>
		          <c:otherwise>
				      <li class="page-item"><a class="page-link" >다음</a></li>
				  </c:otherwise>
				</c:choose> 
			</c:if>		         
			</ul>
		</nav>

<%-- 비동기 더보기 버튼 --%>
	<div class="btbca" style="text-align: center;	">
	<button id="btn-more"  class="btn" style="margin: auto; visibility: hidden; width:100px; border: 1px solid green;" > 더보기 <span id="searchPage" >1</span> </button>	
	</div>
<script>
document.querySelectorAll("span[data-no]").forEach( (tr)=>{
	tr.addEventListener('click', (e) => {
		console.log(e.target);
		console.log( tr );
		
		const no = tr.dataset.no;
		console.log( no );
	})
})

//글쓰기 
document.querySelector("#writeCraigbtn").addEventListener('click', (e) => {
			location.href = `${pageContext.request.contextPath}/craig/craigEnroll.do`;

});
</script>

<script>
//■ 상세페이지
document.querySelectorAll("td[data-crno]").forEach( (td)=>{
	td.addEventListener('click', (e) => {
		console.log(e.target);
		console.log( td );
		
		const no = td.dataset.crno;
		console.log( no );
		location.href = "${pageContext.request.contextPath}/craig/craigDetail.do?no="+no;
		
	})
})

</script>

<script>
//■ 내동네
window.addEventListener('load', () => {
	const memberInfo = document.querySelector("#memberInfo");
	
	$.ajax({
		url : `${pageContext.request.contextPath}/craig/getMyCraigDong.do`,
		method : 'get',
		dataType : 'json',
		data : { dongNo : '<sec:authentication property="principal.dongNo" />'},
		success(data){
			memberInfo.innerHTML =   data.dongName  ;
		},
		error : console.log
	});
});
</script>


<script>
// ■ 검색
document.querySelector(".searchButton").addEventListener('click', (e)=>{
//	const sfrm = document.keywordFrm;	
	const searchKeyword =  document.querySelector("#searchKeyword").value;
	console.log(searchKeyword);

	const blank_pattern = /^\s+|\s+$/g;  //정규표현식 공란있음 안됨 
	if(searchKeyword.replace(blank_pattern, '' ) == "" ){
		alert("검색어를 입력해주세요!");
		document.querySelector("#searchKeyword").select();
		e.preventDefault();
		return false;
	}
	
	else if(searchKeyword != null && searchKeyword !="" ){
		location.href = "${pageContext.request.contextPath}/craig/craigList.do";
	}	
});
</script>

		
<script>
// ■ 카테고리 - 비동기 - 리팩토링 0425 
	const getMoreCategory = ( page, categoryLi ) => {
		
		const nav  = document.querySelector("nav");
		const tbody  = document.querySelector("#craigWholeListTbl tbody");
		const h3  = document.querySelector("#popularh3");
		
		let searchPage = document.querySelector("#searchPage").innerHTML;
		let categoryNumber = categoryLi.dataset.no;
	
		if( categoryLi.dataset.no == null ){ //더보기에서 클릭했을때
			  categoryNumber = categoryLi.dataset.ano;	
		}
		
		h3.innerHTML = "";
		nav.innerHTML = "";
		
		
		if( page == 1 ){ // 앞에 내용이 나와야되니까 
			tbody.innerHTML = ""; //일단 tbody 안에 내용 비운다 
		}

//		console.log( "버튼에서 호출했을때 categoryNumber -> " , categoryNumber   );
		console.log("내가호출한 함수의 page : ", page );
		
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
		
		//비동기시작
		$.ajax({
			url : `${pageContext.request.contextPath}/craig/selectCategorySearchNew.do`,
			method : 'post',
			headers,
			dataType : "html",
			data : { categoryNo : categoryNumber,
					 cpage : searchPage },
			success(data){
						 
				let oldData;						 
				if( page == 1 ){
					oldData = $("tbody").html(data);				    	
				}

				if( page > 1){
					$("tbody").append(data);
			    }

 			},
			error : console.log,
			complete(){
			}	
		});//end-ajax
	
	};/// 함수끝 

	
	// ※※ 실제 카테고리 선택하면 호출 되는 함수 
	let letCategoryLi = ""; //전역
	document.querySelectorAll("li[data-no]").forEach( (categoryLi)=>{
				
		categoryLi.addEventListener('click', (e) => {
			
		const selectedValue = e.target.innerHTML; //값셋팅
			  document.querySelector(".dropdown-toggle").innerHTML = selectedValue;
		
		const categoryNumber = categoryLi.dataset.no;
		      letCategoryLi = e.target; //해당 li

	      getMoreCategory(1, categoryLi); // 함수호출  
		});		  
	});		  
		  
	// ※※ 더보기 버튼이 있을 경우 호출하는 함수
	document.querySelector("#btn-more").addEventListener('click', ()=>{
	
		 const searchPage = document.querySelector("#searchPage").innerHTML; //searchPage		 
		 getMoreCategory(searchPage, letCategoryLi); // ■■ 더보기함수호출
		 console.log( "더보기실행 : searchPage ", searchPage   ); // 해당  page, li
	});
</script>

<br><br><br><br>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>