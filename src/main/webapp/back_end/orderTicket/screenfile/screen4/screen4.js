function countseat() {
    //初始0個座位
    let count = 0;

    //找到有幾排
    var rowseat = document.querySelectorAll('.seats');

    //每排有幾個checkbox, 有幾個是已經checked的然後更新初始座位數量
    rowseat.forEach(seat => {
        let checkboxes = seat.querySelectorAll('input[type="checkbox"]');
        checkboxes.forEach(checkbox => {
            if (checkbox.checked) {
                count++;
            }
        });
    });
    return count;
};


   //當載入時,查看有幾個checkbox 被點擊過 然後更新P標籤內容
document.addEventListener('DOMContentLoaded', function () {
    // Call updateSelectedCount function when any checkbox is clicked
    document.querySelectorAll('.seats input[type="checkbox"]').forEach(checkbox => {
        checkbox.addEventListener('click', function () {
            updateSelectedCount();
        });
    });
});



 //更新P標籤的功能
function updateSelectedCount() {
    let howmanyseat = countseat();
    document.getElementById('selectedCount').textContent = howmanyseat;
}