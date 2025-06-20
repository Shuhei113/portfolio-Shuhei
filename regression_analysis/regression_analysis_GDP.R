####################################
#　　　　　0)下準備         　　　 #
####################################

### 0-1):まず必要なパッケージをダウンロード ###
install.packages("tidyverse")
install.packages("pacman")
install.packages("reshape2")
install.packages("stargazer")
install.packages(c("patchwork", "estimatr", "devtools", "showtext", "DT"))
library(tidyverse)
library(patchwork)
library(devtools)
library(showtext)
library(DT)
library(estimatr)
library(reshape2)
library(ggplot2)
library(stargazer)
pacman::p_load(tidyverse, patchwork, estimatr, devtools, showtext, DT)

### 0-2):ファイルの読み込みをして、dfと名付ける ###
df<-final
glimpse(df) #実験がてら変数が正しく表示されるか確認

### 0-3:)欠損値処理 ###
##まずは処理方法を決める##
na <- sum(rowSums(is.na(df)) > 0) #欠損値を含む行が192行中何行あるか確認
print(na)　#107行が欠損値含む→全て削除はナンセンス

##欠損値を含む行が多い事がわかったので、各列の平均で補う方針に##
columns<- c(
     "agri_land", "agri_emp", "child_mortality", 
    "fertility", "death", "rural_pop", "urban_pop", "total_pop", "pop_growth", 
    "unemp", "diabetes", "refugee", "access_elec", "renewable_20", "co2_20", 
    "pm25_20", "gdp", "export", "import", "high_export", "fuel_export", 
    "gvt_edu", "gv_female", "inflation", "military"
  )
#↑数値データのコラムをまとめた

replace_na_with_mean <- function(df, columns) {
  for (col in columns) {
      mean_value <- mean(df[[col]], na.rm = TRUE)
      df[[col]][is.na(df[[col]])] <- mean_value
  }
  return(df)
}
df <- replace_na_with_mean(df, columns)
print(df) #無事欠損値が各列の平均で補完できていることを確認


### 0-4):図で日本語表記をするための下準備###
theme_set(theme_gray(base_size = 10, base_family = "HiraginoSans-W3"))


####################################
#　　　　　1)理論      　　　      #
####################################

###　1-1:)非説明変数を一人当たりGDP(gdp)に決定　###
##理由: 経済成長に対してどのような要素がプラスorマイナスに影響を与えるのか定量的に分析
##      することで、GDP成長に有効な経済政策を策定できうるから。

###　1-2:)その上で仮説を立てる(IVも決める)  ###
##仮説: 一人当たりGDPは、農村部から都市部へ人口が流入し、産業構造が高度化することで上昇する。
##　　　また、生産活動が活発になると(co2排出量上昇)、GDPが上昇する。
##.     さらに、産業の高度化によりハイテク商品の輸出量が増えると、GDPは増加する。
##　　　よって、IVを農村人口やそれ周りの変数、CO2排出量、ハイテク商品の輸出の3つから選び、
##.     その3つのうち1つ以上選ぶパターン6通りの回帰モデルを作ることにする。

###　1-3:)コントロール変数の決定　###
## コントロール変数とその理由
## PM2.5大気汚染をコントロール変数にする。
## 理由:)co2の排出量増加は、経済活動の活発化とco2排出量の削減能力
##.      の欠如という二つの側面がある。よって、CO2排出量を前者の側面に限定して測るために、
##　　　 後者の側面との正の相関がありそうなPM2.5大気汚染の変数をコントロール変数とする。


####################################
#　　　　　2)記述統計     　　　   #
####################################

###  2-1:)　GDPとの相関係数をその他の変数全てについて調べる. ###
correlations <- sapply(columns, function(col) {
  cor(df[[col]], df$gdp, use = "complete.obs")
})
print(correlations)

## 相関係数をデータフレームに変換
correlation_df <- data.frame(
  Variable = columns,
  Correlation_with_gdp = correlations
)

