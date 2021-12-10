# Example Package

This is a simple example package. You can use
[Github-flavored Markdown](https://guides.github.com/features/mastering-markdown/)
to write your content.

TODO:

add uninstall function in this pacakge.

```powershell
PS C:\Users\ziyu4\Documents\proj\study_code_on_github\packaging_tutorial> $env:PYTHONPATH
C:\Users\ziyu4\Documents\proj\study_code_on_github\packaging_tutorial\src;C:\Users\ziyu4\Documents\proj\study_code_on_github\packaging_tutorial\tests;
```

## Env seeting vscode

```json
{

    // how to check $Env:Path.Split(';')
    // https://code.visualstudio.com/docs/editor/integrated-terminal
    "terminal.integrated.profiles.windows": {
        "My PowerShell": {
            "source": "PowerShell",
            "icon": "terminal-powershell",
            "args": ["-NoProfile"],
            // how to check
            // PS > $env:PYTHONPATH
            // C:\Users\ziyu4\Documents\proj\packaging_tutorial\src
            "env": {
                "PATH": "C:\\WPy64-3880\\git\\bin;C:\\WPy64-3880\\python-3.8.8.amd64;C:\\WPy64-3880\\python-3.8.8.amd64\\Scripts",
                "PYTHONPATH": "${workspaceFolder}\\src",
            },
        },
    },
    "terminal.integrated.defaultProfile.windows": "My PowerShell",
    "python.terminal.activateEnvInCurrentTerminal": true,
    "python.defaultInterpreterPath": "C:/WPy64-3880/python-3.8.8.amd64/python.exe"
}
```
