local({
  md_tmp <- tempfile(tmpdir = ".", fileext = ".md")
  on.exit(file.remove(md_tmp))

  cat('---
title: "GitとGitHubとRStudio"
output: html_document
---

## このドキュメントについて
このドキュメントは、「魁!! 広島ベイズ塾 2015夏合宿」のために用意したドキュメントです。

なにかありましたら、[Twitterアカウント](https://twitter.com/kazutan) へメンション、もしくは[このリポジトリ](https://github.com/kazutan/RStudio2Github) のissueまでお願いします。

## Index
', file = md_tmp)

  rmd_pages  <- list.files(pattern = "*.Rmd")
  html_pages <- sub(".Rmd", ".html", rmd_pages)
  mtimes     <- file.mtime(rmd_pages)
  page_list  <- sort(sprintf("* [%s](%s) %s", html_pages, html_pages, mtimes))
  cat(paste0(page_list, collapse = "\n"),
      file = md_tmp, append = TRUE)

  rmarkdown::render(md_tmp, output_file = "index.html")
})
