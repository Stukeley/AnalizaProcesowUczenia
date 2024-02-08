# Autor: Rafal Klinowski, wariant: 1.

setwd('C:\\Users\\klino\\Pulpit\\Studia magisterskie\\APU\\Lab5')

# Instalacja mlr
install.packages("mlr")
library(mlr)


# Zadanie 1.
# Dataset: iris
library(datasets)

# Zaladowanie danych 'iris'
data(iris)

# Utworzenie klasyfikatora na podstawie gatunku 'species'
iris_task <- makeClassifTask(data = iris, target = "Species")

# Podzial danych na set treningowy i testowy (70% / 30%)
indices <- sample(1:nrow(iris), size = nrow(iris), replace = FALSE)
train_ratio <- 0.7
train_size <- floor(train_ratio * nrow(iris))
train_data <- iris[indices[1:train_size], ]
test_data <- iris[indices[(train_size + 1):nrow(iris)], ]

# Jakie sa dostepne learnery
# [1] "classif"    "cluster"    "multilabel" "regr"       "surv"      
levels(factor(listLearners()$type))

# Utworzenie learnera i trening
learner <- makeLearner("classif.rpart")
model <- train(learner, iris_task)

# Ocena jakosci modelu
predictions <- predict(model, newdata = test_data)

performance <- performance(predictions, measures = list(acc))
print(performance)

summary(model)

# Wykres
library(rpart.plot)
rpart.plot(getLearnerModel(model))

# Reguły klasyfikacyjne
ruleModel <- C5.0(Species ~ ., data=train_data, rules=TRUE)
ruleModel
summary(ruleModel)

# Zadanie 2.
smartfony <- read.csv('smartfony.csv')
smartfony_reduced <- smartfony[,
          c('pamiec_ram', 'pamiec_wbudowana', 'aparat_foto', 'cena', 'oceny_klientow')]

# Utworzenie klasyfikatora
smartfony_task <- makeClassifTask(data = smartfony_reduced, target = "oceny_klientow")

# Stworzenie 5 learnerow
install.packages("rFerns")
install.packages("randomForest")

lrns <- makeLearners(c("lda","rpart", "C50","rFerns",
                       "randomForest"), type = "classif")

porownanie <- benchmark(learners = lrns,
                        tasks = smartfony_task,
                        resampling = cv5)

# Wizualizacja oceny
learner <- c("lda", "rpart", "C50", "rFerns", "randomForest")
accuracy <- c(0.267, 0.2, 0.2, 0.867, 0.267)

data <- data.frame(learner, accuracy)

barplot(data$accuracy, names.arg = data$learner, ylim = c(0, 1), ylab = "Accuracy")

# Utworzenie finalnego modelu
smartfony_task <- makeClassifTask(data = smartfony_reduced, target = "oceny_klientow")

smartfony_train <- smartfony_reduced[1:12, ]
smartfony_test <- smartfony_reduced[13:15, ]

smartfony_learner <- makeLearner("classif.rFerns")
smartfony_model <- train(smartfony_learner, smartfony_task)

smartfony_predictions <- predict(smartfony_model, newdata = smartfony_test)

performance <- performance(smartfony_predictions, measures = list(acc))
print(performance)