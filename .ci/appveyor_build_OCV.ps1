#SCRIPT CONSTANTS
$pwd = Get-Location
$OPENCV_DIR = "$pwd\install\opencv";
$OPENCV_VERSION_TAG = "3.4.0"
$CMAKE_CONFIG_GENERATOR = "Visual Studio 15 2017 Win64"
$CMAKE_OPTIONS = @(
  "-DWITH_CUDA:BOOL=ON",
  "-DCUDA_ARCH_BIN=5.2",
  "-DCUDA_ARCH_PTX=",
  "-DBUILD_opencv_java:BOOL=OFF",
  "-DBUILD_opencv_python:BOOL=OFF",
  "-DBUILD_opencv_python2:BOOL=OFF",
  "-DBUILD_opencv_python3:BOOL=OFF",
  "-DBUILD_TESTS:BOOL=OFF",
  "-DBUILD_PERF_TESTS:BOOL=OFF",
  "-DBUILD_DOCS:BOOL=OFF",
  "-DBUILD_EXAMPLES:BOOL=OFF",
  "-DINSTALL_CREATE_DISTRIB:BOOL=ON"
)
$INSTALL_LOCATION = "$pwd\install\opencv"
$REPO_LOCATION = "$pwd\opencv"

#SCRIPT BODY
Write-Host "CONFIGURE OPENCV PATHS"

$env:OPENCV_DIR = $OPENCV_DIR
$env:OPENCV_LIB = "$OPENCV_DIR\x64\vc15\lib"
if ($env:Path.IndexOf(";$OPENCV_DIR\x64\vc15\bin") -eq (-1)) {
	$env:Path += ";$OPENCV_DIR\x64\vc15\bin"
}
[Environment]::SetEnvironmentVariable("OPENCV_DIR", $env:OPENCV_DIR, [EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("OPENCV_LIB", $env:OPENCV_LIB, [EnvironmentVariableTarget]::Machine)
[Environment]::SetEnvironmentVariable("Path", $env:Path, [EnvironmentVariableTarget]::Machine)

if (Test-Path "$OPENCV_DIR\x64\vc15\bin") {
	Write-Host "Compiled OpenCV found. Skip installation"
	return;
}
Write-Host "INSTALL OPENCV AT $INSTALL_LOCATION"

mkdir build\opencv -ErrorAction SilentlyContinue
mkdir install\opencv -ErrorAction SilentlyContinue

$oldErrorAction = $ErrorActionPreference
$ErrorActionPreference = "SilentlyContinue"
git clone -b $OPENCV_VERSION_TAG --depth 1 https://github.com/opencv/opencv.git
$ErrorActionPreference = $oldErrorAction

Push-Location -Path "build\opencv"
Write-Host "cmake -G $CMAKE_CONFIG_GENERATOR -DCMAKE_INSTALL_PREFIX=$INSTALL_LOCATION $REPO_LOCATION $CMAKE_OPTIONS"
cmake -G $CMAKE_CONFIG_GENERATOR "-DCMAKE_INSTALL_PREFIX=$INSTALL_LOCATION" $REPO_LOCATION @CMAKE_OPTIONS
if($LastExitCode -ne 0) { $host.SetShouldExit($LastExitCode )  }
cmake --build .  --target install --config release
if($LastExitCode -ne 0) { $host.SetShouldExit($LastExitCode )  }
Pop-Location