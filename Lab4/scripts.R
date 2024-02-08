# Autor: Rafal Klinowski, wariant: 1.

setwd('C:\\Users\\klino\\Pulpit\\Studia magisterskie\\APU\\Lab4')

# Zaladowanie danych o smartfonach (z lab1).
smartfony <- read.csv('smartfony.csv')

# Instalacja pakietu C50.
install.packages("C50")
library(C50)

# Konwersja wyjscia z drzewa (ocen klientow) na typ factor.
smartfony$oceny_klientow <- as.factor(smartfony$oceny_klientow)

# Stworzenie drzewa - prognozujemy oceny na podstawie innych wartosci.
tree <- C5.0(smartfony[, c('pamiec_ram', 'pamiec_wbudowana', 'aparat_foto', 'cena')],
             smartfony[, 'oceny_klientow'])

# Wizualizacja drzewa.
plot(tree)

# Dane o drzewie.
summary(tree)

# -----------------------------
# Powtorzenie powyzszego z podzialem na zbior treningowy i testowy.
# W celu ewaluacji drzewa.

smartfony_train <- smartfony[1:12,]
smartfony_test <- smartfony[13:15,]

vars <- c('pamiec_ram', 'pamiec_wbudowana', 'aparat_foto', 'cena')

tree <- C5.0(x=smartfony_train[, vars],
             y=smartfony_train$oceny_klientow)


summary(tree)

plot(tree)

# Predykcja dla danych testowych.
predict(tree, newdata = smartfony_test[, vars], type="prob")
