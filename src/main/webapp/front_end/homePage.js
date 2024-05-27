// 消息輪播
$(function(){
    $('.your-class').slick({
        arrows: true,
        dots: true,
        centerMode: true,
        centerPadding: "60px",
        slidesToShow: 1,
        responsive: [
            {
                breakpoint: 768,
                settings: {
                    arrows: true,
                    dots: true,
                    centerMode: true,
                    centerPadding: "60px",
                    slidesToShow: 1,  
                }
            }
        ]
    });
});




// 電影輪播
$(function() {
    new Swiper(".swiper-container", {
    
        //默认功能属性
        speed: 250,
        slidesPerView: 5,
        spaceBetween: 0,
        slidesPerGroup: 1,
        loop: true,
        autoplay: true,
        
        //分页索引
        pagination: {
            el: ".swiper-pagination",
            clickable: true
        },
        
        //分页按钮
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev"
        }

    });
})