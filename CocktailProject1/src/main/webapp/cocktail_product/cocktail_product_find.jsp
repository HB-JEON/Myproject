<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.header {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 127px; 
	background-color: #fff;
	z-index: 1100;
	box-shadow: none;
}

.hero.hero-normal {
	position: fixed;
	top: 127px; /* 헤더 바로 아래에 위치 */
	left: 0;
	width: 100%;
	height: 81px; /* hero 섹션 높이 */
	background-color: #fff;
	z-index: 1050;
	box-shadow: none;
}

.breadcrumb-section {
	margin-top: 208px;
	border: none;
	box-shadow: none;
}

.product__details__text .cart-icon {
	display: inline-block;
	font-size: 16px;
	color: #6f6f6f;
	padding: 13px 16px 13px;
	background: #f5f5f5;
}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
let curpage=1
let totalpage=0;
let startPage=0;
let endPage=0;
$(function(){
	commons(1)
	
	$('#findBtn').click(function(){
		commons(1)
	})
	$('#ss').keydown(function(e){
		if(e.keyCode==13)
		{
			commons(1)
		}
	})
})

function prev(page)
{
	commons(page)
}
function next(page)
{
	commons(page)
}
function pageChange(page)
{
	commons(page)
}
let commons=(page) => {
	let ss=$('#ss').val()
	$.ajax({
		type:'post',
		url:'../cocktail_product/cocktail_product_find_ajax.do',
		data:{"ss":ss, "page":page},
		success:(res) => {
			try
			{
				let json=JSON.parse(res);
				console.log("서버 응답 : ", json);
				jsonView(json);
			}catch(error)
			{
				console.error("파싱 오류 : ", error.message);
				console.log("응답 내용 : ", res);
			}
		},
		error: (xhr, status, error) => {
			console.error("요청 오류 :", status, error);
		}
	})
}

let jsonRecommendView=(json) => {
	let html="";
		html+='<div class="product__discount">'
		+'<div class="section-title product__discount__title">'
		+'<h2>추천 상품</h2>'
		+'</div>'
		+'<div class="row">'
		+'<div class="product__discount__slider owl-carousel">'
		
		json.map((product) => {
	    +'<div class="col-lg-4">'
	    +'<div class="product__discount__item">'
	    +'<div class="product__discount__item__pic set-bg">'
	    +'<a href="../cocktail_product/cocktail_product_detail_before.do?product_no=' + cocktail_product.product_no + '&cno=' + cocktail_product.cno + '">'
	    +'<img src="' + cocktail_product.poster + '" style="width: 100%; height: 200px;">'
	    +'</a>'
	    +'<ul class="product__item__pic__hover">';
	    +'<li><a href="#"><i class="fa fa-heart"></i></a></li>'
	    +'<li><a href="#"><i class="fa fa-retweet"></i></a></li>'
	    +'<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>'
	    +'</ul>'
	    +'</div>'
	    +'<div class="product__discount__item__text">'
	    +'<h5><a href="../cocktail_product/cocktail_product_detail_before.do?product_no=' + cocktail_product.product_no + '&cno=' + cocktail_product.cno + '">' + cocktail_product.name + '</a></h5>'
	    +'<div class="product__item__price">' + cocktail_product.price + '</div>'
	    +'</div>'
	    +'</div>'
	    +'</div>'
	    })
	    
	    html += '</div>'
	    html += '</div>'
	    html += '</div>'
	    $('#recommend').html(html)
	}

		
let jsonView=(json) => {
	let html="";
	json.map((cocktail_product) => {
		html+='<div class="row">'
		+'<div class="col-lg-4 col-md-6 col-sm-6" data-scrollmagic>'
		+'<div class="product__item">'
		+'<div class="product__item__pic set-bg">'
		+'<a href="../cocktail_product/cocktail_product_detail_before.do?product_no='+cocktail_product.product_no+'&cno='+cocktail_product.cno+'"><img src="'+cocktail_product.poster+'" style="width: 100%; height: 200px;"></a>'
		+'<ul class="product__item__pic__hover">'
		+'<li><a href="#"><i class="fa fa-heart"></i></a></li>'
		+'<li><a href="#"><i class="fa fa-retweet"></i></a></li>'
		+'<li><a href="#"><i class="fa fa-shopping-cart"></i></a></li>'
		+'</ul>'
		+'</div>'
		+'<div class="product__item__text">'
		+'<h6><a href="../cocktail_product/cocktail_product_detail_before.do?product_no='+cocktail_product.product_no+'&cno='+cocktail_product.cno+'">'+cocktail_product.name+'</a></h6>'
		+'<h5>'+cocktail_product.price+'</h5>'
		+'</div>'
		+'</div>'
		+'</div>'
		+'</div>'
	})
	
	html+='<div class="container">'
	html+='<div class="">'
	html+='<div class="product__pagination">'
	
		if(json[0].startPage>1)
	    {
	    html+='<a onclick="prev('+(json[0].startPage-1)+')" style="cursor:pointer"><i class="fa fa-long-arrow-left"></i></a>'
	    }
	    
	    for(let i=json[0].startPage;i<=json[0].endPage;i++)
	   	{
			if(json[0].curpage===i){
	    	html+='<a class="checked" style="cursor:pointer" onclick="pageChange('+i+')">'+i+'</a>'
			}
			else{
				html+='<a onclick="pageChange('+i+')" style="cursor:pointer">'+i+'</a>'
			}
	    }
	    
		if(json[0].endPage<json[0].totalpage)
		{
	    html+='<a onclick="next('+(json[0].endPage+1)+')" style="cursor:pointer"><i class="fa fa-long-arrow-right"></i></a>'
		}
	    html+='</div>'
	    html+='</div>'
	    html+='</div>'
	      
		$('#view').html(html);
}
</script>
</head>
<body>
<!-- Hero Section Begin -->
    <section class="hero hero-normal">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="hero__categories">
                        <div class="hero__categories__all">
                            <i class="fa fa-bars"></i>
                            <span>상품</span>
                        </div>
                        <ul>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=1">레드</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=2">화이트</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=3">로제</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=4">스파클링</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=5">아메리칸 위스키</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=6">스카치 위스키</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=13">리큐르</a></li>
                            <li><a href="#">하이볼 글라스</a></li>
                            <li><a href="#">칵테일 쉐이커</a></li>
                            <li><a href="#">지거/믹싱턴</a></li>
                            <li><a href="#">바 스푼</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="hero__search">
                        <div class="hero__search__form">
                            <form action="#">
                                <div class="hero__search__categories">
                                    All Categories
                                    <span class="arrow_carrot-down"></span>
                                </div>
                                <input type="text" id="ss" placeholder="What do yo u need?">
                                <button id="findBtn" class="site-btn">검색</button>
                            </form>
                        </div>
                        <div class="hero__search__phone">
                            <div class="hero__search__phone__icon">
                                <i class="fa fa-phone"></i>
                            </div>
                            <div class="hero__search__phone__text">
                                <h5>+65 11.188.888</h5>
                                <span>support 24/7 time</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
