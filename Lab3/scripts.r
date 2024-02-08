# Autor: Rafal Klinowski, wariant: 1.

setwd('C:\\Users\\klino\\Pulpit\\Studia magisterskie\\APU\\Lab3')

# Instalacja pakietu neuralnet
install.packages('neuralnet')
library('neuralnet')

# Zadanie 1.
# Funkcja: f(x) = x^3 + 2x, x < [1; 100]

# Wczytanie wczesniej utworzonego pliku z danymi
dane <- read.csv('dane1.csv')

# Bez normalizacji
# scaled <- dane

# Normalizacja min-max
normalize <- function(x) {
  return ((x-min(x)) / (max(x) - min(x)))
}

scaled <- as.data.frame(lapply(dane, normalize))

# Normalizacja
# scaled <- scale(dane)

# Podzial danych na set treningowy i walidacyjny
trainset <- scaled[1:80, ]
testset <- scaled[81:100, ]

# Utworzenie sieci neuronowej
# wyjscie ~ wejscie1 + wejscie2 + ...
# Testowane wartości hidden: od 5 do 15, oraz c(2,1), c(2,2), c(5,5)
# Najlepsze wyniki dla hidden=10
nn <- neuralnet(Output ~ Input, data=trainset, hidden=10, threshold=0.01, linear.output=TRUE)

print(nn)
#plot(nn)

results <- compute(nn, testset)

ls(results)
comparison <- data.frame(actual=testset[,2], prediction=results$net.result)
comparison

# Zadanie 2.

# Wczytanie pliku zawierajacego dane o smartfonach z Lab1.
smartfony <- read.csv('smartfony.csv')

# Wybor tylko interesujacych nas kolumn
smartfony_reduced <- smartfony[, c('pamiec_ram', 'pamiec_wbudowana', 'aparat_foto', 'cena')]

# Normalizacja danych
smartfony_scaled <- as.data.frame(lapply(smartfony_reduced, normalize))

smartfony_train <- smartfony_scaled
smartfony_test <- smartfony_scaled[1:3, ]

# Stworzenie modelu
# hidden=c(3,2)
smartfony_nn <- neuralnet(cena ~ pamiec_ram + pamiec_wbudowana + aparat_foto, data=smartfony_train,
                          hidden=c(3,2), threshold=0.01)

print(smartfony_nn)
plot(smartfony_nn)

smartfony_results <- compute(smartfony_nn, smartfony_test)

ls(smartfony_results)
smartfony_comparison <- data.frame(actual=smartfony_test[,c('cena')], prediction=smartfony_results$net.result)
smartfony_comparison
