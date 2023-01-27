#' This package will create a function called create_project()
#'
#' It's callback is at: inst/rstudio/templates/project/create_project.dcf
#'
#' @export

create_project <-
  function(path, ...) {

    # Create the project path given the name chosen by the user:
    dir.create(path, recursive = TRUE, showWarnings = FALSE)

    # Change the working directory to the recently created folder:
    setwd(file.path(getwd(), path))

    # Collect the list of inputs in a list to be called later:
    dots <- list(...)

    # Check .gitignore argument
    if(dots[["createGitignore"]]) {
      git_ignores <-
        c(
          '.Rhistory',
          '.Rapp.history',
          '.RData',
          '.Ruserdata',
          '.Rproj.user/',
          '.Renviron'
        )

      writeLines(paste(git_ignores, sep = '\n'), '.gitignore')
    }

    # Check selected folder
    if(dots[["createDefaultFolders"]]) {
      dir.create("code", recursive = TRUE, showWarnings = FALSE)
      dir.create("data", recursive = TRUE, showWarnings = FALSE)
      dir.create("output", recursive = TRUE, showWarnings = FALSE)
    }

    if(dots[["createREADME"]]) {
      readme <- c(
        '# Project Name',
        '',
        '',
        '## Description',
        '---',
        'Project description...',
        '',
        '',
        '## Files',
        '---',
        '',
        ''
      )

      writeLines(paste(readme, sep = '\n'), 'README.md')

    }

    if(dots[["createDependencies"]]) {
      dependencies <-
        c(
          'library(tidyverse)',
          'library(lubridate)',
          'library(readxl)',
          'library(cowplot)',
          'library(oqthemes)',
          'library(here)'
        )

      writeLines(paste(dependencies, sep = '\n'), 'code/00_dependencies.R')

      first_script <-
        c(
          'source("code/00_dependencies.R")',
          '',
          ''
        )
      writeLines(paste(first_script, sep = '\n'), 'code/03_analyze.R')
    }
  }
