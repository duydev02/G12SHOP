/*  ---------------------------------------------------
    Template Name: Ogani
    Description:  Ogani eCommerce  HTML Template
    Author: Colorlib
    Author URI: https://colorlib.com
    Version: 1.0
    Created: Colorlib
---------------------------------------------------------  */

'use strict';

(function ($) {

    /*------------------
        Preloader
    --------------------*/
    $(window).on('load', function () {
        $(".loader").fadeOut();
        $("#preloder").delay(200).fadeOut("slow");

        /*------------------
            Gallery filter
        --------------------*/
        $('.featured__controls li').on('click', function () {
            $('.featured__controls li').removeClass('active');
            $(this).addClass('active');
        });
        if ($('.featured__filter').length > 0) {
            var containerEl = document.querySelector('.featured__filter');
            var mixer = mixitup(containerEl);
        }
    });

    /*------------------
        Background Set
    --------------------*/
    $('.set-bg').each(function () {
        var bg = $(this).data('setbg');
        $(this).css('background-image', 'url(' + bg + ')');
    });

    //Humberger Menu
    $(".humberger__open").on('click', function () {
        $(".humberger__menu__wrapper").addClass("show__humberger__menu__wrapper");
        $(".humberger__menu__overlay").addClass("active");
        $("body").addClass("over_hid");
    });

    $(".humberger__menu__overlay").on('click', function () {
        $(".humberger__menu__wrapper").removeClass("show__humberger__menu__wrapper");
        $(".humberger__menu__overlay").removeClass("active");
        $("body").removeClass("over_hid");
    });

    /*------------------
		Navigation
	--------------------*/
    $(".mobile-menu").slicknav({
        prependTo: '#mobile-menu-wrap',
        allowParentLinks: true
    });

    /*-----------------------
        Categories Slider
    ------------------------*/
    $(".categories__slider").owlCarousel({
        loop: true,
        margin: 0,
        items: 4,
        dots: false,
        nav: true,
        navText: ["<span class='fa fa-angle-left'><span/>", "<span class='fa fa-angle-right'><span/>"],
        animateOut: 'fadeOut',
        animateIn: 'fadeIn',
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true,
        responsive: {

            0: {
                items: 1,
            },

            480: {
                items: 2,
            },

            768: {
                items: 3,
            },

            992: {
                items: 4,
            }
        }
    });


    $('.hero__categories__all').on('click', function(){
        $('.hero__categories ul').slideToggle(400);
    });

    /*--------------------------
        Latest Product Slider
    ----------------------------*/
    $(".latest-product__slider").owlCarousel({
        loop: true,
        margin: 0,
        items: 1,
        dots: false,
        nav: true,
        navText: ["<span class='fa fa-angle-left'><span/>", "<span class='fa fa-angle-right'><span/>"],
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true
    });

    /*-----------------------------
        Product Discount Slider
    -------------------------------*/
    $(".product__discount__slider").owlCarousel({
        loop: true,
        margin: 0,
        items: 3,
        dots: true,
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true,
        responsive: {

            320: {
                items: 1,
            },

            480: {
                items: 2,
            },

            768: {
                items: 2,
            },

            992: {
                items: 3,
            }
        }
    });

    /*---------------------------------
        Product Details Pic Slider
    ----------------------------------*/
    $(".product__details__pic__slider").owlCarousel({
        loop: true,
        margin: 20,
        items: 4,
        dots: true,
        smartSpeed: 1200,
        autoHeight: false,
        autoplay: true
    });

    /*-----------------------
		Price Range Slider
	------------------------ */
    var rangeSlider = $(".price-range"),
        minamount = $("#minamount"),
        maxamount = $("#maxamount"),
        minPrice = rangeSlider.data('min'),
        maxPrice = rangeSlider.data('max');
    rangeSlider.slider({
        range: true,
        min: minPrice,
        max: maxPrice,
        values: [minPrice, maxPrice],
        slide: function (event, ui) {
            minamount.val('$' + ui.values[0]);
            maxamount.val('$' + ui.values[1]);
        }
    });
    minamount.val('$' + rangeSlider.slider("values", 0));
    maxamount.val('$' + rangeSlider.slider("values", 1));

    /*--------------------------
        Select
    ----------------------------*/
    $("select").niceSelect();

    /*------------------
		Single Product
	--------------------*/
    $('.product__details__pic__slider img').on('click', function () {

        var imgurl = $(this).data('imgbigurl');
        var bigImg = $('.product__details__pic__item--large').attr('src');
        if (imgurl != bigImg) {
            $('.product__details__pic__item--large').attr({
                src: imgurl
            });
        }
    });

    /*-------------------
		Quantity change
	--------------------- */
    /*var proQty = $('.pro-qty');
    proQty.prepend('<span class="dec qtybtn">-</span>');
    proQty.append('<span class="inc qtybtn">+</span>');
    proQty.on('click', '.qtybtn', function () {
        var $button = $(this);
        var oldValue = $button.parent().find('input').val();
        if ($button.hasClass('inc')) {
            var newVal = parseFloat(oldValue) + 1;
        } else {
            // Don't allow decrementing below zero
            if (oldValue > 0) {
                var newVal = parseFloat(oldValue) - 1;
            } else {
                newVal = 0;
            }
        }
        $button.parent().find('input').val(newVal);
    });*/

})(jQuery);

