
/* Loader Code Start */
jQuery(window).load(function () {
    "use strict";
    jQuery(".section-loader").fadeOut("slow");
});
/* Loader Code End */


$(function () {
    "use strict";

    /* All owlCarousel Script Code Start */
    if (jQuery().owlCarousel) {
        /* Home Page Banner Slider Script Code Start */
        if (jQuery(".slideshow").length) {
            $('.slideshow').owlCarousel({
                items: 1,
                autoplay: 1000,
                singleItem: true,
                navigation: false,
                pagination: false,
                dots: false,
                animateOut: 'fadeOut',
                loop: true
            });
        }
        /* Home Page Banner Slider Script Code End */

        /* Home Page 2 Banner Slider Script Code Start */
        if (jQuery(".slideshow2").length) {
            $('.slideshow2').owlCarousel({
                items: 1,
                autoplay: 1000,
                singleItem: true,
                nav: false,
                pagination: false,
                dots: false,
                animateOut: 'fadeOut',
                loop: true,
                navText: ["<i class='fa fa-angle-left'>", "<i class='fa fa-angle-right'>"],
                responsive: {
                    768: {
                        nav: true
                    },
                }
            });
        }
        /* Home Page 2 Banner Slider Script Code End */

        /* Blog Post Slider Script Code Start */
        if (jQuery("#post-list").length) {
            jQuery("#post-list").owlCarousel({
                loop: true,
                margin: 20,
                responsiveClass: true,
                autoplay: true,
                autoplayTimeout: 5000,
                navigation: false,
                stopOnHover: true,
                responsive: {
                    0: {
                        items: 1,
                        loop: true
                    },
                    600: {
                        items: 2,
                        loop: true
                    },
                    1000: {
                        items: 3,
                        loop: true
                    }
                }
            });
        }
        /* Blog Post Slider Script Code End */

        /* Image Gallery Slider Script Code Start */
        if (jQuery("#image-gallery").length) {
            $('#image-gallery').owlCarousel({
                items: 1,
                autoplay: 1000,
                singleItem: true,
                navigation: true,
                pagination: true,
                dots: true,
                animateOut: 'fadeOut',
                loop: true

            });
        }
        /* Image Gallery Slider Script Code End */

        /* Hotel Details Slider Script Code Start */
        if (jQuery("#hotel-details").length) {
            $('#hotel-details').owlCarousel({
                items: 1,
                autoplay: 1000,
                singleItem: true,
                nav: false,
                pagination: true,
                dots: false,
                animateOut: 'fadeOut',
                loop: true,
                thumbs: true,
                thumbsPrerendered: true,
                navText: ["<i class='fa fa-angle-left'>", "<i class='fa fa-angle-right'>"],
                responsive: {
                    768: {
                        nav: true
                    },
                }
            });
        }
        /* Hotel Details Slider Script Code End */

        /* Tesimonials Slider Script Code Start */
        if (jQuery("#tesimonials").length) {
            jQuery("#tesimonials").owlCarousel({
                loop: true,
                margin: 10,
                responsiveClass: true,
                autoplay: true,
                autoplayTimeout: 5000,
                navigation: false,
                stopOnHover: true,
                responsive: {
                    0: {
                        items: 1,
                        loop: true
                    },
                    600: {
                        items: 2,
                        loop: true
                    },
                    1000: {
                        items: 3,
                        loop: true
                    }
                }
            });
        }
        /* Tesimonials Slider Script Code End */

        /* Three Col Slider Script Code Start */
        if (jQuery(".three-col-owl").length) {
            jQuery(".three-col-owl").owlCarousel({
                loop: true,
                margin: 20,
                responsiveClass: true,
                autoplay: true,
                autoplayTimeout: 5000,
                navigation: false,
                stopOnHover: true,
                responsive: {
                    0: {
                        items: 1,
                        loop: true
                    },
                    600: {
                        items: 2,
                        loop: true
                    },
                    1000: {
                        items: 3,
                        loop: true
                    }
                }
            });
        }
        /* Three Col Slider Script Code End */

        /* Two Col Slider Script Code Start */
        if (jQuery(".two-col-owl").length) {
            jQuery(".two-col-owl").owlCarousel({
                loop: true,
                margin: 20,
                responsiveClass: true,
                autoplay: true,
                autoplayTimeout: 5000,
                navigation: false,
                stopOnHover: true,
                responsive: {
                    0: {
                        items: 1,
                        loop: true
                    },
                    600: {
                        items: 1,
                        loop: true
                    },
                    1000: {
                        items: 2,
                        loop: true
                    }
                }
            });
        }
        /* Two Col Slider Script Code End */


        /* One Col Slider Script Code Start */
        if (jQuery(".one-col-owl").length) {
            jQuery(".one-col-owl").owlCarousel({
                loop: true,
                margin: 20,
                items: 1,
                singleItem: true,
                responsiveClass: true,
                autoplay: true,
                autoplayTimeout: 5000,
                navigation: false,
                stopOnHover: true
            });
        }
        /* One Col Slider Script Code End */
    }
    /* All owlCarousel Script Code End */

    /* Top Arrow init Code Start */
    if (jQuery(window).width() > 768) {
        loadscroler();
    }
    /* Top Arrow init Code End */

    /* Sticky header Start */
    $(window).on('scroll', function (e) {
        if ($(window).width() > 767) {
            if ($(window).scrollTop() >= 30) {
                $('.header-2 header').addClass('fixed-header');
            } else {
                $('.header-2 header').removeClass('fixed-header');
            }
        }
    });
    /* Sticky header End */

    /* WOW Animation init Code Start */
    if (jQuery(window).width() > 768) {
        new WOW({
            offset: 100, // default
            mobile: false // default
        }).init();
    }
    /* WOW Animation init Code End */

    /* Nice Select Code Start */
    $("select").niceSelect();
    /* Nice Select Code End */

    /* Datepicker init Code Start */
    $("#check_out").datepicker({minDate: -0, maxDate: "+3M", dateFormat: 'dd/mm/yy'});
    $("#check_in").datepicker({minDate: -0, maxDate: "+3M", dateFormat: 'dd/mm/yy'});
    $("#package_start").datepicker({minDate: -0, maxDate: "+3M", dateFormat: 'dd/mm/yy'});
    $(".datepicker").datepicker({minDate: -0, maxDate: "+3M", dateFormat: 'dd/mm/yy'});
    /* Datepicker init Code End */
    $(".timepicker").timepicker({
        icons: {
            up: "fa fa-chevron-up",
            down: "fa fa-chevron-down"
        }
    });
    /* Spinner init Code Start */
    $("#adult_count").spinner({
        min: 1
    });
    $("#child_count").spinner({
        min: 1
    });
    $("#hotel_adult_count").spinner({
        min: 1
    });
    $("#hotel_child_count").spinner({
        min: 1
    });
    /* Spinner init Code End */

    /* Price Range Code Start */
    $("#price-range").slider({
        range: true,
        min: 0,
        max: 3999,
        values: [0, 3999],
        slide: function (event, ui) {
            $("#amount").text("$ " + ui.values[0] + " - $ " + ui.values[1]);
        }
    });
    $("#amount").text("$ " + $("#price-range").slider("values", 0) + " - $ " + $("#price-range").slider("values", 1));
    /* Price Range Code End */


});

/*Function for Add Go to up arrow Start */
function loadscroler() {
    $('body').prepend('<a href="#" class="bottom-top"><i class="fa fa-angle-double-up"></i></a>');
    var amountScrolled = 300;
    $(window).on('scroll', function () {
        if ($(window).scrollTop() > amountScrolled) {
            $('a.bottom-top').fadeIn('slow');
        } else {
            $('a.bottom-top').fadeOut('slow');
        }
    });
    $('a.bottom-top').on('click', function () {
        $('html, body').animate({
            scrollTop: 0
        }, 700);
        return false;
    });
}
/*Function for Add Go to up arrow End */


	  