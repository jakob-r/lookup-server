context("makeOmlBenchFunction")

test_that("simple: kknn", {

  lrn.str = "classif.kknn"
  task_id = 3
  of = make_omlbenchfunction(lrn.str, task_id)
  expect_class(of, "smoof_function")
  par.set = getParamSet(of)
  expect_true(hasFiniteBoxConstraints(par.set))

  x = sampleValue(par.set)
  res = of(x)
  
  expect_numeric(res)
})


test_that("complex: randomForest", {

  lrn.str = "classif.ranger"
  task_id = 3
  of = make_omlbenchfunction(lrn.str, task_id, include.extras = TRUE)
  expect_class(of, "smoof_function")
  par.set = getParamSet(of)
  expect_true(hasFiniteBoxConstraints(par.set))

  x = sampleValue(par.set)
  res = of(x)
  expect_numeric(res)
  expect_list(attr(res, "extras"), names = "named")

})

test_that("on specific value with trafos works", {
  # this is not necessary elegant
  # but if this fails we see that something is broken majorily
  of = make_omlbenchfunction("classif.svm", 3, include.extras = TRUE)
  x = list(kernel = "radial", cost = 4.643833, gamma = -6.928392, degree = NA_integer_)
  res = of(x)
  expect_equal(attr(res,"extras")$.lookup.rid, 2127568)
  expect_equal(as.numeric(res), 0.963079)

  x = list(kernel = "radial", cost = 4.643833, gamma = -6.928392, degree = NA)
  res = of(x)
  expect_equal(attr(res,"extras")$.lookup.rid, 2127568)

  x = list(kernel = "radial", cost = 4.643833, gamma = -6.928392)
  res = of(x)
  expect_equal(attr(res,"extras")$.lookup.rid, 2127568)

  x = list(gamma = -6.928392, degree = NA, kernel = "radial", cost = 4.643833)
  res = of(x)
  expect_equal(attr(res,"extras")$.lookup.rid, 2127568)
})
