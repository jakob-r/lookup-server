# Helpers

#' Retrieves metadata about the task from openml.org
#'
#' @param task_id `numeric(n)` The task of interest
#'
#' @return nrow and ncol of the dataset.
get_task_dict = function(task_id) {
  # Find row in task_metadata
  this_task_id = task_id
  row = task_metadata[task_id %in% this_task_id, ]

  if (nrow(row) != length(task_id)) {
    stop(sprintf("The task metadata for task %s has %i results!", paste(task_id, collapse = ","), nrow(row)))
  }

  # Return data
  return(list(nrow = row$instances, ncol = row$features - 1))
}

#' This returns the inverse-transformation function specified for this parameter.
#'
#' @param learner_id The algorithm name the parameter belongs to.
#' @param param_name The parameter name.
get_inverse_trafo = function(learner_id, param_name) {
  parameter_ranges[[learner_id]]$pars[[param_name]]$trafo.inverse
}

cleanup_cache_table = function() {
  setkeyv(omlTuneBenchR$cache_table, "last_accessed")
  while (object.size(omlTuneBenchR$cache_table) > omlTuneBenchR$cache_size * 1024^2) {
    omlTuneBenchR$cache_table = omlTuneBenchR$cache_table[-1, ]
  }
}

type_fix = function(x, par.set) {
  # type conversion to make sure (Workaround for https://github.com/berndbischl/ParamHelpers/issues/203)
  par_types = getParamTypes(par.set, with.nr = TRUE, use.names = TRUE, df.cols = TRUE)
  df_types = vapply(x, class, character(1))
  type_misses = df_types == "logical" & par_types[names(df_types)] != df_types
  if (any(type_misses)) {
    for (col in names(type_misses[type_misses])) {
      if (par_types[col] == "factor") { #FIX because as(1, 'factor') is not supported
        x[[col]] = as.factor(x[[col]])
      } else {
        x[[col]] = as(x[[col]], par_types[col])
      }
    }
  }
  return(x)
}