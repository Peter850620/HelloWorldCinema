function toggleSeatStatus(checkbox) {
    let status = checkbox.dataset.status; // 獲取當前狀態
    if (status === 'Y') {
        checkbox.dataset.status = 'N'; // 如果是可預訂，改為已預訂
        checkbox.checked = true;
    } else if (status === 'N') {
        checkbox.dataset.status = 'Y'; // 如果是已預訂，改為可預訂
        checkbox.checked = false;
    } else if (status === 'F') {
        checkbox.disabled = true; // 維修中的座位不可選
    }
}

function generateSeatString() {
    const seats = document.querySelectorAll('.seat input[type="checkbox"]');
    let seatString = '';
    seats.forEach(seat => {
        seatString += seat.id + seat.dataset.status; // 生成字串，如A01Y或A01N
    });
    return seatString;
}

function saveToLocalStorage() {
    const seatString = generateSeatString();
    localStorage.setItem('seatSelection', seatString); // 存儲到LocalStorage
    console.log('Saved seats: ', seatString);
}

function updateSelectedCount() {
    let selectedCount = document.querySelectorAll('.seats input[type="checkbox"]:checked').length;
    document.getElementById('selectedCount').textContent = selectedCount;
}

document.addEventListener('DOMContentLoaded', function() {
    fetchSeatsStatus();
    document.querySelectorAll('.seats input[type="checkbox"]').forEach(checkbox => {
        checkbox.addEventListener('click', function() {
            if (this.dataset.status !== 'F') {
                toggleSeatStatus(this); // 切換座位狀態
                updateSelectedCount(); // 更新已選座位數量
            }
        });
    });

    const nextButton = document.getElementById('nextButton');
    nextButton.addEventListener('click', saveToLocalStorage); // 點擊時保存座位狀態
});

function fetchSeatsStatus() {
    fetch('/api/showtime?showtimeId=1')
        .then(response => response.json())
        .then(data => {
            applySeatStatus(data.seatStatus);
        }).catch(error => console.error('Error fetching seat status:', error));
}

function applySeatStatus(seatStatus) {
    const seatPattern = /(\w{3})(\w)/g;
    let match;
    while ((match = seatPattern.exec(seatStatus)) !== null) {
        const seatId = match[1];
        const status = match[2];
        const seatCheckbox = document.getElementById(seatId);
        if (seatCheckbox) {
            seatCheckbox.dataset.status = status;
            if (status === 'F') {
                seatCheckbox.disabled = true;
                seatCheckbox.checked = false;
            } else {
                seatCheckbox.disabled = false;
                seatCheckbox.checked = status === 'N';
            }
        }
    }
}
