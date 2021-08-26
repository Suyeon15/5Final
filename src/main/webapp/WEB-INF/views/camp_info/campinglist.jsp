<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Camping List</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!--네비바 링크  -->
<link href="https://fonts.googleapis.com/css2?family=Nanum+Brush+Script&display=swap" rel="stylesheet">
<script src="https://kit.fontawesome.com/4625b781d5.js" crossorigin="anonymous"></script>
<link href="/css/liststyles.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Black+Han+Sans&family=Do+Hyeon&family=Noto+Sans+KR:wght@700&display=swap" rel="stylesheet">

</head>
<style>
	
	.portfolio-caption-heading, .portfolio-caption-subheading text-muted {
    font-family: 'Noto Sans KR', sans-serif;
    margin-top: 1%;
    font-size: 17px;
    text-align: left;
}
	
	#header{
		width:100%;
		height:200px;
		background-image:url('/img/campinglist/camping06.jpg');
		margin:0%;	
	}
	
	.text-center{
		margin: 50px 0 50px 0;
	}
	
	#headerimg{
		position:absolute;
		background-color:rgba(0, 0, 0, 0.35);
		width:100%;
		height:200px;
	}
	
	#searchbox{
		background-color:rgba(0, 0, 0, 0.10);
		width:90%;
		height:100px;
  		margin:auto;
  		text-align:center;
  		padding-top:3%;
  		margin-bottom: 5%;

	}
	
	#cmapinglist{
		margin: 0% 1% 0 1%;
	}
	
	#items{
		margin:auto;
		text-align:center;	
	}
	
	#searchinput{
		width:40%;
	}
	
#search {
    width: 80px;
    height: 30px;
    color:black;
}	
	
	
/*네비바 스타일  */     
:root{
    --text-color:#f0f4f5;
    --background-color:#263343;
    --accent-color:steelblue;
}
body{
    margin: 0;
    
}
a{
    text-decoration: none;
    color: white;


}

.navbar{
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #263343;
    padding: 8px 12px;
     z-index:100;
    

}


.navbar{
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
   
}


.navbar_logo{
    font-size: 32px;
    color: white;
    font-family: 'Nanum Brush Script';
}

.navbar_logo i {
    color: white;
}

.navbar_menu{
    display: flex;
    list-style: none;
    padding-left: 0;
    margin-bottom:-3px;

}

.navbar_menu li {
    padding: 8px 12px;
}


.navbar_menu li:hover {
    background-color: steelblue;
    border-radius: 4px;
}




.navbar_member {
    list-style: none;
    color: white;
    display: flex;
    padding-left: 0;
	margin-bottom:-3px;
}


.navbar_member li{
    padding: 8px 12px;
}

.navbar_toogleBtn{
    display: none;
    position: absolute;
    right: 32px;
    font-size: 24px;
    
}


@media screen and (max-width: 768px) {
    
    .navbar{
        flex-direction: column;
        align-items: flex-start;
        padding: 8px 24px;
         z-index:100;
    }

    .navbar_menu{
        display: none;
        flex-direction: column;
        align-items: center;
        width: 100%;
    }

    .navbar_menu li {
        width: 100%;
        text-align: center;
    }

    .navbar_member{
        display: none;
        justify-content: center;
        width: 100%;
    }
    .navbar_toogleBtn{
        display: block;
    }

    .navbar_menu.active,
    .navbar_member.active{
        display: flex;
    
    }

}

