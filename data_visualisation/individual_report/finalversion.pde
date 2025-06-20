PImage mapImage; // 地図画像

// 緯線・経線の座標リスト
float[] latitudeY;
float[] longitudeX;

Table data; // データを格納するTableオブジェクト
String[] diseases = { "Schizophrenia", "Depressive_disorders", "Anxiety_disorders", "Bipolar_disorder", "Eating_disorders" };
int[] years = { 1990, 2021 };
int currentDiseaseIndex = 0;
int currentYearIndex = 1;

void setup() {
  size(1000, 600); // サイズ調整して色分け表示領域を確保

  // 地図画像を読み込む
  mapImage = loadImage("map.png");

  // 緯線と経線の位置を事前に計算して保存
  calculateInvisibleGrid();

  // CSVファイルを読み込む
  data = loadTable("data.csv", "header");

  textAlign(CENTER, CENTER); // テキストの配置を中央揃え
  textSize(10); // ラベルのフォントサイズ
}

void draw() {
  background(255);

  // 地図画像を描画
  image(mapImage, 0, 0, width, height - 100);

  // 太い緯線と経線を描画
  drawMainLines();

  // data.csvを参照して円をプロット
  plotCapitals();

  // 現在の病気名と年を表示
  displayCurrentSelection();

  // 色分け基準の凡例を表示
  drawColorLegend();
}

// 病気名と年を表示
void displayCurrentSelection() {
  fill(0);
  textSize(16);
  text("Disease: " + diseases[currentDiseaseIndex] + " | Year: " + years[currentYearIndex], width / 2, height - 20);
}

// 色分け基準の凡例を表示
void drawColorLegend() {
  float legendX = 50;
  float legendY = height - 90;
  float legendWidth = 200;
  float legendHeight = 20;

  textSize(12);
  fill(0);
  text("Prevalence Color Scale", legendX + legendWidth / 2, legendY - 10);

  for (float i = 0; i <= 1; i += 0.01) {
    int c = lerpColor(
      lerpColor(color(0, 0, 255), color(0, 255, 0), constrain(i * 3, 0, 1)),
      lerpColor(color(255, 255, 0), color(255, 0, 0), constrain((i - 0.33) * 3, 0, 1)),
      constrain((i - 0.66) * 3, 0, 1)
    );
    stroke(c);
    line(legendX + i * legendWidth, legendY, legendX + i * legendWidth, legendY + legendHeight);
  }

  fill(0);
  textSize(10);
  textAlign(CENTER);
  text("0%", legendX, legendY + legendHeight + 10);
  text("1.4%", legendX + legendWidth / 2, legendY + legendHeight + 10);
  text("3%+", legendX + legendWidth, legendY + legendHeight + 10);
}

// 太い緯線と経線を描画する関数
void drawMainLines() {
  strokeWeight(2);

  // 太い緯線（赤道や15度ごと）を描画
  stroke(255, 0, 0); // 赤い線
  for (int i = 0; i <= 150; i += 15) {
    float y = latitudeY[i]; // 15度ごとの緯度座標
    line(0, y, width, y);
  }

  // 太い経線（15度ごと）を描画
  stroke(0, 0, 255); // 青い線
  for (int i = 0; i <= 360; i += 15) {
    float x = longitudeX[i]; // 15度ごとの経度座標
    line(x, 0, x, height - 100);
  }
}

