usethis::edit_r_environ()
Sys.getenv("GITHUB_PAT")
## Register for a token under 'settings' in Github. Once token acquired, -->
-- The “.Renviron” file is a hidden file in your home directory. 
You can load and edit it with a function from the {usethis} package. At a console prompt, type usethis::edit_r_environ(). 
Your “.Renviron” file open up in the RStudio editor. Add your the GITHUB_PAT=YOUR_TOKEN line as above, save and c
lose the file. Be sure to put a line break at the end!
-- Restart R (Session > Restart R in the RStudio menu bar), as environment variables are loaded from “.Renviron” 
only at the start of an R session. Check that the PAT is now available: Sys.getenv("GITHUB_PAT"). You should see 
your PAT print to screen.
