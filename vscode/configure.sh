#!/usr/bin/env bash

CODE_BIN="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
"$CODE_BIN" -v > /dev/null

"$CODE_BIN" --install-extension ms-vscode.cpptools
"$CODE_BIN" --install-extension ms-python.python
"$CODE_BIN" --install-extension msjsdiag.debugger-for-chrome
"$CODE_BIN" --install-extension flowtype.flow-for-vscode

