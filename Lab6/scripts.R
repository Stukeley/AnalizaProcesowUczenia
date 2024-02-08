# Autor: Rafal Klinowski, wariant: 1.

setwd('C:\\Users\\klino\\Pulpit\\Studia magisterskie\\APU\\Lab6')

# Instalacja TensorFlow
install.packages("tensorflow")
library(tensorflow)
install_tensorflow()

# Instalacja Keras
install.packages("keras")
library(keras)
install_keras()

# Pobranie danych wejsciowych
library(keras)
cifar <- dataset_cifar10()
X_train <- cifar$train$x
X_test <- cifar$test$x
y_train <- cifar$train$y
y_test <- cifar$test$y

# Konwersja wartosci pikseli do zakresu [0, 1]
# Liczba klas = 10
X_train <- X_train / 255
X_test <- X_test / 255

# Konwersja etykiet na kategorie
y_train <- to_categorical(y_train, num_classes = 10)
y_test <- to_categorical(y_test, num_classes = 10)

# Tworzenie modelu zgodnie z instrukcja laboratoryjna
model <- keras_model_sequential()

model <- model %>%
  layer_dense(units = 256, activation = "relu", input_shape = c(32,32,3)) %>%
  layer_dropout(rate = 0.25) %>%
  layer_dense(units = 128, activation = "relu") %>%
  layer_dropout(rate = 0.25) %>%
  layer_dense(units = 64, activation = "relu") %>%
  layer_dropout(rate = 0.25) %>%
  layer_flatten(input_shape = c(32,32,3)) %>%
  layer_dense(units = 10, activation = 'softmax')

# Kompilowanie modelu
model %>% compile(
  loss = "categorical_crossentropy",
  optimizer = optimizer_adam(),
  metrics = "accuracy"
)

# Informacje o modelu
summary(model)

# Trenowanie modelu
# epochs=10 by zaoszczedzic czas (trenowanie trwa bardzo dlugo)
history <- model %>%
  fit(X_train, y_train, epochs = 10, batch_size = 32,
      validation_data = list(X_test,y_test), shuffle=TRUE)

# Ocena modelu
model %>%
  evaluate(X_test, y_test)

# Zapisanie do pliku
save_model_tf(model, "saved_model/model")