# pop_growthとの相関係数のデータフレームを作成
correlation_matrix <- matrix(correlations, nrow = 1, dimnames = list("gdp", columns))
correlation_df_long <- melt(correlation_matrix)

###  2-2:)調べた相関係数の大きさをヒートマップで可視化. ###
ggplot(correlation_df_long, aes(x = Var2, y = Var1, fill = value)) +
  geom_tile(color = "white") +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", midpoint = 0, limit = c(-1, 1), space = "Lab", name = "Pearson\nCorrelation") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, size = 12, hjust = 1)) +
  coord_fixed() +
  labs(title = "correlation with gdp", x = "Variables",y="")

###  2-3:)図でXとYの関係を説明(散布図の作成). ###
##. ただし、Yは一人当たりGDP
##　Xは、農業に占める男性の雇用、農村人口、都市人口、CO2排出量、PM2.5大気汚染、ハイテクノロジー商品の輸出

#　農業に占める男性の雇用とGDP
scat1<-ggplot(data=df, aes(x=agri_emp, y=gdp))+
  geom_point()
print(scat1)
#  農村人口とGDP
scat2<-ggplot(data=df, aes(x=rural_pop, y=gdp))+
  geom_point()
print(scat2)
#. 都市人口とGDP
scat3<-ggplot(data=df, aes(x=urban_pop, y=gdp))+
  geom_point()
print(scat3)
#. CO2排出量とGDP
scat4<-ggplot(data=df, aes(x=co2_20, y=gdp))+
  geom_point()
print(scat4)
#. PM2.5大気汚染とGDP
scat5<-ggplot(data=df, aes(x=pm25_20, y=gdp))+
  geom_point()
print(scat5)
#. ハイテクノロジー商品の輸出とGDP
scat6<-ggplot(data=df, aes(x=high_export, y=gdp))+
  geom_point()
print(scat6)

###. 2-4:) 続いて、農業に占める男性の雇用、農村人口、都市人口のどれをXとして採用するかを決定. ###
#まずはそれぞれの相関が強いことを確認。
correlation <- cor(df$agri_emp, df$rural_pop, method = "pearson")
print(correlation)
correlation <- cor(df$rural_pop, df$urban_pop, method = "pearson")
print(correlation)
correlation <- cor(df$urban_pop, df$agri_emp, method = "pearson")
print(correlation)
#考察: 予想通り、農村人口と都市人口の相関係数は-1(定義より明らか)であり、農村人口と
#.    　農業における男性の雇用も強い正の相関がある事がわかった。
#.      このもとで、農業における男性雇用とGDP、農村人口とGDPの相関係数を確認。
correlation <- cor(df$agri_emp, df$gdp, method = "pearson")
print(correlation)
correlation <- cor(df$rural_pop, df$gdp, method = "pearson")
print(correlation)
#考察: GDPとの相関係数はそれぞれ-0.4094482、-0.3896225とほぼ一緒だが前者の方が
#.     相関係数の絶対値はやや大きい。これと、GDPに影響を与えるのは、人口の分布というより
#.     各産業に占める労働者の分布であることを考えると、今回独立変数として採用すべきなのは
#.     農業に占める男性の雇用の方であろう。

###. 2-5:) コントロール変数のPM2.5大気汚染と説明変数のCO2排出量に一定の相関が見られるか確認. ###
# 散布図の表示
scat100<-ggplot(data=df, aes(x=pm25_20, y=co2_20))+
  geom_point()
print(scat100)
# 相関係数の計算
correlation <- cor(df$co2_20, df$pm25_20, method = "pearson")
print(correlation)
# 考察:　co2の排出量とPM2.5大気汚染の相関係数には正の相関は見られず、むしろやや負の相関があった。
#.       これは、co2の排出量においてco2削減能力の有無よりも産業の活発度合いによる影響が大きい
#.       ためと考えられる。

