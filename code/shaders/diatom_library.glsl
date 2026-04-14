// ===========================================================================
// DIATOMIC SHADER LIBRARY
// Collection of parametric diatom generators for GLSL
// ===========================================================================

// ---------------------------------------------------------------------------
// UTILITY FUNCTIONS
// ---------------------------------------------------------------------------

float hash21(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453123);
}

mat2 rot(float a) {
    float s = sin(a), c = cos(a);
    return mat2(c, -s, s, c);
}

float sdCircle(vec2 p, float r) {
    return length(p) - r;
}

float sdEllipse(vec2 p, vec2 ab) {
    p = abs(p);
    if (p.x > p.y) { p = p.yx; ab = ab.yx; }
    float l = ab.y * ab.y - ab.x * ab.x;
    float m = ab.x * p.x / l;
    float n = ab.y * p.y / l;
    float m2 = m * m;
    float n2 = n * n;
    float c = (m2 + n2 - 1.0) / 3.0;
    float d = c * c * c + m2 * n2;
    d = sqrt(abs(d));
    float q = d + m2 * n2;
    q = pow(q, 1.0/3.0);
    float g = sqrt(0.5 * (q + c) + 0.5 * (q - c));
    return length(p - ab * vec2(g, sqrt(abs(1.0 - g * g))));
}

float sdBox(vec2 p, vec2 b) {
    vec2 d = abs(p) - b;
    return length(max(d, 0.0)) + min(max(d.x, d.y), 0.0);
}

float sdRoundedBox(vec2 p, vec2 b, float r) {
    vec2 q = abs(p) - b + r;
    return length(max(q, 0.0)) + min(max(q.x, q.y), 0.0) - r;
}

float sdVesica(vec2 p, float r, float d) {
    p = abs(p);
    float b = sqrt(r*r - d*d);
    return ((p.y - b)*d > p.x*b) 
        ? length(p - vec2(0.0, b)) 
        : length(p - vec2(-d, 0.0)) - r;
}

// ---------------------------------------------------------------------------
// PATTERN GENERATORS
// ---------------------------------------------------------------------------

float ring(float d, float w) {
    return 1.0 - smoothstep(0.0, w, abs(d));
}

float radialStriae(vec2 p, float freq, float sharpness) {
    float a = atan(p.y, p.x);
    return pow(abs(sin(a * freq)), sharpness);
}

float radialDivisions(vec2 p, float n, float width) {
    float a = atan(p.y, p.x);
    float sector = a / (6.2831 / n);
    float d = abs(fract(sector) - 0.5) * 2.0;
    return smoothstep(1.0 - width, 1.0, d);
}

float concentricBands(vec2 p, float freq, float sharpness) {
    float r = length(p);
    return pow(abs(sin(r * freq)), sharpness);
}

float poreField(vec2 p, float scale, float size) {
    vec2 gp = p * scale;
    vec2 id = floor(gp);
    vec2 f = fract(gp) - 0.5;
    
    float rnd = hash21(id);
    f *= rot(rnd * 6.2831);
    
    float d = length(f);
    return 1.0 - smoothstep(size, size + 0.03, d);
}

float hexPoreField(vec2 p, float scale, float size) {
    // Hexagonal tiling
    const vec2 s = vec2(1.0, 1.732);
    vec2 gp = p * scale;
    
    vec4 hC = floor(vec4(gp, gp - vec2(0.5, 1.0)) / s.xyxy) + 0.5;
    vec4 h = vec4(gp - hC.xy * s, gp - (hC.zw + 0.5) * s);
    
    vec2 pq = (dot(h.xy, h.xy) < dot(h.zw, h.zw)) ? h.xy : h.zw;
    
    float d = length(pq);
    return 1.0 - smoothstep(size, size + 0.02, d);
}

float centralRosette(vec2 p, float petals, float sharpness, float radius) {
    float r = length(p);
    if (r > radius) return 0.0;
    
    float a = atan(p.y, p.x);
    float petal = abs(sin(a * petals));
    return pow(petal, sharpness) * (1.0 - r / radius);
}

// ---------------------------------------------------------------------------
// DIATOM TYPE: CENTRIC DISC (Cyclotella-style)
// ---------------------------------------------------------------------------