<!-- Breadcrumb Section End -->

<!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="../img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>주류 스토어</h2>
                        <div class="breadcrumb__option">
                            <a href="cocktail_product_list.do">Home</a>
                            <span>Shop</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
<!-- Breadcrumb Section End -->
    
<!-- Product Section Begin -->
<section class="product spad">
    <div class="container">
        <div class="row">
            <!-- 사이드바 시작 -->
            <div class="col-lg-3 col-md-5">
                <div class="sidebar">
                    <div class="sidebar__item">
                        <h4>카테고리</h4>
                        <ul>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=1">레드 와인</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=2">화이트 와인</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=3">로제 와인</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=4">스파클링 와인</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=5">아메리칸 위스키</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=6">스카치 위스키</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=7">아이리쉬 위스키</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=8">캐나다 위스키</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=9">일본 위스키</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=10">브랜디</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=11">꼬냑</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=12">알마냑</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=13">리큐르</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=14">진</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=15">럼</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=16">보드카</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=17">데킬라</a></li>
                            <li><a href="../cocktail_product/cocktail_product_list.do?cno=18">전통주</a></li>
                        </ul>
                    </div>
                    <div class="sidebar__item">
                        <h4>가격대</h4>
                        <div class="price-range-wrap">
                            <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
                                data-min="10000" data-max="3000000">
                                <div class="ui-slider-range ui-corner-all ui-widget-header"></div>
                                <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
                                <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
                            </div>
                            <div class="range-slider">
                                <div class="price-input">
                                    <input type="text" id="minamount" value="₩10,000">
                                    <input type="text" id="maxamount" value="₩3,000,000">
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="sidebar__item">
                        <div class="latest-product__text">
                          <h4>오늘 본 상품</h4>
                           <div class="latest-product__slider owl-carousel">
                             <c:forEach var="pageList" items="${cList4 }">
                                <div class="latest-prdouct__slider__item">
                                  <c:forEach var="cvo" items="${pageList }">
                                    <a href="../cocktail_product_detail.do?product_no=${cvo.product_no }&cno=${cvo.cno }" class="latest-product__item">
                                        <div class="latest-product__item__pic">
                                            <img src="${cvo.poster }">
                                        </div>
                                        <div class="latest-product__item__text">
                                            <h6>${cvo.name }</h6>
                                            <span>${cvo.price }</span>
                                        </div>
                                    </a>
                                  </c:forEach>
                                </div>
                            </c:forEach>
                          </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- 사이드바 끝 -->

            <!-- 상품 목록 시작 -->
            <div class="col-lg-9 col-md-7">
               <div class="container">
                <div class="row" id="recommend"></div>
               </div>        
                <div class="filter__item">
                    <div class="row">
                        <div class="col-lg-4 col-md-5">
                            <div class="filter__sort">
                                <span>Sort By</span>
                                <select>
                                    <option value="0">Default</option>
                                    <option value="1">Price Low to High</option>
                                    <option value="2">Price High to Low</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-4">
                            <div class="filter__found">
                                <h6><span>${totalcount }</span>개의 상품</h6>
                            </div>
                        </div>
                        <div class="col-lg-4 col-md-3">
                            <div class="filter__option">
                                <span class="icon_grid-2x2"></span>
                                <span class="icon_ul"></span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="container">
				  <div class="row" id="view"></div>
				</div>
				
          </div>
        <!-- 상품 목록 끝 -->
      </div>
    </div>
</section>
    <!-- Product Section End -->
</body>
</html>