###  2-6:) 全体の変数の表を作成. ###
# 以上により、今回の非説明変数は一人当たりGDP、説明変数は農業における男性の雇用、CO2排出量
# ハイテクノロジー商品の輸出、コントロール変数はPM2.5大気汚染に決定した。
#　これらの計5つの変数のsummaryを表示する。
summary(df$gdp)
summary(df$agri_emp)
summary(df$co2_20)
summary(df$high_export)
summary(df$pm25_20)


####################################
#　　　　　3)回帰分析     　　　   #
####################################

### 3-1:) まずはモデルの構築  ###
pacman::p_load(broom, car, jtools, summarytools, QuantPsyc)

model1 <- lm(gdp ~ agri_emp, data = df) 
model2 <- lm(gdp ~ high_export, data = df)
model3 <- lm(gdp ~ co2_20 + pm25_20, data = df)
model4 <- lm(gdp ~ agri_emp + co2_20 + pm25_20, data = df)
model5 <- lm(gdp ~ agri_emp + high_export, data = df)
model6 <- lm(gdp ~ co2_20 + high_export + pm25_20, data = df)
model7 <- lm(gdp ~ agri_emp + co2_20 + high_export + pm25_20, data = df)
stargazer(model1, model2, model3, model4, model5, model6, model7, type = "text") # 7つのモデルを一括で表示

### 3-2:) 偏回帰係数の検定とそれぞれの解釈  ###

## CO2排出量について ##
# どのモデルでもco2排出量はGDPに対して有意な影響を与えていない事がわかった。
# これは、CO2排出量とGDPの相関係数が約0.05だったことからある程度予想通りの結果だった。
# また、CO2排出量が多くなる要因として、産業が高度化していることと、排出量削減能力が欠如して
# いることがあり、前者はGDPが高くなり、後者はGDPが低くなるので、CO2排出量はGDPとの相関が
# 大きくないのだろうと考えられる。

## PM2.5について ##
# PM2.5大気汚染は、これを説明変数として含む全てのモデルについて有意水準1%で統計的に有意な影響をGDPに
# 及ぼしていることがわかった。PM2.5大気汚染の問題への対応が遅れている国は、経済的に成長しきれていない傾向
# にあり、その結果一人当たりGDPも低くなるのだろうと推察される。

##. ハイテクノロジー商品の輸出について. ##
#　ハイテクノロジー商品の輸出は、モデル2,5,6では有意水準1%で統計的に有意な影響をGDPに与え、
#. モデル7では有意水準5%で有意な影響を与えていることがわかった。産業が高度化し、より高付加価値の商品を
#. 輸出できるような国がGDPも高くなるということだろう。

##　農業における男性の雇用について　##
# モデル1,4,5,7の全てについて、有意水準1%で統計的に有意な影響をあたえていることがわかった。
#　理論パートで立てた仮説の通りだったと考えられる。

### 3-3:) F検定とその解釈  ###
#　モデル1~7の全てについて、p値が0.01未満であるので、これらのモデルは統計的に有意だった。

### 3-4:) adj R2とその解釈  ###
# 自由度調整済み決定係数を見ると、データのバリエーションのうちモデルによって説明できる部分の
#.割合が最も高いのはモデル7で、低いのはハイテクノロジー商品の輸出の単回帰モデルだった。

### 3-5:) 以上の結果と解釈を踏まえて新たなモデルを構築 ###
# 説明変数としていたCO2排出量を削除し、コントロール変数としていたPM2.5大気汚染を説明変数にする。
model8 <- lm(gdp ~ agri_emp, data = df) 
model9 <- lm(gdp ~ high_export, data = df)
model10 <- lm(gdp ~ pm25_20, data = df)
model11 <- lm(gdp ~ agri_emp + pm25_20, data = df)
model12 <- lm(gdp ~ agri_emp + high_export, data = df)
model13 <- lm(gdp ~ high_export + pm25_20, data = df)
model14 <- lm(gdp ~ agri_emp  + high_export + pm25_20, data = df)
stargazer(model8, model9, model10, model11, model12, model3, model14, type = "text")