</style>
<script>
	$(function(){
		

		let index=1;
		$(window).scroll(function(){
			let $window = $(this);
			let scrollTop = $(this).scrollTop();
			let windowHeight = $window.height();
			let documentHeight = $(document).height();
			console.log("scrollTop : "+scrollTop+"| windowHeight : "+windowHeight+
					"| documentHeight"+documentHeight)
			if(scrollTop+windowHeight>=documentHeight){
				index++;
				console.log(index);
				if($("#searchKey").val()!=null){
					 setTimeout(getSearchList(),2000);
				}else{
					setTimeout(getList(),2000);	
				}
				
			}
					
		})
		
		function getList(){
			$.ajax({
				url:"/info/scroll",
				dataType:"json",
				data:{"index":index}
			}).done(function(resp){
				for(let i=0;i<resp.length;i++){
					let list = $("<div class='col-lg-3 col-sm-6 mb-4' id='items'>");
					
					let box = $("<div class='portfolio-item'>");
					let detaillink = $("<a href= /info/detail?contentId=" + resp[i].contentId +">");
					let image =$("<img class='img-fluid' src='" + resp[i].firstImageUrl + "''>");
					let box2 = $("<div class='portfolio-caption'>");
					let name = $("<div class='portfolio-caption-heading'>");
					name.text(resp[i].facltNm);

					list.append(box);
					box.append(detaillink);
					detaillink.append(image);
					list.append(box2);
					box2.append(name);
					

					$("#campinglist").append(list);
					
					
				}
			})
		}
		
		
		$("#search").on("click",function(){
			var searchOption = $("#searchOption").val();
			console.log(searchOption);
			location.href="/info/list?index=1&keyword="+$("#keyword").val() +"&searchOption="+searchOption;
		})

		
		function getSearchList(){
			$.ajax({
				url:"/info/scrollsearch",
				dataType:"json",
				data:{"index":index,"keyword":$("#searchKey").val}
			}).done(function(resp){
				for(let i=0;i<resp.length;i++){
					let list = $("<div class='col-3 list'>");
					
					let box = $("<div class='portfolio-item'>");
					let detaillink = $("<a href='" + resp[i].contentId +"'>");
					let image =$("<img class='img-fluid' src='" + resp[i].firstImageUrl + "''>");
					let box2 = $("<div class='portfolio-caption'>");
					let name = $("<div class='portfolio-caption-heading'>");
					name.text(resp[i].facltNm);

					list.append(box);
					box.append(detaillink);
					detaillink.append(image);
					list.append(box2);
					box2.append(name);
					
					$("#campinglist").append(list);
					
				}
			})
		}
		
	})
</script>
<!--네비바 시작 -->
<c:choose>
<c:when test="${loginID==null }">
<nav class="navbar">
        <div class="navbar_logo">
           
            <a href="/"><img src="/assets/img/background/newLogo_negative.png"style="width:90px;height:auto;margin-right:7px;margin-top:-12px;">별보러갈래?</a>

        </div>
        <ul class="navbar_menu">
            <li><a href="/info/list?index=1">캠핑장</a></li>
            <li><a href="/CampTipBoard/selectAll">캠핑정보</a></li>
            <li><a href="/products/selectAll?index=1">SHOP</a></li>
            <li><a href="/rep/list?index=1">중고장터</a></li>
            <li><a href="/gal/list?cpage=1">캠핑후기</a></li>

        </ul>
        <ul class="navbar_member">
            <li><a href="/member/signPage">회원가입</a></li>
            <li><a href="/member/loginPage">로그인</a></li>
        </ul>

        <a href="#" class="navbar_toogleBtn">
            <i class="fas fa-bars"></i>
        </a>
    </nav>

</c:when>
<c:when test="${loginID=='admin'}">
<nav class="navbar">
        <div class="navbar_logo">
           
            <a href="/"><img src="/assets/img/background/newLogo_negative.png"style="width:90px;height:auto;margin-right:7px;margin-top:-12px;">별보러갈래?</a>

        </div>
        <ul class="navbar_menu">
            <li><a href="/info/list?index=1">캠핑장</a></li>
            <li><a href="/CampTipBoard/selectAll">캠핑정보</a></li>
            <li><a href="/products/selectAll?index=1">SHOP</a></li>
            <li><a href="/rep/list?index=1">중고장터</a></li>
            <li><a href="/gal/list?cpage=1">캠핑후기</a></li>

        </ul>
        <ul class="navbar_member">
            <li><a href="/admin/home">관리자페이지</a></li>
            <li><a href="/member/logOutProc">로그아웃</a></li>
        </ul>

        <a href="#" class="navbar_toogleBtn">
            <i class="fas fa-bars"></i>
        </a>
    </nav>