// Chuyen den trang chi tiet sp
function shopDetailPage(productSlug) {
	location.href = "/shop-details/" + productSlug;
}

// Tim kiem khi input 'Tim kiem' co su thay doi
$("#search").click(function() {
	var searchValue = $('#searchValue').val();
	location.href = "search?key=" + searchValue;
});

// Tim kiem khi nhan Enter trong khi dang focus input 'Tim kiem'
$("#searchValue").keypress(function(e) {
	if(e.which == 13) {
		var searchValue = $('#searchValue').val();
		location.href = "search?key=" + searchValue;
    }
});

// Chuyen trang kem theo 'tu khoa tim kiem' (neu co)
function isSearchedPage(pageNumber) {
	var url_string = window.location.href;
	var url = new URL(url_string);
	if (document.URL.indexOf('shop-grid') != -1) {
		var key = url.searchParams.get("key");
		location.href = "shop-grid?&page=" + pageNumber;
	} else if (document.URL.indexOf('search') != -1) {
		var key = url.searchParams.get("key");
		location.href = "search?key=" + key + "&page=" + pageNumber;
	}
}

// Ngan event click icon cua sp thi chuyen den trang chi tiet sp
$(".product__item__pic__hover li a, .featured__item__pic__hover li a").click(function(event) {
	event.stopPropagation();
});

// Them san pham voi so luong 1 vao gio hang
function addToCart(productId) {
	var endpoint = '/api/cart/update?productId=' + productId + '&quantity=1&isReplace=false';
	$.ajax({
		url: endpoint,
		type: 'GET',
		dataType: 'json',
		success: function (data) {
			$('.headerTotalPrice').text(numberWithDot(data.totalPrice));
			$('.headerTotalQuantity').text(data.totalQuantity);
		},
		error: function () {
			alert('Kh??ng th??? th??m s???n ph???m v??o gi??? h??ng, h??y th??? l???i!');
		}
	})
}

// Xoa san pham khoi gio hang
function removeProduct(productId) {
	var url = '/cart/update?productId=' + productId + '&quantity=0&isReplace=true';
	// bien isReplace khong co y nghia gi khi thuc hien hanh dong DELETE product
	$.get(url).done(function (data) {
		$('#viewCartFragment').replaceWith(data);
		callApiRefreshCart();
	});
}