vec3 centric_disc_radiate(vec2 uv, float time) {
    // Main body
    float body = 1.0 - smoothstep(0.0, 0.01, sdCircle(uv, 0.42));
    
    // Edge shell
    float edge = ring(sdCircle(uv, 0.42), 0.008);
    
    // Radial striae - fine radiating lines
    float striae = radialStriae(uv, 48.0, 7.0);
    striae *= smoothstep(0.03, 0.35, length(uv));
    
    // Nested concentric bands
    float bands = concentricBands(uv, 95.0, 12.0);
    
    // Pore field
    float pores = poreField(uv, 38.0, 0.14);
    pores *= smoothstep(0.08, 0.38, length(uv));
    
    // Central rosette
    float rosette = centralRosette(uv * rot(time * 0.1), 12.0, 10.0, 0.12);
    
    // Combine ornaments
    float ornament = 0.0;
    ornament += 0.35 * striae;
    ornament += 0.25 * bands;
    ornament += 0.7 * pores;
    ornament += 0.5 * rosette;
    ornament *= body;
    
    // Material
    float r = length(uv);
    float glow = exp(-18.0 * abs(sdCircle(uv, 0.42)));
    
    vec3 base = vec3(0.03, 0.08, 0.12);
    vec3 silica = vec3(0.72, 0.92, 0.97);
    vec3 iridescent = vec3(
        0.35 + 0.35 * sin(time + r * 18.0),
        0.45 + 0.35 * sin(time + r * 18.0 + 2.0),
        0.55 + 0.35 * sin(time + r * 18.0 + 4.0)
    );
    
    vec3 col = base;
    col += body * 0.12 * silica;
    col += ornament * mix(silica, iridescent, 0.25);
    col += edge * 0.8 * silica;
    col += glow * 0.25 * iridescent;
    
    return col;
}

// ---------------------------------------------------------------------------
// DIATOM TYPE: CENTRIC POLYGONAL (Triceratium-style triangular)
// ---------------------------------------------------------------------------

vec3 centric_polygonal_triangle(vec2 uv, float time) {
    // Triangular body approximation
    float a = atan(uv.y, uv.x) + time * 0.1;
    float r = length(uv);
    float tri = cos(floor(0.5 + a * 1.5 / 3.14159) * 3.14159 * 2.0 / 3.0 - a) * r;
    
    float body = 1.0 - smoothstep(0.38, 0.40, tri);
    float edge = ring(tri, 0.012);
    
    // Radial divisions from corners
    float divisions = radialDivisions(uv, 3.0, 0.08);
    divisions *= body;
    
    // Concentric from center
    float bands = concentricBands(uv, 60.0, 8.0);
    bands *= body;
    
    // Hexagonal pore field
    float pores = hexPoreField(uv, 25.0, 0.12);
    pores *= smoothstep(0.05, 0.35, r) * body;
    
    // Corner ornaments
    float corners = 0.0;
    for (int i = 0; i < 3; i++) {
        float angle = float(i) * 2.094 + time * 0.1;
        vec2 corner = vec2(cos(angle), sin(angle)) * 0.32;
        float d = length(uv - corner);
        corners += exp(-d * 25.0);
    }
    
    // Combine
    vec3 base = vec3(0.02, 0.05, 0.08);
    vec3 silica = vec3(0.75, 0.88, 0.95);
    vec3 accent = vec3(0.6, 0.9, 0.95);
    
    vec3 col = base;
    col += body * 0.1 * silica;
    col += divisions * 0.4 * accent;
    col += bands * 0.3 * silica;
    col += pores * 0.6 * accent;
    col += edge * 0.9 * silica;
    col += corners * 0.3 * vec3(0.5, 0.85, 1.0);
    
    return col;
}

// ---------------------------------------------------------------------------
// DIATOM TYPE: PENNATE NAVICULOID (boat-shaped, bilaterally symmetric)
// ---------------------------------------------------------------------------

