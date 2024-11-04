@echo off
setlocal enabledelayedexpansion

:: Set the directory where the CSV files are located
set "csv_dir=H:\NEVERWINTER\NEVERWINTER\Night\data\EXPORTS"
set "base_dir=W:\Night\data"  :: Ensure this path points to the correct data files location

:: Find all CSV files in the specified directory
echo Scanning for CSV files in %csv_dir%...
set "count=0"
for %%F in ("%csv_dir%\*.csv") do (
    set /a count+=1
    set "file[!count!]=%%F"
    echo !count!: %%~nxF
)

:: Check if any CSV files were found
if %count%==0 (
    echo No CSV files found in %csv_dir%.
    pause
    exit /b 1
)

:: Prompt user to select a file
set /p "choice=Enter the number of the CSV file to use: "

:: Validate input
if not defined file[%choice%] (
    echo Invalid selection. Exiting.
    pause
    exit /b 1
)

set "csv_file=!file[%choice%]!"

:: Extract the base name of the selected CSV file (without .csv extension)
for %%F in ("%csv_file%") do set "folder_name=%%~nF"

:: Create the folder named after the CSV file
mkdir "%folder_name%" >nul 2>&1

:: Process the CSV file line by line, handling quotes and special characters
echo Processing file: !csv_file!
for /f "usebackq skip=1 tokens=1-4 delims=," %%A in ("!csv_file!") do (
    set "dir_path=%%D"
    :: Trim surrounding quotes, if any
    set "dir_path=!dir_path:"=!"

    :: Replace forward slashes with backslashes
    set "dir_path=!dir_path:/=\!"

    :: Skip if the 4th column is empty
    if not "!dir_path!"=="" (
        set "src_file=%base_dir%\!dir_path!"
        set "dest_file=%folder_name%\!dir_path!"
        
        :: Debugging output to check file paths
        echo Source file: !src_file!
        echo Destination file: !dest_file!

        :: Create necessary directories in the destination folder
        for %%P in ("!dest_file!") do mkdir "%%~dpP" >nul 2>&1
        
        :: Copy the file if it exists
        if exist "!src_file!" (
            copy "!src_file!" "!dest_file!" >nul
            echo Copied: !src_file! to !dest_file!
        ) else (
            echo Warning: Source file not found: !src_file!
        )
    )
)

echo Done.
pause