</c:when>
<c:otherwise>
<nav class="navbar">
        <div class="navbar_logo">
           
            <a href="/"><img src="/assets/img/background/newLogo_negative.png"style="width:90px;height:auto;margin-right:7px;margin-top:-12px;">별보러갈래?</a>

        </div>
        <ul class="navbar_menu">
            <li><a href="/info/list?index=1">캠핑장</a></li>
            <li><a href="/CampTipBoard/selectAll">캠핑정보</a></li>
            <li><a href="/products/selectAll?index=1">SHOP</a></li>
            <li><a href="/rep/list?index=1">중고장터</a></li>
            <li><a href="/gal/list?cpage=1">캠핑후기</a></li>

        </ul>
        <ul class="navbar_member">
            <li><a href="/member/myPage?cm_id=${loginID}">마이페이지</a></li>
            <li><a href="/member/logOutProc">로그아웃</a></li>
        </ul>

        <a href="#" class="navbar_toogleBtn">
            <i class="fas fa-bars"></i>
        </a>
    </nav>

</c:otherwise>


</c:choose> 

<!--네비바 끝  -->

    
    <script>
    
    
    const toogleBtn = document.querySelector('.navbar_toogleBtn');
    const menu = document.querySelector('.navbar_menu');
    const member = document.querySelector('navbar_member');


    toogleBtn.addEventListener('click', () => {

        menu.classList.toggle('active');
        member.classList.toggle('active');


    });
    
    </script>
    
<div id=header>
     <div id="headerimg"></div>  
</div>           
<body id="page-top" class="" style="">
           <div class="container">			
           	<div class="list">
           	<!-- 캠핑 글씨 -->
                <div class="text-center">
                    <h2 class="section-heading text-uppercase">Camping</h2>
                    <h3 class="section-subheading text-muted"> 가고 싶은 캠핑장을 골라 보세요! </h3>
                </div>
             <!--  검색 박스 -->
             <div id="searchbox"> 
             		<select id="searchOption">
             			<option value="all" >전체</option>
             			<option value="facltNm"  > 캠핑장 이름 </option>
             			<option value="lctCl"> 주변 환경 (ex. 산 / 해변 / 계곡) </option>
             			<option value="addr1"  > 지역 </option>
             		</select>
             		<input type=text name="keyword" id="keyword">
             			<button type="button" class="btn btn-light" id="search">검색</button>
             			<input type=hidden value=${keyword} id=searchKey>
			</div>
			<!-- 검색 목록 출력 -->
			    <div class="row" id="campinglist">

                <c:forEach var="i" items="${slist}">
                    <div class="col-lg-3 col-sm-6 mb-4" id=items>
                        <div class="portfolio-item">
                        		<a href='/info/detail?contentId=${i.contentId }'><img class="img-fluid" src="${i.firstImageUrl}">
                            	</a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading">${i.facltNm}</div>
                                <div class="portfolio-caption-subheading text-muted"></div>
                            </div>
                        </div>
                    </div>
                 </c:forEach> 
 
                </div>
			<!--  목록 출력 -->
                <div class="row" id="cmapinglist">
                <c:forEach var="i" items="${list}">
                    <div class="col-lg-3 col-sm-6 mb-4" id=items>
                        <!-- Portfolio item 1-->
                        <div class="portfolio-item">
                        		<a href='/info/detail?contentId=${i.contentId }'><img class="img-fluid" src="${i.firstImageUrl}">
                            	</a>
                            <div class="portfolio-caption">
                                <div class="portfolio-caption-heading">${i.facltNm} </div>
                                <div class="portfolio-caption-subheading text-muted"></div>
                            </div>
                        </div>
                    </div>
                 </c:forEach>   
                </div>
              </div>
              
           </div>


        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    	<script botId="B2pe9j" src="https://www.closer.ai/js/webchat.min.js"></script>

</body>
</html>