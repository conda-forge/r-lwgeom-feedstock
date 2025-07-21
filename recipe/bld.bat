@echo on

set

sed -i -e "s/void R_init_lwgeom/__declspec(dllexport) void R_init_lwgeom/" src/RcppExports.cpp
IF %ERRORLEVEL% NEQ 0 exit 1

"%R%" CMD INSTALL --build .
IF %ERRORLEVEL% NEQ 0 exit 1