// 見えない格子（緯線・経線の座標）を計算する関数
void calculateInvisibleGrid() {
  latitudeY = new float[151]; // -75°～75° (151本)
  longitudeX = new float[361]; // -180°～180° (361本)

  // 緯線の座標計算 (-75°から75°まで)
  float equatorY = (height - 100) / 2 + 67;
  float north15Y = equatorY - ((height - 100) / 13);
  float south15Y = equatorY + ((height - 100) / 13.2);
  float north30Y = equatorY - ((height - 100) / 6.5);
  float south30Y = equatorY + ((height - 100) / 6.5);
  float north45Y = equatorY - ((height - 100) / 4.1);
  float south45Y = equatorY + ((height - 100) / 4.1);
  float north60Y = equatorY - ((height - 100) / 2.75);
  float north75Y = equatorY - ((height - 100) / 1.78);

  float[] majorLatitudeY = {
    south45Y, south30Y, south15Y, equatorY, north15Y, north30Y, north45Y, north60Y, north75Y
  };
  int[] majorLatitudeDegrees = {
    -45, -30, -15, 0, 15, 30, 45, 60, 75
  };

  for (int i = 0; i < majorLatitudeY.length - 1; i++) {
    float startY = majorLatitudeY[i];
    float endY = majorLatitudeY[i + 1];
    for (int j = 0; j <= 15; j++) {
      int degree = majorLatitudeDegrees[i] + j;
      latitudeY[degree + 75] = map(j, 0, 15, startY, endY);
    }
  }

  // 経線の座標計算 (-180°から180°まで)
  float west45X = 955;
  float west60X = 913;
  float west75X = 871;
  float west90X = 829;
  float west105X = 788;
  float west120X = 747;
  float west135X = 705;
  float west150X = 664;
  float west165X = 623;
  float ew180X = 582;
  float west15X = 41;
  float longitudeXCoord = 82;
  float east15X = 123;
  float east30X = 164;
  float east45X = 205;
  float east60X = 247;
  float east75X = 289;
  float east90X = 331;
  float east105X = 373;
  float east120X = 415;
  float east135X = 457;
  float east150X = 499;
  float east165X = 541;
  float east180X = 582;

  float[] majorLongitudeX = {
    west45X, west60X, west75X, west90X, west105X, west120X, west135X, west150X, west165X,
    ew180X, west15X, longitudeXCoord, east15X, east30X, east45X, east60X, east75X, east90X,
    east105X, east120X, east135X, east150X, east165X, east180X
  };
  int[] majorLongitudeDegrees = {
    -45, -60, -75, -90, -105, -120, -135, -150, -165, -180, -15, 0, 15, 30, 45, 
    60, 75, 90, 105, 120, 135, 150, 165, 180
  };

  for (int i = 0; i < majorLongitudeX.length - 1; i++) {
    float startX = majorLongitudeX[i];
    float endX = majorLongitudeX[i + 1];
    for (int j = 0; j <= 15; j++) {
      int degree = majorLongitudeDegrees[i] + j;
      longitudeX[degree + 180] = map(j, 0, 15, startX, endX);
    }
  }
}

// data.csvを参照して円をプロットする関数
void plotCapitals() {
  String column = diseases[currentDiseaseIndex] + "_" + years[currentYearIndex];
  for (TableRow row : data.rows()) {
    String country = row.getString("Country");
    float longitude = row.getFloat("Longitude");
    float latitude = row.getFloat("Latitude");
    String prevalenceStr = row.getString(column);
    float prevalence = float(prevalenceStr.replace("%", "")) / 100.0;

    float sizeMultiplier = 8000;
    if (diseases[currentDiseaseIndex].equals("Depressive_disorders") || diseases[currentDiseaseIndex].equals("Anxiety_disorders")) {
      sizeMultiplier = 800;
    } else if (diseases[currentDiseaseIndex].equals("Bipolar_disorder")) {
      sizeMultiplier = 4000;
    }
    float size = prevalence * sizeMultiplier;

    int intLongitude = int(floor(longitude));
    int intLatitude = int(floor(latitude));
    float x = longitudeX[intLongitude + 180];
    float y = latitudeY[intLatitude + 75];

    int c;
    if (prevalence < 0.005) {
      c = lerpColor(color(0, 0, 255), color(0, 255, 0), prevalence / 0.005);
    } else if (prevalence < 0.014) {
      c = lerpColor(color(0, 255, 0), color(255, 255, 0), (prevalence - 0.005) / 0.009);
    } else if (prevalence < 0.025) {
      c = lerpColor(color(255, 255, 0), color(255, 165, 0), (prevalence - 0.014) / 0.011);
    } else {
      c = lerpColor(color(255, 165, 0), color(255, 0, 0), (prevalence - 0.025) / 0.025);
    }
    fill(c, 150);
    noStroke();
    ellipse(x, y, size, size);

    if (dist(mouseX, mouseY, x, y) <= size / 2) {
      fill(255);
      stroke(0);
      rect(mouseX + 10, mouseY - 30, 120, 40);
      fill(0);
      textAlign(LEFT);
      text(country + "\n" + nf(prevalence * 100, 0, 2) + "%", mouseX + 15, mouseY - 20);
    }
  }
}

// キー入力で病気や年を切り替え
void keyPressed() {
  if (key == 'd') { // 次の病気
    currentDiseaseIndex = (currentDiseaseIndex + 1) % diseases.length;
  } else if (key == 'y') { // 次の年
    currentYearIndex = (currentYearIndex + 1) % years.length;
  }
}