vec3 pennate_naviculoid_boat(vec2 uv, float time) {
    // Elongated ellipse outline
    float body = 1.0 - smoothstep(0.0, 0.01, sdEllipse(uv, vec2(0.15, 0.42)));
    float edge = ring(sdEllipse(uv, vec2(0.15, 0.42)), 0.008);
    
    // Central raphe (slit)
    float raphe = 1.0 - smoothstep(0.0, 0.003, abs(uv.x));
    raphe *= smoothstep(0.45, 0.40, abs(uv.y));
    
    // Central nodule
    float centralnodule = exp(-length(uv) * 35.0);
    
    // Polar nodules
    float polarnodules = exp(-length(uv - vec2(0.0, 0.38)) * 40.0);
    polarnodules += exp(-length(uv + vec2(0.0, 0.38)) * 40.0);
    
    // Transverse striae (ribs perpendicular to long axis)
    float striae = abs(sin(uv.y * 120.0));
    striae = pow(striae, 8.0);
    striae *= smoothstep(0.01, 0.14, abs(uv.x));
    striae *= body;
    
    // Fine pore rows along striae
    vec2 gp = vec2(uv.x * 60.0, uv.y * 120.0);
    vec2 id = floor(gp);
    vec2 f = fract(gp) - 0.5;
    float pores = 1.0 - smoothstep(0.15, 0.17, length(f));
    pores *= body;
    
    // Material
    vec3 base = vec3(0.02, 0.06, 0.10);
    vec3 silica = vec3(0.70, 0.85, 0.92);
    vec3 warm = vec3(0.85, 0.75, 0.65);
    
    vec3 col = base;
    col += body * 0.08 * silica;
    col += striae * 0.5 * mix(silica, warm, 0.3);
    col += pores * 0.4 * silica;
    col += raphe * 0.6 * vec3(0.3, 0.5, 0.7);
    col += centralnodule * 0.5 * warm;
    col += polarnodules * 0.4 * warm;
    col += edge * 0.8 * silica;
    
    return col;
}

// ---------------------------------------------------------------------------
// DIATOM TYPE: PENNATE SIGMOID (S-curved)
// ---------------------------------------------------------------------------

vec3 pennate_sigmoid(vec2 uv, float time) {
    // S-curve transformation
    float curve = sin(uv.y * 3.14159) * 0.15;
    vec2 p = vec2(uv.x - curve, uv.y);
    
    // Body
    float body = 1.0 - smoothstep(0.0, 0.01, sdEllipse(p, vec2(0.08, 0.45)));
    float edge = ring(sdEllipse(p, vec2(0.08, 0.45)), 0.006);
    
    // Raphe following the curve
    float raphe = 1.0 - smoothstep(0.0, 0.002, abs(p.x));
    raphe *= body;
    
    // Transverse striae with slight tilt
    float tilt = p.y * 0.3;
    vec2 striaP = p * rot(tilt);
    float striae = abs(sin(striaP.y * 140.0));
    striae = pow(striae, 6.0);
    striae *= smoothstep(0.005, 0.07, abs(p.x));
    striae *= body;
    
    // Pore pattern
    float pores = poreField(p, 50.0, 0.08);
    pores *= body;
    
    // Material - emphasize the curve
    float curveHighlight = exp(-abs(curve) * 20.0);
    
    vec3 base = vec3(0.03, 0.04, 0.08);
    vec3 silica = vec3(0.68, 0.82, 0.90);
    vec3 blue = vec3(0.4, 0.7, 0.9);
    
    vec3 col = base;
    col += body * 0.1 * silica;
    col += striae * 0.4 * silica;
    col += pores * 0.5 * blue;
    col += raphe * 0.7 * vec3(0.5, 0.6, 0.8);
    col += edge * 0.9 * silica;
    col += curveHighlight * 0.2 * blue;
    
    return col;
}

// ---------------------------------------------------------------------------
// DIATOM TYPE: PENNATE CYMBELLOID (banana/crescent shaped)
// ---------------------------------------------------------------------------

vec3 pennate_cymbelloid(vec2 uv, float time) {
    // Asymmetric curve (dorsal-ventral)
    float dorsalCurve = uv.y * uv.y * 0.12;
    vec2 p = vec2(uv.x + dorsalCurve, uv.y);
    
    // Body
    float body = 1.0 - smoothstep(0.0, 0.01, sdEllipse(p, vec2(0.12, 0.40)));
    float edge = ring(sdEllipse(p, vec2(0.12, 0.40)), 0.007);
    
    // Eccentric raphe (off-center)
    float rapheOffset = dorsalCurve * 0.5;
    float raphe = 1.0 - smoothstep(0.0, 0.003, abs(p.x - rapheOffset));
    raphe *= body;
    
    // Asymmetric striae
    float striae = abs(sin(p.y * 100.0 + p.x * 20.0));
    striae = pow(striae, 7.0);
    striae *= body;
    
    // Fibulae (support ribs on ventral side)
    float fibulae = step(0.95, abs(sin(p.y * 25.0))) * step(p.x, 0.0);
    fibulae *= body;
    
    // Pores
    float pores = poreField(p, 45.0, 0.09);
    pores *= body;
    
    vec3 base = vec3(0.02, 0.05, 0.07);
    vec3 silica = vec3(0.72, 0.86, 0.91);
    vec3 accent = vec3(0.85, 0.78, 0.68);
    
    vec3 col = base;
    col += body * 0.09 * silica;
    col += striae * 0.45 * silica;
    col += pores * 0.5 * accent;
    col += raphe * 0.6 * vec3(0.4, 0.6, 0.75);
    col += fibulae * 0.7 * accent;
    col += edge * 0.85 * silica;
    
    return col;
}

