


$(document).ready(function(){
    $('#screenId').change(function(){
        var screenId = $(this).val();
        $.ajax({
            type: "GET",
            url: "/getPriceAndDeposit",
            data: {
                screenId: screenId
            },
            success: function(data){
                $('#price').val(data.price);
                $('#deposit').val(data.deposit);
                $('#total').val(data.total);
            },
            error: function(xhr, status, error) {
                console.error(xhr.responseText);
            }
        });
    });
});

