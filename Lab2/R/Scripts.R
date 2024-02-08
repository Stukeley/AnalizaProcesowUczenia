# Autor: Rafal Klinowski, wariant 1.

setwd("C:\\Users\\klino\\Pulpit\\Studia magisterskie\\APU\\Lab2")

# Zaladowanie danych
smartfony <- read.csv(file='smartfony.csv')
smartfony

# AHP z GitHuba
install.packages("devtools")
install.packages("githubinstall")

devtools::install_github("gluc/ahp", build_vignettes = TRUE)

library(ahp)

# Stworzenie drugiego datasetu z uwzglednieniem tylko istotnych parametrow
# Istotne parametry: wyswietlacz, pamiec RAM, pamiec wbudowana, aparat foto, cena.

smartfony_reduced <- smartfony[, c("nazwy", "pamiec_ram", "pamiec_wbudowana",
                                   "aparat_foto", "cena")]

write.csv(smartfony_reduced, file='smartfony_reduced.csv')

# Zaladowanie przygotowanego pliku zawierajacego AHP
# file.show("plik.ahp")

ahpTree <- Load("plik2.ahp")

# Przeliczenie modelu
Calculate(ahpTree)

Visualize(ahpTree)
# Error in node$parent$priority[, node$name] : subscript out of bounds