// ---------------------------------------------------------------------------
// DIATOM TYPE: CENTRIC STELLATE (star-shaped with processes)
// ---------------------------------------------------------------------------

vec3 centric_stellate(vec2 uv, float time) {
    float r = length(uv);
    float a = atan(uv.y, uv.x) + time * 0.05;
    
    // Central disc
    float disc = 1.0 - smoothstep(0.18, 0.20, r);
    
    // Radiating processes (arms)
    float nArms = 8.0;
    float armAngle = mod(a * nArms / (2.0 * 3.14159), 1.0);
    float arm = smoothstep(0.4, 0.0, abs(armAngle - 0.5));
    arm *= smoothstep(0.5, 0.2, r);
    arm *= step(0.15, r); // Don't overlap disc
    
    // Processes have spines
    float spines = abs(sin(r * 80.0));
    spines = pow(spines, 6.0);
    spines *= arm;
    
    // Central pore pattern
    float pores = hexPoreField(uv, 35.0, 0.11);
    pores *= disc;
    
    // Radial ribs on disc
    float ribs = radialStriae(uv, 32.0, 8.0);
    ribs *= disc;
    
    vec3 base = vec3(0.01, 0.03, 0.06);
    vec3 silica = vec3(0.76, 0.88, 0.94);
    vec3 gold = vec3(0.9, 0.8, 0.5);
    
    vec3 col = base;
    col += disc * 0.12 * silica;
    col += arm * 0.7 * silica;
    col += spines * 0.5 * gold;
    col += pores * 0.6 * vec3(0.6, 0.85, 0.95);
    col += ribs * 0.3 * silica;
    
    return col;
}

// ---------------------------------------------------------------------------
// DIATOM TYPE: PENNATE RIBBON (colony chain form)
// ---------------------------------------------------------------------------

vec3 pennate_ribbon_colony(vec2 uv, float time) {
    // Repeating cells in a chain
    float cellSpacing = 0.5;
    float cellY = mod(uv.y + time * 0.05, cellSpacing) - cellSpacing * 0.5;
    vec2 cellUV = vec2(uv.x, cellY);
    
    // Individual cell
    float body = 1.0 - smoothstep(0.0, 0.01, sdEllipse(cellUV, vec2(0.18, 0.22)));
    float edge = ring(sdEllipse(cellUV, vec2(0.18, 0.22)), 0.006);
    
    // Girdle bands (connecting regions)
    float girdle = step(abs(cellY), 0.02) * step(abs(uv.x), 0.18);
    
    // Transverse striae
    float striae = abs(sin(cellY * 180.0));
    striae = pow(striae, 5.0);
    striae *= body;
    
    // Central raphe
    float raphe = 1.0 - smoothstep(0.0, 0.002, abs(cellUV.x));
    raphe *= body;
    
    // Pores
    float pores = poreField(cellUV, 55.0, 0.07);
    pores *= body;
    
    vec3 base = vec3(0.02, 0.04, 0.06);
    vec3 silica = vec3(0.70, 0.84, 0.90);
    vec3 link = vec3(0.5, 0.7, 0.8);
    
    vec3 col = base;
    col += body * 0.1 * silica;
    col += striae * 0.4 * silica;
    col += pores * 0.5 * vec3(0.6, 0.8, 0.9);
    col += raphe * 0.5 * vec3(0.4, 0.6, 0.75);
    col += girdle * 0.6 * link;
    col += edge * 0.8 * silica;
    
    return col;
}

// ===========================================================================
// END SHADER LIBRARY
// ===========================================================================
