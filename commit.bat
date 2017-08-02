@echo off
git add .
set /P comment=comment:
git commit -m %comment%
git push
pause