// 載入動畫
const canvas = document.querySelector("canvas");
const ctx = canvas.getContext("2d");
const colors = [
"#b4b2b5",
"#dfd73f",
"#6ed2dc",
"#66cf5d",
"#c542cb",
"#d0535e",
"#3733c9"
];
let linePos = 0,
rAF;

canvas.width = innerWidth;
canvas.height = innerHeight;

function texts(color) {
ctx.font = "20vh Bungee Outline";
ctx.shadowBlur = 30;
ctx.shadowColor = color;
ctx.fillStyle = color;
ctx.setTransform(1, -0.15, 0, 1, 0, -10);
ctx.fillText("世 界 影 城", innerWidth / 2, innerHeight / 2 - 5);

ctx.fillStyle = "white";
ctx.shadowBlur = 30;
ctx.shadowColor = color;
ctx.fillText("世 界 影 城", innerWidth / 2, innerHeight / 2);

ctx.font = "18vh Bungee Inline";
ctx.shadowBlur = 30;
ctx.shadowColor = color;
ctx.fillStyle = "#fff";
ctx.setTransform(1, -0.15, 0, 1, 0, -10);
ctx.fillText(
    "Loading...",
    innerWidth / 2,
    innerHeight / 2 + innerHeight / 10
);

ctx.textAlign = "center";
ctx.textBaseline = "middle";
}

function glitch() {
rAF = window.requestAnimationFrame(glitch);

ctx.fillStyle = "#1a191c";
ctx.fillRect(0, 0, innerWidth, innerHeight);

texts(colors[Math.floor(Math.random() * 7)]);
ctx.shadowBlur = 0;
ctx.shadowColor = "none";
ctx.setTransform(1, 0, 0, 1, 0, 0);

for (let i = 0; i < 1000; i++) {
    ctx.fillStyle = `rgba(255, 255, 255, ${Math.random() * 0.01})`;
    ctx.fillRect(
    Math.floor(Math.random() * innerWidth),
    Math.floor(Math.random() * innerHeight),
    Math.floor(Math.random() * 30) + 1,
    Math.floor(Math.random() * 30) + 1
    );

    ctx.fillStyle = `rgba(0,0,0,${Math.random() * 0.1})`;
    ctx.fillRect(
    Math.floor(Math.random() * innerWidth),
    Math.floor(Math.random() * innerHeight),
    Math.floor(Math.random() * 25) + 1,
    Math.floor(Math.random() * 25) + 1
    );
}

ctx.fillStyle = colors[Math.floor(Math.random() * 40)];
ctx.fillRect(
    Math.random() * innerWidth,
    Math.random() * innerHeight,
    Math.random() * innerWidth,
    Math.random() * innerHeight
);
ctx.setTransform(1, 0, 0, .8, .2, 0);
}

glitch();

window.addEventListener('resize', () => {
canvas.width = innerWidth;
canvas.height = innerHeight;
});

window.addEventListener('load', () => {
    canvas.style.display = 'none'; // 加载完成后隐藏加载画面
    document.body.classList.remove('loading'); // 隐藏加载状态
});

// 當頁面載入時顯示載入狀態
document.body.classList.add('loading');







