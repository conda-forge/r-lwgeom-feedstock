sed -i -e "s/void R_init_lwgeom/__declspec(dllexport) void R_init_lwgeom/" src/RcppExports.cpp

"%R%" CMD INSTALL --build .
IF %ERRORLEVEL% NEQ 0 exit 1
