window.onload = function () {
        var quantitySelects = document.querySelectorAll('.form-control');

        quantitySelects.forEach(function (select) {
            select.addEventListener('change', function () {
                var quantity = parseInt(this.value, 10); // 將數量解析為整數
                var price = parseInt(this.parentElement.previousElementSibling.textContent.replace(/[^\d.-]/g, ''), 10); // 將價格解析為整數

                var total = quantity * price;

                // 檢查 total 是否為 NaN，如果是，設置為 0
                if (isNaN(total)) {
                    total = 0;
                }

                var totalElementId = this.id.replace('-quantity', '-total');
                document.getElementById(totalElementId).textContent = total;
            });
        });
    };