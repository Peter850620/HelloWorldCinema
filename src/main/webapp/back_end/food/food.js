document.getElementById('statusFilter').addEventListener('change', function() {
        var selectedStatus = this.value;
        var rows = document.querySelectorAll('.foodStatusRow');

        rows.forEach(function(row) {
            // 如果選擇的是「全部」，顯示所有行
            if (selectedStatus === 'all') {
                row.style.display = 'table-row';
            } else {
                // 否則，根據選擇的值顯示或隱藏行
                var foodStatus = row.querySelector('td:nth-child(7)').textContent;
                if (foodStatus === selectedStatus) {
                    row.style.display = 'table-row';
                } else {
                    row.style.display = 'none';
                }
            }
        });
    });