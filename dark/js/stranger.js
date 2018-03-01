var canvas;
var ctx;
var img;
var mouseX = 0;
var weight = 30;
var direction = 1;

function start() {
  canvas = document.getElementById('dark');
  ctx = canvas.getContext('2d');
  load();
}

function load() {
  img = new Image();
  img.addEventListener('load', init, false);
  img.src = 'img/st.jpg';
}

function init() {
  window.addEventListener('resize', resize, false);
  // canvas.addEventListener('mousemove', move);
  window.requestAnimationFrame(animate);
  resize();
}

function resize() {
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
  draw(); 
}

function animate() {
  mouseX += 0.003 * direction;
  if (mouseX >= 1) direction = -1;
  else if (mouseX <= 0) direction = 1;
  draw();
  window.requestAnimationFrame(animate);
}

function move(e) {
  mouseX = (e.clientX / canvas.width);
  draw();
}

function draw() {
  var w = canvas.width / 3;
  ctx.clearRect(0,0, canvas.width, canvas.height);
  drawImage(false, 0, 0, w, canvas.height);
  drawImage(true, w, 0, w, canvas.height);
  drawImage(false, w*2, 0, w, canvas.height);
}

function drawImage(flip, x, y, w, h) {
  ctx.save();

  var hW = w / 2;
  var hH = h / 2;
  var sourceRect = getSourceRect(w, h);
 
  ctx.translate(x, y);
  ctx.translate(hW, hH);
  ctx.scale(flip ? -1 : 1, 1);

  var scaleFactor = weight / img.naturalWidth;

  var stepX = img.naturalWidth * scaleFactor;
  var stepY = img.naturalHeight * scaleFactor;

  ctx.drawImage(
    img,
    sourceRect.x + stepX - (mouseX * weight),
    sourceRect.y + stepY,
    sourceRect.w - stepX,
    sourceRect.h - stepY,
    -hW,
    -hH,
    w,
    h,
  );

  ctx.restore();
}

function getSourceRect(srcW, srcH) {
  var destW = img.naturalWidth;
  var destH = img.naturalHeight;

  var scale = Math.min(destW / srcW, destH / srcH);

  var scaledSrcW = srcW * scale;
  var scaledSrcH = srcH * scale;

  var startX = (destW - scaledSrcW) * 0.5;
  var startY = (destH - scaledSrcH) * 0.5;
  return {
    x: startX,
    y: startY,
    w: scaledSrcW,
    h: scaledSrcH,
  };
}