// Cap nhat so luong san pham trong gio hang
function updateProduct(productId) {
	var idInput = '#quantity' + productId;
	var newQuantity = $(idInput).val();
	var url = '/cart/update?productId=' + productId + '&quantity=' + newQuantity +'&isReplace=true';
	$.get(url).done(function (data) {
		$('#viewCartFragment').replaceWith(data)
		callApiRefreshCart();
	});
}
   
function decQtybtn (productId) {
	var idInput = '#quantity' + productId;
	$(idInput).val($(idInput).val() - 1);
	var newQuantity = $(idInput).val();
	var url = '/cart/update?productId=' + productId + '&quantity=' + newQuantity +'&isReplace=true';
	$.get(url).done(function (data) {
		$('#viewCartFragment').replaceWith(data)
		callApiRefreshCart();
	});
}
   
function incQtybtn (productId) {
	var idInput = '#quantity' + productId;
	$(idInput).val($(idInput).val() - (-1));
	var newQuantity = $(idInput).val();
	var url = '/cart/update?productId=' + productId + '&quantity=' + newQuantity +'&isReplace=true';
	$.get(url).done(function (data) {
		$('#viewCartFragment').replaceWith(data)
		callApiRefreshCart();
	});
}

function decQtybtnShopdetail() {
	var idInput = '#shop-detail-quantity';
	var quantity = $(idInput).val();
	if (quantity > 1) {
		$(idInput).val(quantity - 1);
	}
}

function incQtybtnShopdetail(maxQuantity) {
	var idInput = '#shop-detail-quantity';
	var quantity = $(idInput).val();
	if (quantity < parseInt(maxQuantity)) {
		$(idInput).val(quantity - (-1));
	}
}

function addToCartByProducts(productId) {
	var idInput = '#shop-detail-quantity';
	var quantity = $(idInput).val();
	var endpoint = '/api/cart/update?productId=' + productId + '&quantity=' + quantity + '&isReplace=false';
	$.ajax({
		url: endpoint,
		type: 'GET',
		dataType: 'json',
		success: function (data) {
			$(idInput).val(1);
			$('.headerTotalPrice').text(numberWithDot(data.totalPrice));
			$('.headerTotalQuantity').text(data.totalQuantity);
		},
		error: function () {
			alert('Kh??ng th??? th??m s???n ph???m v??o gi??? h??ng, h??y th??? l???i!');
		}
	})
}

function callApiRefreshCart() {
	$.ajax({
		url: '/api/cart/refresh',
		type: 'GET',
		dataType: 'json',
		success: function (data) {
			$('.headerTotalPrice').text(numberWithDot(data.totalPrice));
			$('.headerTotalQuantity').text(data.totalQuantity);
		},
		error: function () {
			
		}
	})
}

// Format currency data
function numberWithDot(x) {
	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + ' ??';
}

function checkout() {
	var phone = $('#phone').val();
	var address = $('#address').val();
	var check = true;
	if (phone == null || phone == "") {
		$('#error-phone').text("Kh??ng ???????c ????? tr???ng");
		check = false;
	} else {
		$('#error-phone').text("");
	}
	if (address == null || address == "") {
		$('#error-address').text("Kh??ng ???????c ????? tr???ng");
		check = false;
	} else {
		$('#error-address').text("");
	}
	
	if (check) {
		var endpoint = '/api/cart/checkout?address=' + address + '&phone=' + phone;
	
		$.ajax({
			url: endpoint,
			type: 'GET',
			statusCode: {
				200: handle200,
				400: handle400,
				401: handle401,
				412: handle412
			}
		});
	}
}

function handle200() {
	alert('Thanh to??n c???a b???n ???????c t???o th??nh c??ng');
	window.location.href = '/index';
}

function handle400() {
	alert('Thanh to??n l???i, h??y th??? l???i')
}

function handle401() {
	alert('H??y ????ng nh???p tr?????c khi thanh to??n');
	window.location.href = '/login';
}

function handle412() {
	alert('S??? l?????ng s???n ph???m mu???n mua ph???i nh??? h??n s??? l?????ng c?? trong kho');
}