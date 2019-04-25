
# =====================================================
# Devtools workflow
library(devtools)
# =====================================================

document()          # generate documentation
check_man()         # check documentation
test()              # run tests
build_vignettes()   # build vignettes
build()             # build bundle
install()           # install package