# 結果、モデル7のハイテクノロジー商品の輸出を除いては、全ての変数について、それがGDPに与える影響は
# 有意水準1%で有意だった。また、F検定の結果、有意水準1パーセントで全てのモデルが統計的に有意だった。
# ただし、決定係数はモデル１〜７とあまり変わらなかった。モデル内におけるCO2排出量の有無は、
# そのモデルで説明できる部分の割合にあまり影響を及ぼさない事がわかった。


####################################
#　　　　　4)回帰診断    　　　    #
####################################

### 4-1:)残差プロット ###
## 残差プロット (model1について)
fit.df <- model1
res.df <- resid(fit.df)   # 残差を取り出す
pred.df <- fitted(fit.df)   # 予測値を取り出す

plot(pred.df, 
     res.df, 
     main = "Residuals vs Fitted",
     xlab = "Fitted Values", 
     ylab = "residuals")
abline(h = 0, col = "red")

## 残差プロット (model2について)
fit.df <- model2
res.df <- resid(fit.df)   # 残差を取り出す
pred.df <- fitted(fit.df)   # 予測値を取り出す

plot(pred.df, 
     res.df, 
     main = "Residuals vs Fitted",
     xlab = "Fitted Values", 
     ylab = "residuals")
abline(h = 0, col = "red")

## 残差プロット (model3について)
fit.df <- model3
res.df <- resid(fit.df)   # 残差を取り出す
pred.df <- fitted(fit.df)   # 予測値を取り出す

plot(pred.df, 
     res.df, 
     main = "Residuals vs Fitted",
     xlab = "Fitted Values", 
     ylab = "residuals")
abline(h = 0, col = "red")

## 残差プロット (model4について)
fit.df <- model4
res.df <- resid(fit.df)   # 残差を取り出す
pred.df <- fitted(fit.df)   # 予測値を取り出す

plot(pred.df, 
     res.df, 
     main = "Residuals vs Fitted",
     xlab = "Fitted Values", 
     ylab = "residuals")
abline(h = 0, col = "red")

## 残差プロット (model5について)
fit.df <- model5
res.df <- resid(fit.df)   # 残差を取り出す
pred.df <- fitted(fit.df)   # 予測値を取り出す

plot(pred.df, 
     res.df, 
     main = "Residuals vs Fitted",
     xlab = "Fitted Values", 
     ylab = "residuals")
abline(h = 0, col = "red")

## 残差プロット (model6について)
fit.df <- model6
res.df <- resid(fit.df)   # 残差を取り出す
pred.df <- fitted(fit.df)   # 予測値を取り出す

plot(pred.df, 
     res.df, 
     main = "Residuals vs Fitted",
     xlab = "Fitted Values", 
     ylab = "residuals")
abline(h = 0, col = "red")

## 残差プロット (model7について)
fit.df <- model7
res.df <- resid(fit.df)   # 残差を取り出す
pred.df <- fitted(fit.df)   # 予測値を取り出す

plot(pred.df, 
     res.df, 
     main = "Residuals vs Fitted",
     xlab = "Fitted Values", 
     ylab = "residuals")
abline(h = 0, col = "red")
  
### 4-2:) 正規QQプロット ###
qqplt<- ggplot(df, aes(sample=res.df))+
  geom_abline(intercept=0, slope=1, linetype="dashed")+　#geom_abline: 図に直線を描き足す（切片0,傾き1）
  geom_qq()+ 　　　##qqプロット
  labs(x="標準正規分布", y="標準化した残差の分布")
print(qqplt)                                   

### 4-3:) VIFの計算 ###
library(car)
vif(model4)
vif(model5)
vif(model6)
vif(model7)