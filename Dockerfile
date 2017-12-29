FROM microsoft/windowsservercore

ADD https://dist.nuget.org/win-x86-commandline/v4.1.0/nuget.exe c:\\dev\\tools\\nuget.exe

ADD https://aka.ms/vs/15/release/vs_buildtools.exe c:\\tmp\\vs_buildtools.exe

RUN setx /m PATH "%PATH%;C:\dev\tools" \
 && c:\tmp\vs_buildtools.exe --quiet --wait --norestart --nocache --all \
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10240 \
    --remove Microsoft.VisualStudio.Component.Windows10SDK.10586 \
    --remove Microsoft.VisualStudio.Component.Windows10SDK.14393 \
    --remove Microsoft.VisualStudio.Component.Windows81SDK \
 || IF "%ERRORLEVEL%"=="3010" EXIT 0

WORKDIR "c:\dev"

ENV VS2017_ROOT "C:\Program Files (x86)\Microsoft Visual Studio\2017"
COPY "entrypoint.bat" "c:\dev\tools"


# Start developer command prompt with any other commands specified.
ENTRYPOINT c:\dev\tools\entrypoint.bat
