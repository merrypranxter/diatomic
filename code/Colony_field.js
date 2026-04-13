let diatoms = [];

function setup() {
  createCanvas(1000, 1000);
  angleMode(RADIANS);

  for (let i = 0; i < 45; i++) {
    diatoms.push({
      x: random(width),
      y: random(height),
      s: random(20, 110),
      a: random(TWO_PI),
      spin: random(-0.01, 0.01),
      vx: random(-0.25, 0.25),
      vy: random(-0.25, 0.25),
      type: random() < 0.5 ? "centric" : "pennate",
      ribs: floor(random(20, 80)),
      pores: floor(random(6, 24))
    });
  }
}

function draw() {
  background(8, 14, 20, 30);
  fill(6, 10, 18, 40);
  rect(0, 0, width, height);

  blendMode(ADD);

  for (let d of diatoms) {
    d.x += d.vx + 0.15 * noise(frameCount * 0.003, d.y * 0.01) - 0.075;
    d.y += d.vy + 0.15 * noise(frameCount * 0.003, d.x * 0.01) - 0.075;
    d.a += d.spin;

    if (d.x < -120) d.x = width + 120;
    if (d.x > width + 120) d.x = -120;
    if (d.y < -120) d.y = height + 120;
    if (d.y > height + 120) d.y = -120;

    push();
    translate(d.x, d.y);
    rotate(d.a);
    scale(d.s / 100);

    if (d.type === "centric") drawCentric(d.ribs, d.pores);
    else drawPennate(d.ribs, d.pores);

    pop();
  }

  blendMode(BLEND);
}

function drawCentric(ribs, pores) {
  noFill();
  stroke(180, 240, 255, 50);
  strokeWeight(1.4);

  ellipse(0, 0, 90, 90);

  // radial ribs
  for (let i = 0; i < ribs; i++) {
    let a = map(i, 0, ribs, 0, TWO_PI);
    let x1 = cos(a) * 8;
    let y1 = sin(a) * 8;
    let x2 = cos(a) * 42;
    let y2 = sin(a) * 42;
    line(x1, y1, x2, y2);
  }

  // rings
  for (let r = 10; r < 42; r += 8) {
    ellipse(0, 0, r * 2, r * 2);
  }

  // pores
  noStroke();
  fill(180, 240, 255, 40);
  for (let ring = 12; ring < 40; ring += 8) {
    let count = floor(map(ring, 12, 40, 8, pores * 3));
    for (let i = 0; i < count; i++) {
      let a = map(i, 0, count, 0, TWO_PI);
      let x = cos(a) * ring;
      let y = sin(a) * ring;
      circle(x, y, 2.2);
    }
  }
}

function drawPennate(ribs, pores) {
  noFill();
  stroke(180, 240, 255, 55);
  strokeWeight(1.2);

  beginShape();
  for (let i = 0; i <= 100; i++) {
    let t = map(i, 0, 100, -1, 1);
    let x = t * 46;
    let y = sin((1.0 - abs(t)) * PI) * 18;
    vertex(x, y);
  }
  for (let i = 100; i >= 0; i--) {
    let t = map(i, 0, 100, -1, 1);
    let x = t * 46;
    let y = -sin((1.0 - abs(t)) * PI) * 18;
    vertex(x, y);
  }
  endShape(CLOSE);

  // central line
  line(-35, 0, 35, 0);

  // ribs
  for (let i = 0; i < ribs; i++) {
    let x = map(i, 0, ribs - 1, -34, 34);
    let h = sin((1.0 - abs(x) / 34.0) * HALF_PI) * 15;
    line(x, -h, x, h);
  }

  // pores
  noStroke();
  fill(180, 240, 255, 35);
  for (let row = -2; row <= 2; row++) {
    for (let i = 0; i < pores; i++) {
      let x = map(i, 0, pores - 1, -28, 28);
      let h = sin((1.0 - abs(x) / 28.0) * HALF_PI) * 10;
      let y = row * 3.8;
      if (abs(y) < h) circle(x, y, 1.8);
    }
  }
}
