$(function () {
    var doc = $('html, body');

    try {
        window.prettyPrint && prettyPrint();

        anchors.add('.bb-examples-list .bb-example');

        Example.init({
            "selector": ".bb-alert"
        });
    }
    catch (ex) {
        console.log(ex.message);
    }

    try {
        $.scrollUp && $.scrollUp({
            scrollName: 'scroll-up-btn',
            animationSpeed: '600',
            scrollText: '<i class="fa fa-4x fa-arrow-circle-up"></i>'
        });
    }
    catch (ex) {
        console.log(ex.message);
    }

    try {
        $(document)
            .on('click', '.dropdown-menu li a[href^="#"]', function (e) {
                e.preventDefault();

                var target = $(this).attr('href');
                var offset = 75;

                if (target && $(target).offset()) {
                    offset = $(target).offset().top - 75;
                }

                doc.animate({
                    scrollTop: offset
                }, 'slow', function () {
                    //window.location.hash = target;
                });
            })
            .off('click', 'a.back-to-top')
            .on('click', 'a.back-to-top', function (e) {
                e.preventDefault();
                doc.animate({ scrollTop: 0 }, 'slow');
            });
    }
    catch (ex) {
        console.log(ex.message);
    }


    try {
        $('.example-button').on('click', function (e) {
            e.preventDefault();

            var key = $(this).data('bb-example-key');
            if ($.trim(key) != "") {
                switch (key) {

                   
                   /* Confirms */

                    case 'confirm-options':
                        bootbox.confirm({
                            message: "You are about to deactivate employee. Are you sure about this?",
                            buttons: {
                                confirm: {
                                    label: 'Yes',
                                    className: 'btn-success'
                                    
                                },
                                cancel: {
                                    label: 'No',
                                    className: 'btn-danger'
                                }
                            },
                            callback: function (result) {
                            	Example.show('Results to deactivate employee: ' + result);
                                location.href = 'http://example.com';
                                
                            }
                        });
                        break;                    
                }
            }
        });
    }
    catch (ex) {
        console.log(ex.message);
    }

});