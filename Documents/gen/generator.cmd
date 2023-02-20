@echo off
::if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
::pushd %~dp0

@title Onion Generator - last update 08 March 2022
setlocal EnableExtensions EnableDelayedExpansion

where /q fart || set errorMessage=fart.exe tidak ditemukan, silahkan taruh terlebih dahulu && goto errorControl

:namaproject
@title Architecture Generator - Project Name
set /p projectName=ketik nama Project:
::set projectName=ImportTrackingInventory

:architecture
@title Generator - Architecture
echo.
echo Architecture:
echo 1. Onion
echo 2. cqrs
echo 3. services
echo 4. vuetify
set /p pilihan=ketik angka (1-4):
set _tempvar=0
set userlogin=
If %pilihan% gtr 4 set _tempvar=1
If %pilihan% lss 1 set _tempvar=1
if %_tempvar% EQU 1 goto :architecture
if %pilihan% EQU 1 set architecture=onion
if %pilihan% EQU 2 set architecture=cqrs
if %pilihan% EQU 3 set architecture=services
if %pilihan% EQU 4 set architecture=vuetify

:depan
@title Architecture Generator - Main Page
echo.
echo Pilihan:
echo 1. Generate projek baru
echo 2. Generate konten ^(resource, service, interface, etc^)
set jumlahpilih=2
if %architecture%==vuetify (
echo 3. Generate View from backend record
echo 4. Generate View Report from backend record
set jumlahpilih=4
)
set /p pilihan=ketik angka (1-!jumlahpilih!):
set _tempvar=0
set userlogin=
If %pilihan% gtr 4 set _tempvar=1
If %pilihan% lss 1 set _tempvar=1
if %_tempvar% EQU 1 goto :depan
if %pilihan% EQU 1 goto :generateproject
if %pilihan% EQU 2 goto :konten
if %pilihan% EQU 3 goto :viewfromrecord
if %pilihan% EQU 4 goto :viewfromrecord

:generateproject
robocopy !architecture! ..\!projectName! /E /R:1 /W:1 >nul 
fart -r ..\!projectName!\ "projectnamefull" "!projectName!" >nul 
fart -r -f ..\!projectName!\ "projectnamefull" "!projectName!" >nul
if %architecture%==onion (
ren ..\!projectName!\projectnamefull.Application !projectName!.Application
ren ..\!projectName!\projectnamefull.Domain !projectName!.Domain
ren ..\!projectName!\projectnamefull.Persistence !projectName!.Persistence
ren ..\!projectName!\projectnamefull.WebApi !projectName!.WebApi
)
if %architecture%==cqrs (
ren ..\!projectName!\projectnamefull.Application !projectName!.Application
ren ..\!projectName!\projectnamefull.Cache !projectName!.Cache
ren ..\!projectName!\projectnamefull.Domain !projectName!.Domain
ren ..\!projectName!\projectnamefull.Helper !projectName!.Helper
ren ..\!projectName!\projectnamefull.Identity !projectName!.Identity
ren ..\!projectName!\projectnamefull.Persistence !projectName!.Persistence
ren ..\!projectName!\projectnamefull.Test !projectName!.Test
ren ..\!projectName!\projectnamefull.WebApi !projectName!.WebApi
)
if %architecture%==services (
ren ..\!projectName!\projectnamefull.Application !projectName!.Application
ren ..\!projectName!\projectnamefull.Domain !projectName!.Domain
ren ..\!projectName!\projectnamefull.Helper !projectName!.Helper
ren ..\!projectName!\projectnamefull.JwtIdentity !projectName!.JwtIdentity
ren ..\!projectName!\projectnamefull.Persistence !projectName!.Persistence
ren ..\!projectName!\projectnamefull.Test !projectName!.Test
ren ..\!projectName!\projectnamefull.WebApi !projectName!.WebApi
)
if %architecture%==vuetify (
echo maaf, belum ada
pause
exit
)
robocopy %cd% ..\!projectName!\Documents\gen "fart.exe" /R:1 /W:1 >nul
robocopy %cd% ..\!projectName!\Documents\gen "generator.cmd" /R:1 /W:1 >nul
goto :akhir

:konten
echo.
for %%I in (..\.) do set dirname=%%~nxI
if %dirname%==Documents (
set basedir=..\..
) else (
set basedir=..
)
goto :namamodel

:viewfromrecord
echo.
for %%I in (..\.) do set dirname=%%~nxI
if %dirname%==Documents (
set basedir=..\..
) else (
set basedir=..
)
goto :namarecord

:namarecord
@title Architecture Generator - Response name
@echo:
echo Silahkan masukkan semua response yang akan digenerate ke folder responses
echo [tekan enter untuk melihat hasil]
pause >nul
dir responses /b>fileList.log
set firstWrite=true
for /f %%x in (fileList.log) do (
	set str=%%x
	set str=!str:Response.cs=!
	if not exist "responses\!str!HeaderResponse.cs" (
		if !firstWrite!==true (
			echo !str!>modelList.log
			set firstWrite=false
		) else (
			echo !str!>>modelList.log
		)
	)
)
for /f %%x in (modelList.log) do (
	echo %%x
)
goto :generateModel
set /p jawaban=Apakah list sudah benar (y/n)?
IF "%jawaban%" == "y" GOTO :generateModel
goto :namarecord


:namamodel
@title Architecture Generator - Model name
@echo:
echo Silahkan isi model yang akan digenerate
echo [tekan enter untuk membuka modelList.log]
pause >nul
echo.>modelList.log
goto :modellist

:modellist
modelList.log
@echo:
Echo [Silakan ubah dan save modelList.log lalu tekan enter untuk melanjutkan]
if %architecture%==cqrs (
	echo untuk cqrs, mohon gunakan format singluar_plurar, contoh city_cities
)
pause >nul
for /f %%x in (modelList.log) do (
	for /f "tokens=1,2 delims=_" %%a in ("%%x") do (
		echo %%a dan %%b
	)
)
set /p jawaban=Apakah list sudah benar (y/n)?
IF "%jawaban%" == "y" GOTO :generateModel
goto :modellist

:akhir
echo Terima kasih telah menggunakan Architecture Generator :D
pause
exit















:LoCase
:: Subroutine to convert a variable VALUE to all lower case.
:: The argument for this subroutine is the variable NAME.
SET %~1=!%1:A=a!
SET %~1=!%1:B=b!
SET %~1=!%1:C=c!
SET %~1=!%1:D=d!
SET %~1=!%1:E=e!
SET %~1=!%1:F=f!
SET %~1=!%1:G=g!
SET %~1=!%1:H=h!
SET %~1=!%1:I=i!
SET %~1=!%1:J=j!
SET %~1=!%1:K=k!
SET %~1=!%1:L=l!
SET %~1=!%1:M=m!
SET %~1=!%1:N=n!
SET %~1=!%1:O=o!
SET %~1=!%1:P=p!
SET %~1=!%1:Q=q!
SET %~1=!%1:R=r!
SET %~1=!%1:S=s!
SET %~1=!%1:T=t!
SET %~1=!%1:U=u!
SET %~1=!%1:V=v!
SET %~1=!%1:W=w!
SET %~1=!%1:X=x!
SET %~1=!%1:Y=y!
SET %~1=!%1:Z=z!
GOTO:EOF

:upCase
:: Subroutine to convert a variable VALUE to all upper case.
:: The argument for this subroutine is the variable NAME.
SET %~1=!%1:a=A!
SET %~1=!%1:b=B!
SET %~1=!%1:c=C!
SET %~1=!%1:d=D!
SET %~1=!%1:e=E!
SET %~1=!%1:f=F!
SET %~1=!%1:g=G!
SET %~1=!%1:h=H!
SET %~1=!%1:i=I!
SET %~1=!%1:j=J!
SET %~1=!%1:k=K!
SET %~1=!%1:l=L!
SET %~1=!%1:m=M!
SET %~1=!%1:n=N!
SET %~1=!%1:o=O!
SET %~1=!%1:p=P!
SET %~1=!%1:q=Q!
SET %~1=!%1:r=R!
SET %~1=!%1:s=S!
SET %~1=!%1:t=T!
SET %~1=!%1:u=U!
SET %~1=!%1:v=V!
SET %~1=!%1:w=W!
SET %~1=!%1:x=X!
SET %~1=!%1:y=Y!
SET %~1=!%1:z=Z!
GOTO:EOF

:snakeCamel
:: Subroutine to convert a variable VALUE to all upper case.
:: The argument for this subroutine is the variable NAME.
SET %~1=!%1:_a=A!
SET %~1=!%1:_b=B!
SET %~1=!%1:_c=C!
SET %~1=!%1:_d=D!
SET %~1=!%1:_e=E!
SET %~1=!%1:_f=F!
SET %~1=!%1:_g=G!
SET %~1=!%1:_h=H!
SET %~1=!%1:_i=I!
SET %~1=!%1:_j=J!
SET %~1=!%1:_k=K!
SET %~1=!%1:_l=L!
SET %~1=!%1:_m=M!
SET %~1=!%1:_n=N!
SET %~1=!%1:_o=O!
SET %~1=!%1:_p=P!
SET %~1=!%1:_q=Q!
SET %~1=!%1:_r=R!
SET %~1=!%1:_s=S!
SET %~1=!%1:_t=T!
SET %~1=!%1:_u=U!
SET %~1=!%1:_v=V!
SET %~1=!%1:_w=W!
SET %~1=!%1:_x=X!
SET %~1=!%1:_y=Y!
SET %~1=!%1:_z=Z!
GOTO:EOF


:spaceTitleResult
REM replace TitleCase to Space Case
REM result in variable result
set result=
set param1=%~1
FOR /L %%A IN (0,1,999) DO (
	SET Char=!param1:~%%A,1!
	
	REM Case sensitive char replacement.
	IF "!Char!" EQU "A" SET Char= A
	IF "!Char!" EQU "B" SET Char= B
	IF "!Char!" EQU "C" SET Char= C
	IF "!Char!" EQU "D" SET Char= D
	IF "!Char!" EQU "E" SET Char= E
	IF "!Char!" EQU "F" SET Char= F
	IF "!Char!" EQU "G" SET Char= G
	IF "!Char!" EQU "H" SET Char= H
	IF "!Char!" EQU "I" SET Char= I
	IF "!Char!" EQU "J" SET Char= J
	IF "!Char!" EQU "K" SET Char= K
	IF "!Char!" EQU "L" SET Char= L
	IF "!Char!" EQU "M" SET Char= M
	IF "!Char!" EQU "N" SET Char= N
	IF "!Char!" EQU "O" SET Char= O
	IF "!Char!" EQU "P" SET Char= P
	IF "!Char!" EQU "Q" SET Char= Q
	IF "!Char!" EQU "R" SET Char= R
	IF "!Char!" EQU "S" SET Char= S
	IF "!Char!" EQU "T" SET Char= T
	IF "!Char!" EQU "U" SET Char= U
	IF "!Char!" EQU "V" SET Char= V
	IF "!Char!" EQU "W" SET Char= W
	IF "!Char!" EQU "X" SET Char= X
	IF "!Char!" EQU "Y" SET Char= Y
	IF "!Char!" EQU "Z" SET Char= Z

	REM Append result.
	SET result=!result!!Char!
)
set result=!result:~1!
GOTO :EOF

:spaceSmallResult
REM replace TitleCase to small space case
REM result in variable result
set result=
set param1=%~1
FOR /L %%A IN (0,1,999) DO (
	SET Char=!param1:~%%A,1!
	
	REM Case sensitive char replacement.
    IF "!Char!" EQU "A" SET Char= a
    IF "!Char!" EQU "B" SET Char= b
    IF "!Char!" EQU "C" SET Char= c
    IF "!Char!" EQU "D" SET Char= d
    IF "!Char!" EQU "E" SET Char= e
    IF "!Char!" EQU "F" SET Char= f
    IF "!Char!" EQU "G" SET Char= g
    IF "!Char!" EQU "H" SET Char= h
    IF "!Char!" EQU "I" SET Char= i
    IF "!Char!" EQU "J" SET Char= j
    IF "!Char!" EQU "K" SET Char= k
    IF "!Char!" EQU "L" SET Char= l
    IF "!Char!" EQU "M" SET Char= m
    IF "!Char!" EQU "N" SET Char= n
    IF "!Char!" EQU "O" SET Char= o
    IF "!Char!" EQU "P" SET Char= p
    IF "!Char!" EQU "Q" SET Char= q
    IF "!Char!" EQU "R" SET Char= r
    IF "!Char!" EQU "S" SET Char= s
    IF "!Char!" EQU "T" SET Char= t
    IF "!Char!" EQU "U" SET Char= u
    IF "!Char!" EQU "V" SET Char= v
    IF "!Char!" EQU "W" SET Char= w
    IF "!Char!" EQU "X" SET Char= x
    IF "!Char!" EQU "Y" SET Char= y
    IF "!Char!" EQU "Z" SET Char= z

	REM Append result.
	SET result=!result!!Char!
)
set result=!result:~1!
GOTO :EOF

:stripTitleResult
REM replace TitleCase to strip-case
REM result in variable result
set result=
set param1=%~1
FOR /L %%A IN (0,1,999) DO (
	SET Char=!param1:~%%A,1!

	REM Case sensitive char replacement.
    IF "!Char!" EQU "A" SET Char=-a
    IF "!Char!" EQU "B" SET Char=-b
    IF "!Char!" EQU "C" SET Char=-c
    IF "!Char!" EQU "D" SET Char=-d
    IF "!Char!" EQU "E" SET Char=-e
    IF "!Char!" EQU "F" SET Char=-f
    IF "!Char!" EQU "G" SET Char=-g
    IF "!Char!" EQU "H" SET Char=-h
    IF "!Char!" EQU "I" SET Char=-i
    IF "!Char!" EQU "J" SET Char=-j
    IF "!Char!" EQU "K" SET Char=-k
    IF "!Char!" EQU "L" SET Char=-l
    IF "!Char!" EQU "M" SET Char=-m
    IF "!Char!" EQU "N" SET Char=-n
    IF "!Char!" EQU "O" SET Char=-o
    IF "!Char!" EQU "P" SET Char=-p
    IF "!Char!" EQU "Q" SET Char=-q
    IF "!Char!" EQU "R" SET Char=-r
    IF "!Char!" EQU "S" SET Char=-s
    IF "!Char!" EQU "T" SET Char=-t
    IF "!Char!" EQU "U" SET Char=-u
    IF "!Char!" EQU "V" SET Char=-v
    IF "!Char!" EQU "W" SET Char=-w
    IF "!Char!" EQU "X" SET Char=-x
    IF "!Char!" EQU "Y" SET Char=-y
    IF "!Char!" EQU "Z" SET Char=-z
	
	REM Append result.
	SET result=!result!!Char!
)
set result=!result:~1!
GOTO :EOF

:FirstUp
setlocal EnableDelayedExpansion
set "temp=%~2"
set "helper=##AABBCCDDEEFFGGHHIIJJKKLLMMNNOOPPQQRRSSTTUUVVWWXXYYZZ"
set "first=!helper:*%temp:~0,1%=!"
set "first=!first:~0,1!"
if "!first!"=="#" set "first=!temp:~0,1!"
set "temp=!first!!temp:~1!"
(
    endlocal
    set "result=%temp%"
    goto :eof
)
GOTO :EOF

:FirstDown
setlocal EnableDelayedExpansion
set "temp=%~2"
set "helper=##aabbccddeeffgghhiijjkkllmmnnooppqqrrssttuuvvwwxxyyzz"
set "first=!helper:*%temp:~0,1%=!"
set "first=!first:~0,1!"
if "!first!"=="#" set "first=!temp:~0,1!"
set "temp=!first!!temp:~1!"
(
    endlocal
    set "result=%temp%"
    goto :eof
)
GOTO :EOF

:generateModel
echo generating... silakan tunggu...
@title Architecture Generator - Generating...
for /f %%x in (modelList.log) do (
set tabelfull=%%x
if NOT %pilihan%==3 if NOT %pilihan%==4 (
	for /f "tokens=1,2 delims=_" %%a in ("!tabelfull!") do (
		set tabel=%%a
		set plurar=%%b
	)
)
if %pilihan% EQU 3 (
	set tabelFileName=%%x
	set tabel=!tabelFileName:Header=!
)

if %pilihan% EQU 4 (
	set tabelFileName=%%x
	set tabel=!tabelFileName:Header=!
)

set tabelSnake=!tabel!
CALL :SnakeCamel tabelSnake
set tabelLow=!tabel!
CALL :LoCase tabelLow
CALL :FirstDown result !tabelSnake!
set tabelSnake=!result!

call :spaceTitleResult !tabel!
set tabelSpace=!result!

call :stripTitleResult !tabel!
set tabelStrip=!result!
call :spaceSmallResult !tabel!
set tabelSpcLow=!result!

set tabelProper=!tabelSnake!
CALL :FirstUp result !tabelProper!
set tabelProper=!result!

set tabelTanpaLaporan=!tabelProper:Laporan=!
call :stripTitleResult !tabelTanpaLaporan!
set tabelTanpaLaporanStrip=!result!

REM ###############################################################################################################

if %architecture%==onion (
SET folderpath=!basedir!\!projectName!.Application\Resources
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!Resource.cs
echo namespace !projectName!.Application.Resources^;>!filename!
echo.>>!filename!
echo public class !tabelProper!Resource>>!filename!
echo {>>!filename!
echo     public string Id { get^; set^; }>>!filename!
echo.>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Services
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!Service.cs
::SET filename=C:\repo\ebt\ArchitectureGenerator\generator\onion\projectnamefull.Application\Services\!tabelProper!Service.cs
echo // E:	!tabelProper!								>!filename!
echo // R:	!tabelProper!Resource								>>!filename!
echo // S:	!tabelProper!Service								>>!filename!
echo.>>!filename!
echo namespace !projectName!.Application.Services^;>>!filename!
echo.>>!filename!
echo public class !tabelProper!Service>>!filename!
echo {>>!filename!
echo 	private readonly IDataContext db^;>>!filename!
echo.>>!filename!
echo 	public !tabelProper!Service^(IDataContext db^)>>!filename!
echo 	{>>!filename!
echo 		this.db ^= db^;>>!filename!
echo 	}>>!filename!
echo.>>!filename!
echo 	public !tabelProper!Resource Get^(string id^)>>!filename!
echo 	{>>!filename!
echo 		return db.GetQuery^<!tabelProper!^>^(^)>>!filename!
echo 			.Where^(x ^=^> x.Id ^=^= id^)>>!filename!
echo 			.Project^(^).To^<!tabelProper!Resource^>^(^)>>!filename!
echo 			.FirstOrDefault^(^)^;>>!filename!
echo 	}>>!filename!
echo.>>!filename!
echo 	public List^<!tabelProper!Resource^> GetList^(^)>>!filename!
echo 	{>>!filename!
echo 		return db.GetQuery^<!tabelProper!^>^(^)>>!filename!
echo 			.Project^(^).To^<!tabelProper!Resource^>^(^)>>!filename!
echo 			.ToList^(^)^;>>!filename!
echo 	}>>!filename!
echo.>>!filename!
echo 	public StampResource GetStamp^(string id^)>>!filename!
echo 	{>>!filename!
echo 		return db.GetStamp^<!tabelProper!^>^(id^)^;>>!filename!
echo 	}>>!filename!
echo.>>!filename!
echo 	private void Validate^(!tabelProper!Resource res^)>>!filename!
echo 	{>>!filename!
echo.>>!filename!
echo 	}>>!filename!
echo.>>!filename!
echo 	public !tabelProper!Resource Create^(!tabelProper!Resource res, string userId^)>>!filename!
echo 	{>>!filename!
echo 		Validate^(res^)^;>>!filename!
echo.>>!filename!
echo 		var model ^= new !tabelProper!^(^)^;>>!filename!
echo 		model.MapFrom^(res^)^;>>!filename!
echo 		db.Create^(model, userId^)^;>>!filename!
echo 		db.SaveChanges^(^)^;>>!filename!
echo.>>!filename!
echo 		return Get^(model.Id^)^;>>!filename!
echo 	}>>!filename!
echo.>>!filename!
echo 	public !tabelProper!Resource Update^(!tabelProper!Resource res, string userId^)>>!filename!
echo 	{>>!filename!
echo 		Validate^(res^)^;>>!filename!
echo.>>!filename!
echo 		var model ^= db.Get^<!tabelProper!^>^(res.Id^)^;>>!filename!
echo 		model.MapFrom^(res^)^;>>!filename!
echo 		db.Update^(model, userId^)^;>>!filename!
echo 		db.SaveChanges^(^)^;>>!filename!
echo.>>!filename!
echo 		return Get^(model.Id^)^;>>!filename!
echo 	}>>!filename!
echo.>>!filename!
echo 	public void Delete^(string id, string userId^)>>!filename!
echo 	{>>!filename!
echo 		db.Delete^<!tabelProper!^>^(id, userId^)^;>>!filename!
echo 		db.SaveChanges^(^)^;>>!filename!
echo 	}>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Domain\Enums
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\PrivilegeEnum.cs
if exist "!filename!" (
fart -C !filename! "public const string User ^= \"User\"^;" "public const string !tabelProper! ^= \"!tabelProper!\"^;\r\n    public const string User ^= \"User\"^;" >nul
) else (
echo namespace !projectName!.Domain.Enums^;>>!filename!
echo.>>!filename!
echo public class PrivilegeEnum>>!filename!
echo {>>!filename!
echo     public const string !tabelProper! ^= "!tabelProper!"^;>>!filename!
echo     public const string User ^= "User"^;>>!filename!
echo }>>!filename!
)

SET folderpath=!basedir!\!projectName!.Domain\Entities
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!.cs
echo namespace !projectName!.Domain.Entities^;>!filename!
echo.>>!filename!
echo public class !tabelProper! : IEntity>>!filename!
echo {>>!filename!
echo     public string Id { get^; set^; }>>!filename!
echo.>>!filename!
echo.>>!filename!
echo     public bool IsDeleted { get^; set^; }>>!filename!
echo     public DateTime? DateCreated { get^; set^; }>>!filename!
echo     public string CreatedById { get^; set^; }>>!filename!
echo     public DateTime? DateUpdated { get^; set^; }>>!filename!
echo     public string UpdatedById { get^; set^; }>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.WebApi\Controllers
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!Controller.cs
::SET filename=C:\repo\ebt\ArchitectureGenerator\generator\onion\projectnamefull.WebApi\Controllers\!tabelProper!Controller.cs
echo // E:	!tabelProper!	>!filename!
echo // R:	!tabelProper!Resource	>>!filename!
echo // S:	!tabelProper!Service	!tabelSnake!Service>>!filename!
echo // C:	!tabelProper!Controller	>>!filename!
echo.>>!filename!
echo namespace projectnamefull.WebApi.Controllers^;>>!filename!
echo.>>!filename!
echo [Route^("!tabelLow!"^)]>>!filename!
echo public class !tabelProper!Controller : ControllerBase>>!filename!
echo {>>!filename!
echo 	private readonly UserService userService^;>>!filename!
echo 	private readonly !tabelProper!Service !tabelSnake!Service^;>>!filename!
echo.>>!filename!
echo 	public !tabelProper!Controller^(>>!filename!
echo 		UserService userService,>>!filename!
echo 		!tabelProper!Service !tabelSnake!Service^)>>!filename!
echo 	{>>!filename!
echo 		this.userService ^= userService^;>>!filename!
echo 		this.!tabelSnake!Service ^= !tabelSnake!Service^;>>!filename!
echo 	}>>!filename!
echo.>>!filename!
echo 	[HttpGet^("{id}"^)]>>!filename!
echo 	public ActionResult^<!tabelProper!Resource^> Get^(string id^)>>!filename!
echo 	{>>!filename!
echo 		this.Authorize^(userService^)^;>>!filename!
echo.>>!filename!
echo 		var resource ^= !tabelSnake!Service.Get^(id^)^;>>!filename!
echo.>>!filename!
echo 		return Ok^(resource^)^;>>!filename!
echo 	}>>!filename!
echo.>>!filename!
echo 	[HttpGet]>>!filename!
echo 	public ActionResult^<List^<!tabelProper!Resource^>^> GetList^(^)>>!filename!
echo 	{>>!filename!
echo 		this.Authorize^(userService^)^;>>!filename!
echo.>>!filename!
echo 		var result ^= !tabelSnake!Service.GetList^(^)^;>>!filename!
echo.>>!filename!
echo 		return Ok^(result^)^;>>!filename!
echo 	}>>!filename!
echo.>>!filename!
echo 	[HttpGet^("stamp/{id}"^)]>>!filename!
echo 	public ActionResult^<StampResource^> GetStamp^(string id^)>>!filename!
echo 	{>>!filename!
echo 		this.Authorize^(userService^)^;>>!filename!
echo.>>!filename!
echo 		var result ^= !tabelSnake!Service.GetStamp^(id^)^;>>!filename!
echo.>>!filename!
echo 		return Ok^(result^)^;>>!filename!
echo 	}>>!filename!
echo.>>!filename!
echo 	[HttpPost]>>!filename!
echo 	public ActionResult^<!tabelProper!Resource^> Create^([FromBody] !tabelProper!Resource res^)>>!filename!
echo 	{>>!filename!
echo 		var token ^= this.Authorize^(userService, PrivilegeEnum.!tabelProper!^)^;>>!filename!
echo.>>!filename!
echo 		var result ^= !tabelSnake!Service.Create^(res, token.UserId^)^;>>!filename!
echo.>>!filename!
echo 		return CreatedAtAction^(nameof^(Get^), new { result.Id }, result^)^;>>!filename!
echo 	}>>!filename!
echo.>>!filename!
echo 	[HttpPut^("{id}"^)]>>!filename!
echo 	public ActionResult^<!tabelProper!Resource^> Update^(string id, [FromBody] !tabelProper!Resource res^)>>!filename!
echo 	{>>!filename!
echo 		var token ^= this.Authorize^(userService, PrivilegeEnum.!tabelProper!^)^;>>!filename!
echo.>>!filename!
echo 		res.Id ^=^= id^;>>!filename!
echo 		var result ^= !tabelSnake!Service.Update^(res, token.UserId^)^;>>!filename!
echo.>>!filename!
echo 		return Ok^(result^)^;>>!filename!
echo 	}>>!filename!
echo.>>!filename!
echo 	[HttpDelete^("{id}"^)]>>!filename!
echo 	public ActionResult Delete^(string id^)>>!filename!
echo 	{>>!filename!
echo 		var token ^= this.Authorize^(userService, PrivilegeEnum.!tabelProper!^)^;>>!filename!
echo.>>!filename!
echo 		!tabelSnake!Service.Delete^(id, token.UserId^)^;>>!filename!
echo.>>!filename!
echo 		return NoContent^(^)^;>>!filename!
echo 	}>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Interfaces
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\IDataContext.cs
if exist "!filename!" (
fart -C !filename! "DbSet^<User^> User { get^; set^; }" "DbSet^<!tabelProper!^> !tabelProper! { get^; set^; }\r\n    DbSet^<User^> User { get^; set^; }" >nul
) else (
echo using Microsoft.EntityFrameworkCore^;>!filename!
echo using Microsoft.EntityFrameworkCore.Storage^;>>!filename!
echo.>>!filename!
echo namespace !projectName!.Application.Interfaces^;>>!filename!
echo.>>!filename!
echo public interface IDataContext>>!filename!
echo {>>!filename!
echo     DbSet^<!tabelProper!^> !tabelProper! { get^; set^; }>>!filename!
echo     DbSet^<User^> User { get^; set^; }>>!filename!
echo.>>!filename!
echo     IDbContextTransaction BeginTransaction^(^)^;>>!filename!
echo.>>!filename!
echo     DbSet^<TEntity^> Set^<TEntity^>^(^) where TEntity : class^;>>!filename!
echo     int SaveChanges^(^)^;>>!filename!
echo }>>!filename!
)

SET folderpath=!basedir!\!projectName!.Persistence\Context
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\DataContext.cs
if exist "!filename!" (
fart -C !filename! "public DbSet^<User^> User { get^; set^; }" "public DbSet^<!tabelProper!^> !tabelProper! { get^; set^; }\r\n    public DbSet^<User^> User { get^; set^; }" >nul
) else (
echo namespace !projectName!.Persistence.Context^;>!filename!
echo.>>!filename!
echo public class DataContext : DbContext, IDataContext>>!filename!
echo {>>!filename!
echo     public DataContext^(^) { }>>!filename!
echo     public DataContext^(DbContextOptions options^) : base^(options^) { }>>!filename!
echo     public DbSet^<!tabelProper!^> !tabelProper! { get^; set^; }>>!filename!
echo     public DbSet^<Role^> Role { get^; set^; }>>!filename!
echo     public DbSet^<User^> User { get^; set^; }>>!filename!
echo    >>!filename!
echo     public IDbContextTransaction BeginTransaction^(^)>>!filename!
echo     {>>!filename!
echo         return Database.BeginTransaction^(^)^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     protected override void ConfigureConventions^(ModelConfigurationBuilder configurationBuilder^)>>!filename!
echo     {>>!filename!
echo         configurationBuilder.Properties^<DateTime^>^(^)>>!filename!
echo             .HaveColumnType^("timestamp"^)^;>>!filename!
echo.>>!filename!
echo         configurationBuilder.Properties^<DateTime?^>^(^)>>!filename!
echo             .HaveColumnType^("timestamp"^)^;>>!filename!
echo.>>!filename!
echo         base.ConfigureConventions^(configurationBuilder^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!
)

SET folderpath=!basedir!\!projectName!.WebApi\Extensions
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\ServiceCollectionExtensions.cs
if exist "!filename!" (
fart -C !filename! "services.AddScoped^<UserService^>^(^)^;" "services.AddScoped^<!tabelProper!Service^>^(^)^;\r\n        services.AddScoped^<UserService^>^(^)^;" >nul
) else (
echo namespace !projectName!.WebApi.Extensions^;>!filename!
echo.>>!filename!
echo public static class ServiceCollectionExtensions>>!filename!
echo {>>!filename!
echo     public static void AddApplicationServices^(this IServiceCollection services^)>>!filename!
echo     {>>!filename!
echo         services.AddScoped^<!tabelProper!Service^>^(^)^;>>!filename!
echo         services.AddScoped^<RoleService^>^(^)^;>>!filename!
echo         services.AddScoped^<UserService^>^(^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!
)
)

REM ###############################################################################################################

if %architecture%==cqrs (
SET folderpath=!basedir!\!projectName!.Application\Features\!plurar!\Commands
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\Create!tabelProper!Command.cs
echo using !projectName!.Application.Features.!plurar!.Resources^;>!filename!
echo.>>!filename!
echo namespace !projectName!.Application.Features.!plurar!.Commands^;>>!filename!
echo.>>!filename!
echo public sealed record Create!tabelProper!Command^(string Name^) : BaseCreateCommand, IRequest^<!tabelProper!Resource^>^;>>!filename!
echo.>>!filename!
echo public class Create!tabelProper!CommandHandler : IRequestHandler^<Create!tabelProper!Command, !tabelProper!Resource^>>>!filename!
echo {>>!filename!
echo     private readonly IDataContext db^;>>!filename!
echo     private readonly IMapper mapper^;>>!filename!
echo.>>!filename!
echo     public Create!tabelProper!CommandHandler^(IDataContext db, IMapper mapper^)>>!filename!
echo     {>>!filename!
echo         this.db ^= db^;>>!filename!
echo         this.mapper ^= mapper^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     public async Task^<!tabelProper!Resource^> Handle^(Create!tabelProper!Command request, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         var category ^= mapper.Map^<!tabelProper!^>^(request^)^;>>!filename!
echo         await db.Create^(category, cancellationToken^)^;>>!filename!
echo         await db.SaveChangesAsync^(cancellationToken^)^;>>!filename!
echo.>>!filename!
echo         return await db.GetQuery^<!tabelProper!^>^(^)>>!filename!
echo             .Where^(x ^=^> x.Id ^=^= category.Id^)>>!filename!
echo             .ProjectTo^<!tabelProper!Resource^>^(mapper.ConfigurationProvider^)>>!filename!
echo             .FirstOrDefaultAsync^(cancellationToken^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!
echo.>>!filename!
echo public class Create!tabelProper!Validator : AbstractValidator^<Create!tabelProper!Command^>>>!filename!
echo {>>!filename!
echo     public Create!tabelProper!Validator^(IDataContext db^)>>!filename!
echo     {>>!filename!
echo         RuleFor^(res ^=^> res^).NotNull^(^)^;>>!filename!
echo.>>!filename!
echo         RuleFor^(res ^=^> res.Name^)>>!filename!
echo             .NotEmpty^(^)>>!filename!
echo             .MaximumLength^(50^)>>!filename!
echo             .MustAsync^(async ^(name, ct^) ^=^>>>!filename!
echo                 await db.NotAny^<!tabelProper!^>^(x ^=^> x.Name ^=^= name, ct^)^)>>!filename!
echo                 .WithMessage^("'Name' is already used."^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Features\!plurar!\Commands
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\Delete!tabelProper!Command.cs
echo namespace !projectName!.Application.Features.!plurar!.Commands^;>!filename!
echo.>>!filename!
echo public sealed record Delete!tabelProper!Command^(string Id^) : BaseDeleteCommand, IRequest^;>>!filename!
echo.>>!filename!
echo public class Delete!tabelProper!CommandHandler : IRequestHandler^<Delete!tabelProper!Command^>>>!filename!
echo {>>!filename!
echo     private readonly IDataContext db^;>>!filename!
echo.>>!filename!
echo     public Delete!tabelProper!CommandHandler^(IDataContext db^)>>!filename!
echo     {>>!filename!
echo         this.db ^= db^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     public async Task^<Unit^> Handle^(Delete!tabelProper!Command request, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         await db.Delete^<!tabelProper!^>^(request.Id, request.GetDeletedById^(^), cancellationToken^)^;>>!filename!
echo         await db.SaveChangesAsync^(cancellationToken^)^;>>!filename!
echo.>>!filename!
echo         return Unit.Value^;>>!filename!
echo     }>>!filename!
echo }>>!filename!
echo.>>!filename!
echo public sealed class Delete!tabelProper!Validator : AbstractValidator^<Delete!tabelProper!Command^>>>!filename!
echo {>>!filename!
echo     public Delete!tabelProper!Validator^(IDataContext db^)>>!filename!
echo     {>>!filename!
echo         RuleFor^(res ^=^> res^).NotNull^(^)^;>>!filename!
echo         RuleFor^(res ^=^> res.Id^)>>!filename!
echo             .NotEmpty^(^)>>!filename!
echo             .Length^(36^)>>!filename!
echo             .MustAsync^(async ^(id, ct^) ^=^>>>!filename!
echo                 await db.Exists^<!tabelProper!^>^(id, ct^)^)>>!filename!
echo                 .WithMessage^("'Id' is not exists."^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Features\!plurar!\Commands
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\Update!tabelProper!Command.cs
echo using !projectName!.Application.Features.!plurar!.Resources^;>!filename!
echo.>>!filename!
echo namespace !projectName!.Application.Features.!plurar!.Commands^;>>!filename!
echo.>>!filename!
echo public sealed record Update!tabelProper!Command^(string Id, string Name^) : BaseUpdateCommand, IRequest^<!tabelProper!Resource^>^;>>!filename!
echo.>>!filename!
echo public class Update!tabelProper!CommandHandler : IRequestHandler^<Update!tabelProper!Command, !tabelProper!Resource^>>>!filename!
echo {>>!filename!
echo     private readonly IDataContext db^;>>!filename!
echo     private readonly IMapper mapper^;>>!filename!
echo.>>!filename!
echo     public Update!tabelProper!CommandHandler^(IDataContext db, IMapper mapper^)>>!filename!
echo     {>>!filename!
echo         this.db ^= db^;>>!filename!
echo         this.mapper ^= mapper^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     public async Task^<!tabelProper!Resource^> Handle^(Update!tabelProper!Command request, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         var category ^= await db.Get^<!tabelProper!^>^(request.Id, cancellationToken^)^;>>!filename!
echo         mapper.Map^(request, category^)^;>>!filename!
echo         db.Update^(category^)^;>>!filename!
echo         await db.SaveChangesAsync^(cancellationToken^)^;>>!filename!
echo.>>!filename!
echo         return await db.GetQuery^<!tabelProper!^>^(^)>>!filename!
echo             .Where^(x ^=^> x.Id ^=^= category.Id^)>>!filename!
echo             .ProjectTo^<!tabelProper!Resource^>^(mapper.ConfigurationProvider^)>>!filename!
echo             .FirstOrDefaultAsync^(cancellationToken^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!
echo.>>!filename!
echo public class Update!tabelProper!Validator : AbstractValidator^<Update!tabelProper!Command^>>>!filename!
echo {>>!filename!
echo     public Update!tabelProper!Validator^(IDataContext db^)>>!filename!
echo     {>>!filename!
echo         RuleFor^(res ^=^> res^).NotNull^(^)^;>>!filename!
echo.>>!filename!
echo         RuleFor^(res ^=^> res.Id^)>>!filename!
echo             .NotNull^(^)>>!filename!
echo             .Length^(36^)>>!filename!
echo             .MustAsync^(async ^(id, ct^) ^=^>>>!filename!
echo                 await db.Exists^<!tabelProper!^>^(id, ct^)^)>>!filename!
echo                 .WithMessage^("'Id' is not exists."^)^;>>!filename!
echo.>>!filename!
echo         RuleFor^(res ^=^> res.Name^)>>!filename!
echo             .NotEmpty^(^)>>!filename!
echo             .MaximumLength^(50^)>>!filename!
echo             .MustAsync^(async ^(res, name, ct^) ^=^>>>!filename!
echo                 await db.NotAny^<!tabelProper!^>^(x ^=^> x.Id !^=^= res.Id ^&^& x.Name ^=^= name, ct^)^)>>!filename!
echo                 .WithMessage^("'Name' is already used."^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Features\!plurar!\Mappers
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!Profile.cs
echo using !projectName!.Application.Features.!plurar!.Commands^;>!filename!
echo using !projectName!.Application.Features.!plurar!.Resources^;>>!filename!
echo.>>!filename!
echo namespace !projectName!.Application.Features.!plurar!.Mappers^;>>!filename!
echo.>>!filename!
echo public class !tabelProper!Profile : Profile>>!filename!
echo {>>!filename!
echo     public !tabelProper!Profile^(^)>>!filename!
echo     {>>!filename!
echo         CreateMap^<!tabelProper!, !tabelProper!Resource^>^(^)^;>>!filename!
echo.>>!filename!
echo         CreateMap^<Create!tabelProper!Command, !tabelProper!^>^(^)>>!filename!
echo             .ForMember^(dest ^=^> dest.CreatedById, opt ^=^> opt.MapFrom^(src ^=^> src.GetCreatedById^(^)^)^)^;>>!filename!
echo.>>!filename!
echo         CreateMap^<Update!tabelProper!Command, !tabelProper!^>^(^)>>!filename!
echo             .ForMember^(dest ^=^> dest.UpdatedById, opt ^=^> opt.MapFrom^(src ^=^> src.GetUpdatedById^(^)^)^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Features\!plurar!\Queries
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\GetList!tabelProper!Query.cs
echo using !projectName!.Application.Features.!plurar!.Resources^;>!filename!
echo.>>!filename!
echo namespace !projectName!.Application.Features.!plurar!.Queries^;>>!filename!
echo.>>!filename!
echo public sealed record GetList!tabelProper!Query^(^) : IRequest^<List^<!tabelProper!Resource^>^>^;>>!filename!
echo.>>!filename!
echo public class GetList!tabelProper!QueryHandler : IRequestHandler^<GetList!tabelProper!Query, List^<!tabelProper!Resource^>^>>>!filename!
echo {>>!filename!
echo     private readonly IDataContext db^;>>!filename!
echo     private readonly IMapper mapper^;>>!filename!
echo.>>!filename!
echo     public GetList!tabelProper!QueryHandler^(IDataContext db, IMapper mapper^)>>!filename!
echo     {>>!filename!
echo         this.db ^= db^;>>!filename!
echo         this.mapper ^= mapper^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     public async Task^<List^<!tabelProper!Resource^>^> Handle^(GetList!tabelProper!Query request, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         return await db.GetQuery^<!tabelProper!^>^(^)>>!filename!
echo             .OrderBy^(x ^=^> x.Name^)>>!filename!
echo             .ProjectTo^<!tabelProper!Resource^>^(mapper.ConfigurationProvider^)>>!filename!
echo             .ToListAsync^(cancellationToken^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Features\!plurar!\Queries
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\GetStamp!tabelProper!Query.cs
echo namespace !projectName!.Application.Features.!plurar!.Queries^;>!filename!
echo.>>!filename!
echo public sealed record GetStamp!tabelProper!Query^(string Id^) : IRequest^<StampResource^>^;>>!filename!
echo.>>!filename!
echo public class GetStamp!tabelProper!Handler : IRequestHandler^<GetStamp!tabelProper!Query, StampResource^>>>!filename!
echo {>>!filename!
echo     private readonly IDataContext db^;>>!filename!
echo.>>!filename!
echo     public GetStamp!tabelProper!Handler^(IDataContext db^)>>!filename!
echo     {>>!filename!
echo         this.db ^= db^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     public async Task^<StampResource^> Handle^(GetStamp!tabelProper!Query request, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         return await Mixins.GetStamp^<!tabelProper!^>^(request.Id, db, cancellationToken^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!
echo.>>!filename!
echo public sealed class GetStamp!tabelProper!Validator : AbstractValidator^<GetStamp!tabelProper!Query^>>>!filename!
echo {>>!filename!
echo     public GetStamp!tabelProper!Validator^(IDataContext db^)>>!filename!
echo     {>>!filename!
echo         RuleFor^(res ^=^> res^).NotNull^(^)^;>>!filename!
echo         RuleFor^(res ^=^> res.Id^)>>!filename!
echo             .NotEmpty^(^)>>!filename!
echo             .Length^(36^)>>!filename!
echo             .MustAsync^(async ^(id, ct^) ^=^>>>!filename!
echo                 await db.Exists^<!tabelProper!^>^(id, ct^)^)>>!filename!
echo                 .WithMessage^("'Id' is not exists."^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Features\!plurar!\Queries
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\Get!tabelProper!ByIdQuery.cs
echo using !projectName!.Application.Features.!plurar!.Resources^;>!filename!
echo.>>!filename!
echo namespace !projectName!.Application.Features.!plurar!.Queries^;>>!filename!
echo.>>!filename!
echo public sealed record Get!tabelProper!ByIdQuery^(string Id^) : IRequest^<!tabelProper!Resource^>^;>>!filename!
echo.>>!filename!
echo public class Get!tabelProper!ByIdQueryHandler : IRequestHandler^<Get!tabelProper!ByIdQuery, !tabelProper!Resource^>>>!filename!
echo {>>!filename!
echo     private readonly IDataContext db^;>>!filename!
echo     private readonly IMapper mapper^;>>!filename!
echo.>>!filename!
echo     public Get!tabelProper!ByIdQueryHandler^(IDataContext db, IMapper mapper^)>>!filename!
echo     {>>!filename!
echo         this.db ^= db^;>>!filename!
echo         this.mapper ^= mapper^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     public async Task^<!tabelProper!Resource^> Handle^(Get!tabelProper!ByIdQuery request, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         return await db.GetQuery^<!tabelProper!^>^(^)>>!filename!
echo             .Where^(x ^=^> x.Id ^=^= request.Id^)>>!filename!
echo             .ProjectTo^<!tabelProper!Resource^>^(mapper.ConfigurationProvider^)>>!filename!
echo             .FirstOrDefaultAsync^(cancellationToken^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!
echo.>>!filename!
echo public sealed class Get!tabelProper!ByIdQueryValidator : AbstractValidator^<Get!tabelProper!ByIdQuery^>>>!filename!
echo {>>!filename!
echo     public Get!tabelProper!ByIdQueryValidator^(IDataContext db^)>>!filename!
echo     {>>!filename!
echo         RuleFor^(res ^=^> res^).NotNull^(^)^;>>!filename!
echo.>>!filename!
echo         RuleFor^(res ^=^> res.Id^)>>!filename!
echo             .NotEmpty^(^)>>!filename!
echo             .Length^(36^)>>!filename!
echo             .MustAsync^(async ^(id, ct^) ^=^>>>!filename!
echo                 await db.Exists^<!tabelProper!^>^(id, ct^)^)>>!filename!
echo                 .WithMessage^("'Id' is not exists."^)^; ^;>>!filename!
echo     }>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Features\!plurar!\Resources
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!Resource.cs
echo namespace !projectName!.Application.Features.!plurar!.Resources^;>!filename!
echo.>>!filename!
echo public sealed record !tabelProper!Resource^(string Id, string Name^)^;>>!filename!


SET folderpath=!basedir!\!projectName!.Application\Repositories
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\IDataContext.cs
if exist "!filename!" (
fart -C !filename! "public DbSet^<User^> User { get^; set^; }" "public DbSet^<!tabelProper!^> !tabelProper! { get^; set^; }\r\n    public DbSet^<User^> User { get^; set^; }" >nul
) else (
echo using Microsoft.EntityFrameworkCore.Storage^;>!filename!
echo.>>!filename!
echo namespace !projectName!.Application.Repositories^;>>!filename!
echo.>>!filename!
echo public interface IDataContext>>!filename!
echo {>>!filename!
echo   >>!filename!
echo     public DbSet^<Role^> Role { get^; set^; }>>!filename!
echo     public DbSet^<!tabelProper!^> !tabelProper! { get^; set^; }>>!filename!
echo     public DbSet^<User^> User { get^; set^; }>>!filename!
echo.>>!filename!
echo     >>!filename!
echo     DbSet^<TEntity^> Set^<TEntity^>^(^) where TEntity : class^;>>!filename!
echo     Task^<IDbContextTransaction^> BeginTransactionAsync^(CancellationToken cancellationToken ^= default^)^;>>!filename!
echo     Task^<int^> SaveChangesAsync^(CancellationToken cancellationToken ^= default^)^;>>!filename!
echo }>>!filename!
)


SET folderpath=!basedir!\!projectName!.Domain\Entities
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!.cs
echo namespace !projectName!.Domain.Entities^;>!filename!
echo.>>!filename!
echo public class !tabelProper! : IEntity>>!filename!
echo {>>!filename!
echo     public string Id { get^; set^; }>>!filename!
echo.>>!filename!
echo     public string Name { get^; set^; }>>!filename!
echo.>>!filename!
echo     public bool IsDeleted { get^; set^; }>>!filename!
echo     public DateTime? DateCreated { get^; set^; }>>!filename!
echo     public DateTime? DateUpdated { get^; set^; }>>!filename!
echo     public string CreatedById { get^; set^; }>>!filename!
echo     public string UpdatedById { get^; set^; }>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Persistence\Context
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\DataContext.cs
if exist "!filename!" (
fart -C !filename! "public DbSet^<User^> User { get^; set^; }" "public DbSet^<!tabelProper!^> !tabelProper! { get^; set^; }\r\n    public DbSet^<User^> User { get^; set^; }" >nul
) else (
echo namespace !projectName!.Persistence.Context^;>!filename!
echo.>>!filename!
echo public class DataContext : DbContext, IDataContext>>!filename!
echo {>>!filename!
echo     public DataContext^(DbContextOptions options^) : base^(options^) { }>>!filename!
echo.>>!filename!
echo  >>!filename!
echo     public DbSet^<Role^> Role { get^; set^; }>>!filename!
echo     public DbSet^<!tabelProper!^> !tabelProper! { get^; set^; }>>!filename!
echo     public DbSet^<User^> User { get^; set^; }>>!filename!
echo    >>!filename!
echo.>>!filename!
echo     public async Task^<IDbContextTransaction^> BeginTransactionAsync^(CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         return await Database.BeginTransactionAsync^(cancellationToken^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!
)


SET folderpath=!basedir!\!projectName!.WebApi\Controllers
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!Controller.cs
echo namespace !projectName!.WebApi.Controllers^;>!filename!
echo.>>!filename!
echo [Route^("!tabelProper!"^)]>>!filename!
echo [ApiController]>>!filename!
echo public class !tabelProper!Controller : ControllerBase>>!filename!
echo {>>!filename!
echo     private readonly IMediator mediator^;>>!filename!
echo.>>!filename!
echo     public !tabelProper!Controller^(IMediator mediator^)>>!filename!
echo     {>>!filename!
echo         this.mediator ^= mediator^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     [HttpGet]>>!filename!
echo     public async Task^<ActionResult^<List^<!tabelProper!Resource^>^>^> GetList^(CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         var request ^= new GetList!tabelProper!Query^(^)^;>>!filename!
echo         var response ^= await mediator.Send^(request, cancellationToken^)^;>>!filename!
echo         return Ok^(response^)^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     [HttpGet^("{id}"^)]>>!filename!
echo     public async Task^<ActionResult^<!tabelProper!Resource^>^> Get^(string id, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         var request ^= new Get!tabelProper!ByIdQuery^(id^)^;>>!filename!
echo         var response ^= await mediator.Send^(request, cancellationToken^)^;>>!filename!
echo         return Ok^(response^)^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     [HttpPost]>>!filename!
echo     public async Task^<ActionResult^<!tabelProper!Resource^>^> Create^([FromBody] Create!tabelProper!Command request, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         request.SetCreatedById^(null^)^;>>!filename!
echo         var response ^= await mediator.Send^(request, cancellationToken^)^;>>!filename!
echo.>>!filename!
echo         return CreatedAtAction^(nameof^(Get^), new { id ^= response.Id }, response^)^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     [HttpPut^("{id}"^)]>>!filename!
echo     public async Task^<ActionResult^<!tabelProper!Resource^>^> Update^(string id, [FromBody] Update!tabelProper!Command request, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         if ^(id !^=^= request.Id^)>>!filename!
echo             throw new BadRequestException^("Wrong Id."^)^;>>!filename!
echo.>>!filename!
echo         request.SetUpdatedById^(null^)^;>>!filename!
echo         var response ^= await mediator.Send^(request, cancellationToken^)^;>>!filename!
echo.>>!filename!
echo         return Ok^(response^)^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     [HttpDelete^("{id}"^)]>>!filename!
echo     public async Task^<ActionResult^> Delete^(string id, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         var request ^= new Delete!tabelProper!Command^(id^)^;>>!filename!
echo         request.SetDeletedById^(null^)^;>>!filename!
echo         await mediator.Send^(request, cancellationToken^)^;>>!filename!
echo.>>!filename!
echo         return NoContent^(^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.WebApi
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\GlobalUsing.cs
if exist "!filename!" (
fart -C !filename! "global using AspNetCoreRateLimit^;" "global using AspNetCoreRateLimit^;\r\nglobal using ImportTrackingInventory.Application.Features.!plurar!.Commands^;\r\nglobal using ImportTrackingInventory.Application.Features.!plurar!.Queries^;\r\nglobal using ImportTrackingInventory.Application.Features.!plurar!.Resources^;" >nul
) else (
echo global using AspNetCoreRateLimit^;>!filename!
echo global using ImportTrackingInventory.Application.Features.!plural!.Commands^;>>!filename!
echo global using ImportTrackingInventory.Application.Features.!plural!.Queries^;>>!filename!
echo global using ImportTrackingInventory.Application.Features.!plural!.Resources^;>>!filename!
echo global using ImportTrackingInventory.Domain.Exceptions^;>>!filename!
echo global using ImportTrackingInventory.WebApi.Extensions^;>>!filename!
echo global using MediatR^;>>!filename!
echo global using Microsoft.AspNetCore.Diagnostics^;>>!filename!
echo global using Microsoft.AspNetCore.Mvc^;>>!filename!
echo global using Newtonsoft.Json^;>>!filename!
echo global using System.Net^;>>!filename!)

)

REM ###############################################################################################################

if %architecture%==services (
SET folderpath=!basedir!\!projectName!.Application\Repositories
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\IDataContext.cs
if exist "!filename!" (
fart -C !filename! "public DbSet^<User^> User { get^; set^; }" "public DbSet^<!tabelProper!^> !tabelProper! { get^; set^; }\r\n    public DbSet^<User^> User { get^; set^; }" >nul
) else (
echo using Microsoft.EntityFrameworkCore.Storage^;>!filename!
echo.>>!filename!
echo namespace !projectName!.Application.Repositories^;>>!filename!
echo.>>!filename!
echo public interface IDataContext>>!filename!
echo {>>!filename!
echo     public DbSet^<Role^> Role { get^; set^; }>>!filename!
echo     public DbSet^<RolePrivilege^> RolePrivilege { get^; set^; }>>!filename!
echo     public DbSet^<!tabelProper!^> !tabelProper! { get^; set^; }>>!filename!
echo     public DbSet^<User^> User { get^; set^; }>>!filename!
echo     public DbSet^<UserWarehouse^> UserWarehouse { get^; set^; }>>!filename!
echo     public DbSet^<Warehouse^> Warehouse { get^; set^; }>>!filename!
echo.>>!filename!
echo     DbSet^<TEntity^> Set^<TEntity^>^(^) where TEntity : class^;>>!filename!
echo     Task^<IDbContextTransaction^> BeginTransactionAsync^(CancellationToken cancellationToken ^= default^)^;>>!filename!
echo     Task^<int^> SaveChangesAsync^(CancellationToken cancellationToken ^= default^)^;>>!filename!
echo }>>!filename!
)

SET folderpath=!basedir!\!projectName!.Application\Services\!plurar!\Mappers
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!Mapper.cs
echo using !projectName!.Application.Services.!plurar!.Resources^;>!filename!
echo.>>!filename!
echo namespace !projectName!.Application.Services.!plurar!.Mappers^;>>!filename!
echo.>>!filename!
echo public class !tabelProper!Mapper : Profile>>!filename!
echo {>>!filename!
echo     public !tabelProper!Mapper^(^)>>!filename!
echo     {>>!filename!
echo         CreateMap^<!tabelProper!, !tabelProper!Response^>^(^)^;>>!filename!
echo.>>!filename!
echo         CreateMap^<Create!tabelProper!Request, !tabelProper!^>^(^)^;>>!filename!
echo.>>!filename!
echo         CreateMap^<Update!tabelProper!Request, !tabelProper!^>^(^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Services\!plurar!\Resources
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\Create!tabelProper!Request.cs
echo namespace !projectName!.Application.Services.!plurar!.Resources^;>!filename!
echo.>>!filename!
echo public sealed record Create!tabelProper!Request^(^)^;>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Services\!plurar!\Resources
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\GetAll!tabelProper!Parameter.cs
echo namespace !projectName!.Application.Services.!plurar!.Resources^;>!filename!
echo.>>!filename!
echo public record GetAll!tabelProper!Parameter^(string Keyword ^= null^)^;>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Services\!plurar!\Resources
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!Response.cs
echo namespace !projectName!.Application.Services.!plurar!.Resources^;>!filename!
echo.>>!filename!
echo public sealed record !tabelProper!Response^(>>!filename!
echo     string Id^)^;>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Services\!plurar!\Resources
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\Update!tabelProper!Request.cs
echo namespace !projectName!.Application.Services.!plurar!.Resources^;>!filename!
echo.>>!filename!
echo public sealed record Update!tabelProper!Request^(>>!filename!
echo     string Id^)^;>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Services\!plurar!\Validators
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\Create!tabelProper!Validator.cs
echo using !projectName!.Application.Services.!plurar!.Resources^;>!filename!
echo.>>!filename!
echo namespace !projectName!.Application.Services.!plurar!.Validators^;>>!filename!
echo.>>!filename!
echo public class Create!tabelProper!Validator : AbstractValidator^<Create!tabelProper!Request^>>>!filename!
echo {>>!filename!
echo     public Create!tabelProper!Validator^(IDataContext db^)>>!filename!
echo     {>>!filename!
echo         RuleFor^(x ^=^> x^).NotNull^(^)^;>>!filename!
echo.>>!filename!
echo         // RuleFor^(x ^=^> x.Name^)>>!filename!
echo         //     .NotEmpty^(^)>>!filename!
echo         //     .MaximumLength^(50^)>>!filename!
echo         //     .MustAsync^(async ^(name, ct^) ^=^>>>!filename!
echo         //         await db.NotAny^<!tabelProper!^>^(x ^=^> x.Name ^=^= name, ct^)^)>>!filename!
echo         //     .WithMessage^("'Name' is already used."^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Services\!plurar!\Validators
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\Update!tabelProper!Validator.cs
echo using !projectName!.Application.Services.!plurar!.Resources^;>!filename!
echo.>>!filename!
echo namespace !projectName!.Application.Services.!plurar!.Validators^;>>!filename!
echo.>>!filename!
echo public class Update!tabelProper!Validator : AbstractValidator^<Update!tabelProper!Request^>>>!filename!
echo {>>!filename!
echo     public Update!tabelProper!Validator^(IDataContext db^)>>!filename!
echo     {>>!filename!
echo         RuleFor^(x ^=^> x^).NotNull^(^)^;>>!filename!
echo.>>!filename!
echo         RuleFor^(x ^=^> x.Id^)>>!filename!
echo             .NotEmpty^(^)>>!filename!
echo             .Length^(36^)>>!filename!
echo             .MustAsync^(async ^(id, ct^) ^=^>>>!filename!
echo                 await db.Exists^<!tabelProper!^>^(id, ct^)^)>>!filename!
echo             .WithMessage^("'Id' is not exists."^)^;>>!filename!
echo.>>!filename!
echo         // RuleFor^(x ^=^> x.Name^)>>!filename!
echo         //     .NotEmpty^(^)>>!filename!
echo         //     .MaximumLength^(50^)>>!filename!
echo         //     .MustAsync^(async ^(res, name, ct^) ^=^>>>!filename!
echo         //         await db.NotAny^<!tabelProper!^>^(x ^=^> x.Id !^= res.Id ^&^& x.Name ^=^= name, ct^)^)>>!filename!
echo         //     .WithMessage^("'Name' is already used."^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Services\!plurar!
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\I!tabelProper!Service.cs
echo using !projectName!.Application.Services.!plurar!.Resources^;>!filename!
echo.>>!filename!
echo namespace !projectName!.Application.Services.!plurar!^;>>!filename!
echo.>>!filename!
echo public interface I!tabelProper!Service>>!filename!
echo {>>!filename!
echo     Task^<!tabelProper!Response^> Get^(string id, CancellationToken cancellationToken^)^;>>!filename!
echo.>>!filename!
echo     Task^<List^<!tabelProper!Response^>^> GetAll^(GetAll!tabelProper!Parameter param,>>!filename!
echo         CancellationToken cancellationToken^)^;>>!filename!
echo.>>!filename!
echo     Task^<StampResponse^> GetStamp^(string id, CancellationToken cancellationToken^)^;>>!filename!
echo     Task^<string^> Create^(Create!tabelProper!Request request, string createdById, CancellationToken cancellationToken^)^;>>!filename!
echo     Task^<string^> Update^(Update!tabelProper!Request request, string updatedById, CancellationToken cancellationToken^)^;>>!filename!
echo     Task Delete^(string id, string deletedById, CancellationToken cancellationToken^)^;>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Application\Services\!plurar!
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!Service.cs
echo using !projectName!.Application.Services.!plurar!.Resources^;>!filename!
echo.>>!filename!
echo namespace !projectName!.Application.Services.!plurar!^;>>!filename!
echo.>>!filename!
echo public class !tabelProper!Service : I!tabelProper!Service>>!filename!
echo {>>!filename!
echo     private readonly IDataContext db^;>>!filename!
echo     private readonly IMapper mapper^;>>!filename!
echo.>>!filename!
echo     public !tabelProper!Service^(IDataContext db, IMapper mapper^)>>!filename!
echo     {>>!filename!
echo         this.db ^= db^;>>!filename!
echo         this.mapper ^= mapper^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     public async Task^<!tabelProper!Response^> Get^(string id, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         return await db.GetQuery^<!tabelProper!^>^(^)>>!filename!
echo             .Where^(x ^=^> x.Id ^=^= id^)>>!filename!
echo             .ProjectTo^<!tabelProper!Response^>^(mapper.ConfigurationProvider^)>>!filename!
echo             .FirstOrDefaultAsync^(cancellationToken^)^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     public async Task^<List^<!tabelProper!Response^>^> GetAll^(GetAll!tabelProper!Parameter param,>>!filename!
echo         CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         var query ^= db.GetQuery^<!tabelProper!^>^(^)^;>>!filename!
echo.>>!filename!
echo         // if ^(param.Keyword.IsNotEmpty^(^)^)>>!filename!
echo         //     query ^= query.Where^(x ^=^> x.Name.Contains^(param.Keyword^)^)^;>>!filename!
echo.>>!filename!
echo         return await query>>!filename!
echo         //     .OrderBy^(x ^=^> x.Name^)>>!filename!
echo         .ProjectTo^<!tabelProper!Response^>^(mapper.ConfigurationProvider^)>>!filename!
echo         .ToListAsync^(cancellationToken^)^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     public async Task^<StampResponse^> GetStamp^(string id, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         return await Mixins.GetStamp^<!tabelProper!^>^(id, db, cancellationToken^)^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     public async Task^<string^> Create^(Create!tabelProper!Request request, string createdById,>>!filename!
echo         CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         var category ^= mapper.Map^<!tabelProper!^>^(request^)^;>>!filename!
echo         await db.Create^(category, createdById, cancellationToken^)^;>>!filename!
echo         await db.SaveChangesAsync^(cancellationToken^)^;>>!filename!
echo.>>!filename!
echo         return category.Id^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     public async Task^<string^> Update^(Update!tabelProper!Request request, string updatedById,>>!filename!
echo         CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         var category ^= await db.Get^<!tabelProper!^>^(request.Id, cancellationToken^)^;>>!filename!
echo         mapper.Map^(request, category^)^;>>!filename!
echo         db.Update^(category, updatedById^)^;>>!filename!
echo         await db.SaveChangesAsync^(cancellationToken^)^;>>!filename!
echo.>>!filename!
echo         return category.Id^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     public async Task Delete^(string id, string deletedById, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         await db.Delete^<!tabelProper!^>^(id, deletedById, cancellationToken^)^;>>!filename!
echo         await db.SaveChangesAsync^(cancellationToken^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Application
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\ServiceCollectionExtensions.cs
if exist "!filename!" (
fart -C !filename! "services.AddScoped^<IUserService, UserService^>^(^)^;" "services.AddScoped^<I!tabelProper!, !tabelProper!^>^(^)^;\r\n        services.AddScoped^<IUserService, UserService^>^(^)^;" >nul
) else (
echo using System.Reflection^;>!filename!
echo using FluentValidation.AspNetCore^;>>!filename!
echo.>>!filename!
echo using !projectName!.Application.Services.Roles^;>>!filename!
echo using !projectName!.Application.Services.!plurar!^;>>!filename!
echo using Microsoft.Extensions.DependencyInjection^;>>!filename!
echo using !projectName!.Application.Services.Users^;>>!filename!
echo.>>!filename!
echo namespace !projectName!.Application^;>>!filename!
echo.>>!filename!
echo public static class ServiceCollectionExtensions>>!filename!
echo {>>!filename!
echo     public static void AddApplication^(this IServiceCollection services^)>>!filename!
echo     {>>!filename!
echo         services.AddAutoMapper^(Assembly.GetExecutingAssembly^(^)^)^;>>!filename!
echo         services.AddFluentValidation^(x ^=^> x.RegisterValidatorsFromAssembly^(Assembly.GetExecutingAssembly^(^)^)^)^;>>!filename!
echo.>>!filename!
echo         services.AddScoped^<IRoleService, RoleService^>^(^)^;>>!filename!
echo         services.AddScoped^<I!tabelProper!Service, !tabelProper!Service^>^(^)^;>>!filename!
echo         services.AddScoped^<IUserService, UserService^>^(^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!
)

SET folderpath=!basedir!\!projectName!.Domain\Entities
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!.cs
echo namespace !projectName!.Domain.Entities^;>!filename!
echo.>>!filename!
echo public class !tabelProper! : IEntity>>!filename!
echo {>>!filename!
echo     public string Id { get^; set^; }>>!filename!
echo.>>!filename!
echo     public bool IsDeleted { get^; set^; }>>!filename!
echo     public DateTime? DateCreated { get^; set^; }>>!filename!
echo     public DateTime? DateUpdated { get^; set^; }>>!filename!
echo     public string CreatedById { get^; set^; }>>!filename!
echo     public string UpdatedById { get^; set^; }>>!filename!
echo }>>!filename!

SET folderpath=!basedir!\!projectName!.Persistence\Context
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\DataContext.cs
if exist "!filename!" (
fart -C !filename! "public DbSet^<User^> User { get^; set^; }" "public DbSet^<!tabelProper!^> !tabelProper! { get^; set^; }\r\n    public DbSet^<User^> User { get^; set^; }" >nul
) else (
echo namespace !projectName!.Persistence.Context^;>!filename!
echo.>>!filename!
echo public class DataContext : DbContext, IDataContext>>!filename!
echo {>>!filename!
echo     public DataContext^(DbContextOptions options^) : base^(options^)>>!filename!
echo     {>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     public DbSet^<Role^> Role { get^; set^; }>>!filename!
echo     public DbSet^<RolePrivilege^> RolePrivilege { get^; set^; }>>!filename!
echo     public DbSet^<!tabelProper!^> !tabelProper! { get^; set^; }>>!filename!
echo     public DbSet^<User^> User { get^; set^; }>>!filename!
echo     public DbSet^<UserWarehouse^> UserWarehouse { get^; set^; }>>!filename!
echo     public DbSet^<Warehouse^> Warehouse { get^; set^; }>>!filename!
echo.>>!filename!
echo     public async Task^<IDbContextTransaction^> BeginTransactionAsync^(CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         return await Database.BeginTransactionAsync^(cancellationToken^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!
)

SET folderpath=!basedir!\!projectName!.WebApi\Controllers
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!Controller.cs
echo using !projectName!.Application.Services.!plurar!^;>!filename!
echo using !projectName!.Application.Services.!plurar!.Resources^;>>!filename!
echo.>>!filename!
echo namespace !projectName!.WebApi.Controllers^;>>!filename!
echo.>>!filename!
echo [Route^("!tabelStrip!"^)]>>!filename!
echo [ApiController]>>!filename!
echo public class !tabelProper!Controller : ControllerBase>>!filename!
echo {>>!filename!
echo     private readonly I!tabelProper!Service !tabelSnake!Service^;>>!filename!
echo.>>!filename!
echo     public !tabelProper!Controller^(I!tabelProper!Service !tabelSnake!Service^)>>!filename!
echo     {>>!filename!
echo         this.!tabelSnake!Service ^= !tabelSnake!Service^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     [HttpGet]>>!filename!
echo     public async Task^<ActionResult^<List^<!tabelProper!Response^>^>^> GetAll^(GetAll!tabelProper!Parameter param,>>!filename!
echo         CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         var response ^= await !tabelSnake!Service.GetAll^(param, cancellationToken^)^;>>!filename!
echo         return Ok^(response^)^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     [HttpGet^("{id}"^)]>>!filename!
echo     public async Task^<ActionResult^<!tabelProper!Response^>^> Get^(string id, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         var response ^= await !tabelSnake!Service.Get^(id, cancellationToken^)^;>>!filename!
echo         return Ok^(response^)^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     [HttpGet^("stamp/{id}"^)]>>!filename!
echo     public async Task^<ActionResult^<!tabelProper!Response^>^> GetStamp^(string id, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         var response ^= await !tabelSnake!Service.GetStamp^(id, cancellationToken^)^;>>!filename!
echo         return Ok^(response^)^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     [HttpPost]>>!filename!
echo     public async Task^<ActionResult^<!tabelProper!Response^>^> Create^([FromBody] Create!tabelProper!Request request,>>!filename!
echo         CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         var responseId ^= await !tabelSnake!Service.Create^(request, this.GetUserId^(^), cancellationToken^)^;>>!filename!
echo         var response!tabelProper! ^= await !tabelSnake!Service.Get^(responseId, cancellationToken^)^;>>!filename!
echo.>>!filename!
echo         return CreatedAtAction^(nameof^(Get^), new {id ^= responseId}, response!tabelProper!^)^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     [HttpPut^("{id}"^)]>>!filename!
echo     public async Task^<ActionResult^<!tabelProper!Response^>^> Update^(string id, [FromBody] Update!tabelProper!Request request,>>!filename!
echo         CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         if ^(id ^^!^= request.Id^)>>!filename!
echo             throw new BadRequestException^("Wrong Id."^)^;>>!filename!
echo.>>!filename!
echo         var responseId ^= await !tabelSnake!Service.Update^(request, this.GetUserId^(^), cancellationToken^)^;>>!filename!
echo         var response!tabelProper! ^= await !tabelSnake!Service.Get^(responseId, cancellationToken^)^;>>!filename!
echo.>>!filename!
echo         return Ok^(response!tabelProper!^)^;>>!filename!
echo     }>>!filename!
echo.>>!filename!
echo     [HttpDelete^("{id}"^)]>>!filename!
echo     public async Task^<ActionResult^> Delete^(string id, CancellationToken cancellationToken^)>>!filename!
echo     {>>!filename!
echo         await !tabelSnake!Service.Delete^(id, this.GetUserId^(^), cancellationToken^)^;>>!filename!
echo.>>!filename!
echo         return NoContent^(^)^;>>!filename!
echo     }>>!filename!
echo }>>!filename!

)

REM ###############################################################################################################

if %architecture%==vuetify (
if %pilihan% EQU 2 (
SET folderpath=!basedir!\!projectName!.WebApp\src\api
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!Api.js
echo import http from "./http"^;>!filename!
echo.>>!filename!
echo const !tabelProper!Api ^= {>>!filename!
echo     endPoint: "!tabelStrip!",>>!filename!
echo.>>!filename!
echo     async getList^(^) {>>!filename!
echo         const response ^= await http.get^(this.endPoint^)^;>>!filename!
echo         return response.data^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async getStamp^(id^) {>>!filename!
echo         const response ^= await http.get^(this.endPoint + `/stamp/${id}`^)^;>>!filename!
echo         return response.data^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async get^(id^) {>>!filename!
echo         const response ^= await http.get^(this.endPoint + `/${id}`^)^;>>!filename!
echo         return response.data^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async create^(resource^) {>>!filename!
echo         const response ^= await http.post^(this.endPoint, resource^)^;>>!filename!
echo         return response.data^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async update^(resource^) {>>!filename!
echo         const response ^= await http.put^(this.endPoint + `/${resource.id}`, resource^)^;>>!filename!
echo         return response.data^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async delete^(id^) {>>!filename!
echo         await http.delete^(this.endPoint + `/${id}`^)^;>>!filename!
echo     }>>!filename!
echo }^;>>!filename!
echo.>>!filename!
echo export default !tabelProper!Api^;>>!filename!
echo.>>!filename!

SET folderpath=!basedir!\!projectName!.WebApp\src\router
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\index.js
if exist "!filename!" (
fart -C !filename! "import Role from \"@src/views/master-data/Role.vue\"^;" "import !tabelProper! from \"@src/views/master-data/!tabelProper!.vue\"^;\r\nimport Role from \"@src/views/master-data/Role.vue\"^;" >nul
fart -C !filename! "children: [" "children: [{\r\n        path: \"!tabelStrip!\",\r\n        component: !tabelProper!,\r\n      }," >nul
) else (
echo import Vue from "vue"^;>!filename!
echo import VueRouter from "vue-router"^;>>!filename!
echo import AppLayout from "@src/layouts/AppLayout.vue">>!filename!
echo import Login from "@src/views/Login.vue"^;>>!filename!
echo import Home from "@src/views/Home.vue"^;>>!filename!
echo import !tabelProper! from "@src/views/master-data/!tabelProper!.vue"^;>>!filename!
echo import Role from "@src/views/master-data/Role.vue"^;>>!filename!
echo.>>!filename!
echo Vue.use^(VueRouter^)^;>>!filename!
echo.>>!filename!
echo const routes ^= [>>!filename!
echo     {>>!filename!
echo         path: "/",>>!filename!
echo         component: AppLayout,>>!filename!
echo         children: [>>!filename!
echo             {>>!filename!
echo                 path: "",>>!filename!
echo                 component: Home>>!filename!
echo             },>>!filename!
echo             {>>!filename!
echo                 path: "!tabelSnake!",>>!filename!
echo                 component: !tabelProper!>>!filename!
echo             },>>!filename!
echo             {>>!filename!
echo                 path: "role",>>!filename!
echo                 component: Role>>!filename!
echo             },>>!filename!
echo         ]>>!filename!
echo     },>>!filename!
echo     {>>!filename!
echo         path: "/login",>>!filename!
echo         component: Login>>!filename!
echo     },>>!filename!
echo ]^;>>!filename!
echo.>>!filename!
echo const router ^= new VueRouter^({>>!filename!
echo     routes>>!filename!
echo }^)^;>>!filename!
echo.>>!filename!
echo export default router^;>>!filename!
)

SET folderpath=!basedir!\!projectName!.WebApp\src\views\master-data
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!.vue
echo ^<template^>>!filename!
echo   ^<div^>>>!filename!
echo     ^<div class^="orange lighten-5 pt-3 pl-5"^>>>!filename!
echo       ^<v-row align^="center" dense^>>>!filename!
echo         ^<v-col cols^="12" md^="4"^>>>!filename!
echo           ^<h1 class^="text-h5"^>>>!filename!
echo             ^<v-icon class^="pr-2" color^="deep-orange" x-large^>mdi-store-marker-outline^</v-icon^>>>!filename!
echo             !tabelProper!>>!filename!
echo           ^</h1^>>>!filename!
echo         ^</v-col^>>>!filename!
echo         ^<v-col class^="d-none d-md-flex pr-6" cols^="12" md^="8"^>>>!filename!
echo           ^<v-spacer^>^</v-spacer^>>>!filename!
echo           ^<v-breadcrumbs :items^="breadcrumbs"^>>>!filename!
echo             ^<template v-slot:divider^>>>!filename!
echo               ^<v-icon^>mdi-chevron-right^</v-icon^>>>!filename!
echo             ^</template^>>>!filename!
echo           ^</v-breadcrumbs^>>>!filename!
echo         ^</v-col^>>>!filename!
echo       ^</v-row^>>>!filename!
echo     ^</div^>>>!filename!
echo.>>!filename!
echo     ^<div class^="ma-7"^>>>!filename!
echo       ^<v-row^>>>!filename!
echo         ^<v-col cols^="12" lg^="9" md^="8"^>>>!filename!
echo           ^<v-slide-group^>>>!filename!
echo             ^<div class^="mb-5"^>>>!filename!
echo               ^<v-slide-item class^="mr-2"^>>>!filename!
echo                 ^<v-btn color^="primary" @click^="create()"^>>>!filename!
echo                   ^<v-icon left^>mdi-plus^</v-icon^>>>!filename!
echo                   Create New !tabelProper!>>!filename!
echo                 ^</v-btn^>>>!filename!
echo               ^</v-slide-item^>>>!filename!
echo               ^<v-slide-item class^="mr-2"^>>>!filename!
echo                 ^<v-btn @click^="download()"^>>>!filename!
echo                   ^<v-icon left^>mdi-download^</v-icon^>>>!filename!
echo                   Download>>!filename!
echo                 ^</v-btn^>>>!filename!
echo               ^</v-slide-item^>>>!filename!
echo             ^</div^>>>!filename!
echo           ^</v-slide-group^>>>!filename!
echo         ^</v-col^>>>!filename!
echo         ^<v-col cols^="12" lg^="3" md^="4"^>>>!filename!
echo           ^<v-text-field>>!filename!
echo               v-model^="search">>!filename!
echo               append-icon^="mdi-magnify">>!filename!
echo               class^="pb-3">>!filename!
echo               dense>>!filename!
echo               hide-details>>!filename!
echo               label^="Search">>!filename!
echo               outlined>>!filename!
echo               single-line>>!filename!
echo           ^>^</v-text-field^>>>!filename!
echo         ^</v-col^>>>!filename!
echo       ^</v-row^>>>!filename!
echo.>>!filename!
echo       ^<v-card^>>>!filename!
echo         ^<v-data-table>>!filename!
echo             :headers^="headers">>!filename!
echo             :items^="datasource">>!filename!
echo             :items-per-page^="10">>!filename!
echo             :loading^="loading">>!filename!
echo             :search^="search">>!filename!
echo         ^>>>!filename!
echo           ^<template v-slot:item.action^="{ item }"^>>>!filename!
echo             ^<v-menu^>>>!filename!
echo               ^<template v-slot:activator^="{ attrs, on }"^>>>!filename!
echo                 ^<v-btn icon^>>>!filename!
echo                   ^<v-icon v-bind^="attrs" v-on^="on"^>mdi-dots-horizontal^</v-icon^>>>!filename!
echo                 ^</v-btn^>>>!filename!
echo               ^</template^>>>!filename!
echo               ^<v-list^>>>!filename!
echo                 ^<v-list-item>>!filename!
echo                     class^="grey--text text--darken-1 text-caption">>!filename!
echo                     dense>>!filename!
echo                     link>>!filename!
echo                     @click^="update(item)">>!filename!
echo                 ^>>>!filename!
echo                   ^<v-icon class^="pr-2" small^>mdi-pencil^</v-icon^>>>!filename!
echo                   UPDATE>>!filename!
echo                 ^</v-list-item^>>>!filename!
echo                 ^<v-list-item>>!filename!
echo                     class^="red--text text--darken-1 text-caption">>!filename!
echo                     color^="grey">>!filename!
echo                     dense>>!filename!
echo                     link>>!filename!
echo                     @click^="remove(item)">>!filename!
echo                 ^>>>!filename!
echo                   ^<v-icon class^="pr-2" color^="red" small^>mdi-delete^</v-icon^>>>!filename!
echo                   REMOVE>>!filename!
echo                 ^</v-list-item^>>>!filename!
echo               ^</v-list^>>>!filename!
echo             ^</v-menu^>>>!filename!
echo           ^</template^>>>!filename!
echo         ^</v-data-table^>>>!filename!
echo       ^</v-card^>>>!filename!
echo     ^</div^>>>!filename!
echo.>>!filename!
echo     ^<v-dialog v-model^="dialog" persistent width^="400px"^>>>!filename!
echo       ^<v-card :disabled^="loading"^>>>!filename!
echo         ^<div class^="pa-5 text-h6"^>>>!filename!
echo           ^<v-icon color^="deep-orange" large^>mdi-file-edit^</v-icon^>>>!filename!
echo           {{ mode ^=^=^= "create" ? "Create" : "Update" }} !tabelProper!>>!filename!
echo         ^</div^>>>!filename!
echo.>>!filename!
echo         ^<div class^="px-5"^>>>!filename!
echo           ^<v-text-field v-model^="resource.code" dense label^="Code" outlined^>^</v-text-field^>>>!filename!
echo           ^<v-text-field v-model^="resource.name" dense label^="Name" outlined^>^</v-text-field^>>>!filename!
echo         ^</div^>>>!filename!
echo.>>!filename!
echo         ^<v-divider^>^</v-divider^>>>!filename!
echo.>>!filename!
echo         ^<div class^="pa-3 text-right"^>>>!filename!
echo           ^<v-btn class^="mr-2" text @click^="dialog = false"^>>>!filename!
echo             ^<v-icon left^>mdi-close^</v-icon^>>>!filename!
echo             CANCEL>>!filename!
echo           ^</v-btn^>>>!filename!
echo           ^<v-btn :loading^="loading" color^="primary" min-width^="110px" @click^="save()"^>>>!filename!
echo             ^<v-icon left^>mdi-check^</v-icon^>>>!filename!
echo             SAVE>>!filename!
echo           ^</v-btn^>>>!filename!
echo         ^</div^>>>!filename!
echo       ^</v-card^>>>!filename!
echo     ^</v-dialog^>>>!filename!
echo     ^<ConfirmationDialog ref^="confirmationDialog"/^>>>!filename!
echo     ^<DeleteDialog ref^="deleteDialog"/^>>>!filename!
echo     ^<InformationDialog ref^="informationDialog"/^>>>!filename!
echo     ^<LoadingDialog ref^="loadingDialog"/^>>>!filename!
echo     ^<Snackbar ref^="snackbar"/^>>>!filename!
echo   ^</div^>>>!filename!
echo ^</template^>>>!filename!
echo.>>!filename!
echo ^<script^>>>!filename!
echo import !tabelSnake!Api from "@src/api/!tabelProper!Api"^;>>!filename!
echo.>>!filename!
echo export default {>>!filename!
echo   name: "!tabelProper!",>>!filename!
echo.>>!filename!
echo   data^(^) {>>!filename!
echo     return {>>!filename!
echo       breadcrumbs: [>>!filename!
echo         {text: "Home", disabled: false, href: "#/"},>>!filename!
echo         {text: "Master Data", disabled: false, href: "#/master-data"},>>!filename!
echo         {text: "!tabelProper!", disabled: true, href: "#/!tabelStrip!"},>>!filename!
echo       ],>>!filename!
echo       headers: [>>!filename!
echo         {text: "", value: "action", width: 75, sortable: false},>>!filename!
echo         {text: "Code", value: "code"},>>!filename!
echo         {text: "Name", value: "name"},>>!filename!
echo       ],>>!filename!
echo       datasource: [],>>!filename!
echo       resource: {},>>!filename!
echo       search: "",>>!filename!
echo       dialog: false,>>!filename!
echo       loading: false,>>!filename!
echo       mode: "create",>>!filename!
echo     }^;>>!filename!
echo   },>>!filename!
echo.>>!filename!
echo   async mounted^(^) {>>!filename!
echo     this.loading ^= true^;>>!filename!
echo.>>!filename!
echo     document.title ^= "Inventory | !tabelProper!"^;>>!filename!
echo.>>!filename!
echo     this.datasource ^= await !tabelSnake!Api.getList^(^)^;>>!filename!
echo.>>!filename!
echo     this.loading ^= false^;>>!filename!
echo   },>>!filename!
echo.>>!filename!
echo   methods: {>>!filename!
echo     download^(^) {>>!filename!
echo       this.downloadExcel^(this.datasource, "!tabelSnake!.xlsx"^)^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     create^(^) {>>!filename!
echo       this.mode ^= "create"^;>>!filename!
echo       this.resource ^= {>>!filename!
echo         id: "",>>!filename!
echo         code: "",>>!filename!
echo         name: "",>>!filename!
echo       }^;>>!filename!
echo       this.dialog ^= true^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     update^(item^) {>>!filename!
echo       this.mode ^= "update"^;>>!filename!
echo       this.resource ^= {>>!filename!
echo         id: item.id,>>!filename!
echo         code: item.code,>>!filename!
echo         name: item.name,>>!filename!
echo       }^;>>!filename!
echo       this.dialog ^= true^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async remove^(item^) {>>!filename!
echo       const res ^= await this.$refs.deleteDialog.show^(>>!filename!
echo           `Are you sure to remove !tabelSnake!: ${item.code}?`>>!filename!
echo       ^)^;>>!filename!
echo       if ^(res^) {>>!filename!
echo         try {>>!filename!
echo           this.loading ^= true^;>>!filename!
echo           await !tabelSnake!Api.delete^(item.id^)^;>>!filename!
echo           this.$refs.snackbar.show^("Data removed successfully."^)^;>>!filename!
echo.>>!filename!
echo           this.loading ^= false^;>>!filename!
echo         } catch ^(error^) {>>!filename!
echo           this.loading ^= false^;>>!filename!
echo           this.$refs.snackbar.showError^(error^)^;>>!filename!
echo         }>>!filename!
echo       }>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async save^(^) {>>!filename!
echo       try {>>!filename!
echo         this.loading ^= true^;>>!filename!
echo.>>!filename!
echo         if ^(this.mode ^=^=^= "create"^)>>!filename!
echo           await !tabelSnake!Api.create^(this.resource^)^;>>!filename!
echo         else if ^(this.mode ^=^=^= "update"^)>>!filename!
echo           await !tabelSnake!Api.update^(this.resource^)^;>>!filename!
echo.>>!filename!
echo         this.datasource ^= await !tabelSnake!Api.getList^(^)^;>>!filename!
echo.>>!filename!
echo         this.$refs.snackbar.show^("Data saved successfully."^)^;>>!filename!
echo         this.dialog ^= false^;>>!filename!
echo         this.loading ^= false^;>>!filename!
echo       } catch ^(error^) {>>!filename!
echo         this.loading ^= false^;>>!filename!
echo         this.$refs.snackbar.showError^(error^)^;>>!filename!
echo       }>>!filename!
echo     },>>!filename!
echo   },>>!filename!
echo }^;>>!filename!
echo ^</script^>>>!filename!

)



REM ###############################################################################################################

if %pilihan% EQU 3 (

if !tabelFileName!==!tabel! (
	set ismasterdata=true
	set istransaction=false
) else (
	set ismasterdata=false
	set istransaction=true
)

REM ###############################################################################################################

if !ismasterdata!==true (

SET folderpath=!basedir!\!projectName!.WebApp\src\views\master-data
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!.vue
echo ^<template^>>!filename!
echo   ^<div^>>>!filename!
echo     ^<div class^="orange lighten-5 pt-3 pl-5"^>>>!filename!
echo       ^<v-row align^="center" dense^>>>!filename!
echo         ^<v-col cols^="12" md^="4"^>>>!filename!
echo           ^<h1 class^="text-h5"^>>>!filename!
echo             ^<v-icon class^="pr-2" color^="deep-orange" x-large^>mdi-store-marker-outline^</v-icon^>>>!filename!
echo             !tabelSpace!>>!filename!
echo           ^</h1^>>>!filename!
echo         ^</v-col^>>>!filename!
echo         ^<v-col class^="d-none d-md-flex pr-6" cols^="12" md^="8"^>>>!filename!
echo           ^<v-spacer^>^</v-spacer^>>>!filename!
echo           ^<v-breadcrumbs :items^="breadcrumbs"^>>>!filename!
echo             ^<template v-slot:divider^>>>!filename!
echo               ^<v-icon^>mdi-chevron-right^</v-icon^>>>!filename!
echo             ^</template^>>>!filename!
echo           ^</v-breadcrumbs^>>>!filename!
echo         ^</v-col^>>>!filename!
echo       ^</v-row^>>>!filename!
echo     ^</div^>>>!filename!
echo.>>!filename!
echo     ^<div class^="ma-7"^>>>!filename!
echo       ^<v-row^>>>!filename!
echo         ^<v-col cols^="12" lg^="9" md^="8"^>>>!filename!
echo           ^<v-slide-group^>>>!filename!
echo             ^<div class^="mb-5"^>>>!filename!
echo               ^<v-slide-item class^="mr-2"^>>>!filename!
echo                 ^<v-btn color^="primary" @click^="create()"^>>>!filename!
echo                   ^<v-icon left^>mdi-plus^</v-icon^>>>!filename!
echo                   Create New !tabelSpace!>>!filename!
echo                 ^</v-btn^>>>!filename!
echo               ^</v-slide-item^>>>!filename!
echo               ^<v-slide-item class^="mr-2"^>>>!filename!
echo                 ^<v-btn @click^="download()"^>>>!filename!
echo                   ^<v-icon left^>mdi-download^</v-icon^>>>!filename!
echo                   Download>>!filename!
echo                 ^</v-btn^>>>!filename!
echo               ^</v-slide-item^>>>!filename!
echo             ^</div^>>>!filename!
echo           ^</v-slide-group^>>>!filename!
echo         ^</v-col^>>>!filename!
echo         ^<v-col cols^="12" lg^="3" md^="4"^>>>!filename!
echo           ^<v-text-field v-model^="search" append-icon^="mdi-magnify" class^="pb-3" dense hide-details label^="Search" outlined single-line^>^</v-text-field^>>>!filename!
echo         ^</v-col^>>>!filename!
echo       ^</v-row^>>>!filename!
echo.>>!filename!
echo       ^<v-card^>>>!filename!
echo         ^<v-data-table :headers^="headers" :items^="datasource" :items-per-page^="10" :loading^="loading" :search^="search"^>>>!filename!
echo           ^<template v-slot:item.action^="{ item }"^>>>!filename!
echo             ^<v-menu^>>>!filename!
echo               ^<template v-slot:activator^="{ attrs, on }"^>>>!filename!
echo                 ^<v-btn icon^>>>!filename!
echo                   ^<v-icon v-bind^="attrs" v-on^="on"^>mdi-dots-horizontal^</v-icon^>>>!filename!
echo                 ^</v-btn^>>>!filename!
echo               ^</template^>>>!filename!
echo               ^<v-list^>>>!filename!
echo                 ^<v-list-item class^="grey--text text--darken-1 text-caption" dense link @click^="update(item)"^>>>!filename!
echo                   ^<v-icon class^="pr-2" small^>mdi-pencil^</v-icon^>>>!filename!
echo                   UPDATE>>!filename!
echo                 ^</v-list-item^>>>!filename!
echo                 ^<v-list-item class^="red--text text--darken-1 text-caption" color^="grey" dense link @click^="remove(item)"^>>>!filename!
echo                   ^<v-icon class^="pr-2" color^="red" small^>mdi-delete^</v-icon^>>>!filename!
echo                   REMOVE>>!filename!
echo                 ^</v-list-item^>>>!filename!
echo               ^</v-list^>>>!filename!
echo             ^</v-menu^>>>!filename!
echo           ^</template^>>>!filename!
echo         ^</v-data-table^>>>!filename!
echo       ^</v-card^>>>!filename!
echo     ^</div^>>>!filename!
echo.>>!filename!
echo     ^<v-dialog v-model^="dialog" persistent width^="800px"^>>>!filename!
echo       ^<v-card :disabled^="loading"^>>>!filename!
echo         ^<div class^="pa-5 text-h6"^>>>!filename!
echo           ^<v-icon color^="deep-orange" large^>mdi-file-edit^</v-icon^>>>!filename!
echo           {{ mode ^=^=^= "create" ? "Create" : "Update" }} !tabelSpace!>>!filename!
echo         ^</div^>>>!filename!
echo.>>!filename!
echo         ^<div class^="px-5"^>>>!filename!
echo           ^<v-row align^="center"^>>>!filename!

set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldSnake=!field!
			CALL :SnakeCamel fieldSnake
			set fieldLow=!field!
			CALL :LoCase fieldLow
			CALL :FirstDown result !fieldSnake!
			set fieldSnake=!result!
			
			call :spaceTitleResult !field!
			set fieldSpace=!result!

			call :stripTitleResult !field!
			set fieldStrip=!result!
		)
REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
echo             ^<v-col class^="d-flex" cols^="12" sm^="12"^>>>!filename!
set fieldId=!field:~-2!
if ["!fieldId!"]==["Id"] (
	echo               ^<v-autocomplete v-model^="resource.!fieldSnake!" :items^="defaultDataSource" item-text^="nama" item-value^="id" label^="!fieldSpace!" dense outlined^>^</v-autocomplete^>>>!filename!
) else (
	if !tipeData!==DateTime (
		echo               ^<DateInput v-model^="resource.!fieldSnake!" label^="Document Date" dense outlined /^>>>!filename!
	) else if !tipeData!==DateTime? (
		echo               ^<DateInput v-model^="resource.!fieldSnake!" label^="Document Date" dense outlined /^>>>!filename!
	) else (
REM		if !tipeData!==String(
			echo             ^<v-text-field v-model^="resource.!fieldSnake!" dense label^="!fieldSpace!" outlined^>^</v-text-field^>>>!filename!
REM		)
	)
)
	echo             ^</v-col^>>>!filename!
)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)

)

echo           ^</v-row^>>>!filename!
echo         ^</div^>>>!filename!
echo.>>!filename!
echo         ^<v-divider^>^</v-divider^>>>!filename!
echo.>>!filename!
echo         ^<div class^="pa-3 text-right"^>>>!filename!
echo           ^<v-btn class^="mr-2" text @click^="dialog = false"^>>>!filename!
echo             ^<v-icon left^>mdi-close^</v-icon^>>>!filename!
echo             CANCEL>>!filename!
echo           ^</v-btn^>>>!filename!
echo           ^<v-btn :loading^="loading" color^="primary" min-width^="110px" @click^="save()"^>>>!filename!
echo             ^<v-icon left^>mdi-check^</v-icon^>>>!filename!
echo             SAVE>>!filename!
echo           ^</v-btn^>>>!filename!
echo         ^</div^>>>!filename!
echo       ^</v-card^>>>!filename!
echo     ^</v-dialog^>>>!filename!
echo     ^<ConfirmationDialog ref^="confirmationDialog" /^>>>!filename!
echo     ^<DeleteDialog ref^="deleteDialog" /^>>>!filename!
echo     ^<InformationDialog ref^="informationDialog" /^>>>!filename!
echo     ^<LoadingDialog ref^="loadingDialog" /^>>>!filename!
echo     ^<Snackbar ref^="snackbar" /^>>>!filename!
echo   ^</div^>>>!filename!
echo ^</template^>>>!filename!
echo.>>!filename!
echo ^<script^>>>!filename!
echo import !tabelSnake!Api from "@src/api/!tabelProper!Api"^;>>!filename!
echo.>>!filename!
echo export default {>>!filename!
echo   name: "!tabelProper!",>>!filename!
echo.>>!filename!
echo   data^(^) {>>!filename!
echo     return {>>!filename!
echo       breadcrumbs: [>>!filename!
echo         { text: "Home", disabled: false, href: "#/" },>>!filename!
echo         { text: "Master Data", disabled: false, href: "#/master-data" },>>!filename!
echo         { text: "!tabelProper!", disabled: true, href: "#/!tabelStrip!" },>>!filename!
echo       ],>>!filename!
echo       headers: [>>!filename!
echo         { text: "", value: "action", width: 75, sortable: false },>>!filename!


set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldSnake=!field!
			CALL :SnakeCamel fieldSnake
			set fieldLow=!field!
			CALL :LoCase fieldLow
			CALL :FirstDown result !fieldSnake!
			set fieldSnake=!result!
			
			call :spaceTitleResult !field!
			set fieldSpace=!result!

			call :stripTitleResult !field!
			set fieldStrip=!result!
		)
REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
echo         { text: "!fieldSpace!", value: "!fieldSnake!" },>>!filename!
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)

)


echo       ],>>!filename!
echo       datasource: [],>>!filename!
echo       resource: {},>>!filename!
echo       search: "",>>!filename!
echo       dialog: false,>>!filename!
echo       loading: false,>>!filename!
echo       mode: "create",>>!filename!
echo     }^;>>!filename!
echo   },>>!filename!
echo.>>!filename!
echo   async mounted^(^) {>>!filename!
echo     this.loading ^= true^;>>!filename!
echo.>>!filename!
echo     document.title ^= "Inventory | !tabelSpace!"^;>>!filename!
echo.>>!filename!
echo     this.datasource ^= await !tabelSnake!Api.getList^(^)^;>>!filename!
echo.>>!filename!
echo     this.loading ^= false^;>>!filename!
echo   },>>!filename!
echo.>>!filename!
echo   methods: {>>!filename!
echo     defaultDataSource^(^) {>>!filename!
echo       return this.$store.getters["customerCategory/getList"]^;>>!filename!
echo     },>>!filename!
echo     download^(^) {>>!filename!
echo       this.downloadExcel^(this.datasource, "!tabelSpace!.xlsx"^)^;>>!filename!
echo     },>>!filename!
echo     create^(^) {>>!filename!
echo       this.mode ^= "create"^;>>!filename!
echo       this.resource ^= {>>!filename!
echo         id: "",>>!filename!

set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldSnake=!field!
			CALL :SnakeCamel fieldSnake
			set fieldLow=!field!
			CALL :LoCase fieldLow
			CALL :FirstDown result !fieldSnake!
			set fieldSnake=!result!
		
			call :spaceTitleResult !field!
			set fieldSpace=!result!

			call :stripTitleResult !field!
			set fieldStrip=!result!
		)
REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
echo         !fieldSnake!: "",>>!filename!
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)

)

echo       }^;>>!filename!
echo       this.dialog ^= true^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     update^(item^) {>>!filename!
echo       this.mode ^= "update"^;>>!filename!
echo       this.resource ^= {>>!filename!
echo         id: item.id,>>!filename!


set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldSnake=!field!
			CALL :SnakeCamel fieldSnake
			set fieldLow=!field!
			CALL :LoCase fieldLow
			CALL :FirstDown result !fieldSnake!
			set fieldSnake=!result!
			
			call :spaceTitleResult !field!
			set fieldSpace=!result!

			call :stripTitleResult !field!
			set fieldStrip=!result!
		)
REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
echo         !fieldSnake!: item.!fieldSnake!,>>!filename!
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)

)

echo       }^;>>!filename!
echo       this.dialog ^= true^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async remove^(item^) {>>!filename!
echo       const res ^= await this.$refs.deleteDialog.show^(`Are you sure to remove !tabelSnake!: ${item.code}?`^)^;>>!filename!
echo       if ^(res^) {>>!filename!
echo         try {>>!filename!
echo           this.loading ^= true^;>>!filename!
echo           await !tabelSnake!Api.delete^(item.id^)^;>>!filename!
echo           this.$refs.snackbar.show^("Data removed successfully."^)^;>>!filename!
echo.>>!filename!
echo           this.loading ^= false^;>>!filename!
echo         } catch ^(error^) {>>!filename!
echo           this.loading ^= false^;>>!filename!
echo           this.$refs.snackbar.showError^(error^)^;>>!filename!
echo         }>>!filename!
echo       }>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async save^(^) {>>!filename!
echo       try {>>!filename!
echo         this.loading ^= true^;>>!filename!
echo.>>!filename!
echo         if ^(this.mode ^=^=^= "create"^) await !tabelSnake!Api.create^(this.resource^)^;>>!filename!
echo         else if ^(this.mode ^=^=^= "update"^) await !tabelSnake!Api.update^(this.resource^)^;>>!filename!
echo.>>!filename!
echo         this.datasource ^= await !tabelSnake!Api.getList^(^)^;>>!filename!
echo.>>!filename!
echo         this.$refs.snackbar.show^("Data saved successfully."^)^;>>!filename!
echo         this.dialog ^= false^;>>!filename!
echo         this.loading ^= false^;>>!filename!
echo       } catch ^(error^) {>>!filename!
echo         this.loading ^= false^;>>!filename!
echo         this.$refs.snackbar.showError^(error^)^;>>!filename!
echo       }>>!filename!
echo     },>>!filename!
echo   },>>!filename!
echo }^;>>!filename!
echo ^</script^>>>!filename!


echo !tabelProper!
REM tutup ismasterdata
) 

REM ###############################################################################################################

if !istransaction!==true (

SET folderpath=!basedir!\!projectName!.WebApp\src\views\transactions
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!.vue
echo ^<template^>>!filename!
echo   ^<div^>>>!filename!
echo     ^<div class^="orange lighten-5 pt-3 pl-5"^>>>!filename!
echo       ^<v-row dense align^="center"^>>>!filename!
echo         ^<v-col cols^="12" md^="4"^>>>!filename!
echo           ^<h1 class^="text-h5"^>>>!filename!
echo             ^<v-icon class^="pr-2" color^="deep-orange" x-large^>mdi-truck-plus-outline^</v-icon^>!tabelSpace!>>!filename!
echo           ^</h1^>>>!filename!
echo         ^</v-col^>>>!filename!
echo         ^<v-col cols^="12" md^="8" class^="d-none d-md-flex pr-6"^>>>!filename!
echo           ^<v-spacer^>^</v-spacer^>>>!filename!
echo           ^<v-breadcrumbs :items^="breadcrumbs"^>>>!filename!
echo             ^<template v-slot:divider^>>>!filename!
echo               ^<v-icon^>mdi-chevron-right^</v-icon^>>>!filename!
echo             ^</template^>>>!filename!
echo           ^</v-breadcrumbs^>>>!filename!
echo         ^</v-col^>>>!filename!
echo       ^</v-row^>>>!filename!
echo     ^</div^>>>!filename!
echo.>>!filename!
echo     ^<div class^="ma-7"^>>>!filename!
echo       ^<v-row^>>>!filename!
echo         ^<v-col cols^="12" md^="8" lg^="9"^>>>!filename!
echo           ^<v-slide-group^>>>!filename!
echo             ^<div class^="mb-5"^>>>!filename!
echo               ^<v-slide-item class^="mr-2"^>>>!filename!
echo                 ^<v-btn color^="primary" to^="/!tabelStrip!/create"^>>>!filename!
echo                   ^<v-icon left^>mdi-plus^</v-icon^>Create New !tabelSpace!>>!filename!
echo                 ^</v-btn^>>>!filename!
echo               ^</v-slide-item^>>>!filename!
echo               ^<v-slide-item class^="mr-2"^>>>!filename!
echo                 ^<v-btn @click^="download()"^>>>!filename!
echo                   ^<v-icon left^>mdi-download^</v-icon^>Download>>!filename!
echo                 ^</v-btn^>>>!filename!
echo               ^</v-slide-item^>>>!filename!
echo             ^</div^>>>!filename!
echo           ^</v-slide-group^>>>!filename!
echo         ^</v-col^>>>!filename!
echo         ^<v-col cols^="12" md^="4" lg^="3"^>>>!filename!
echo           ^<v-text-field>>!filename!
echo               dense>>!filename!
echo               outlined>>!filename!
echo               v-model^="search">>!filename!
echo               append-icon^="mdi-magnify">>!filename!
echo               label^="Search">>!filename!
echo               single-line>>!filename!
echo               hide-details>>!filename!
echo               class^="pb-3">>!filename!
echo           ^>^</v-text-field^>>>!filename!
echo         ^</v-col^>>>!filename!
echo       ^</v-row^>>>!filename!
echo.>>!filename!
echo       ^<v-card :disabled^="loading" class^="mb-5"^>>>!filename!
echo         ^<div class^="pt-1 pl-5 pb-1"^>>>!filename!
echo           ^<span>>!filename!
echo               class^="text-button">>!filename!
echo               style^="cursor: pointer;">>!filename!
echo               :ripple^="false">>!filename!
echo               text>>!filename!
echo               @click^="showFilter ^= ^!showFilter">>!filename!
echo           ^>>>!filename!
echo             FILTER>>!filename!
echo             ^<v-icon v-if^="^!showFilter"^>mdi-chevron-down^</v-icon^>>>!filename!
echo             ^<v-icon v-else^>mdi-chevron-up^</v-icon^>>>!filename!
echo           ^</span^>>>!filename!
echo         ^</div^>>>!filename!
echo.>>!filename!
echo         ^<v-row dense class^="pa-5" v-if^="showFilter"^>>>!filename!
echo           ^<v-col cols^="12" sm^="6" md^="2" class^="py-0"^>>>!filename!
echo             ^<DateInput v-model^="filter.startDate" label^="Start Date" dense outlined /^>>>!filename!
echo           ^</v-col^>>>!filename!
echo           ^<v-col cols^="12" sm^="6" md^="2" class^="py-0"^>>>!filename!
echo             ^<DateInput v-model^="filter.endDate" label^="End Date" dense outlined /^>>>!filename!
echo           ^</v-col^>>>!filename!
echo           ^<v-col cols^="12" sm^="4" md^="2" class^="py-0"^>>>!filename!
echo             ^<v-text-field v-model^="filter.documentNumber" label^="Document No." dense outlined /^>>>!filename!
echo           ^</v-col^>>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			echo           ^<v-col cols^="12" sm^="8" md^="6" class^="py-0"^>>>!filename!
			echo             ^<v-autocomplete>>!filename!
			echo                 v-model^="filter.!fieldSnake!Id">>!filename!
			echo                 :items^="!fieldSnake!DataSource">>!filename!
			echo                 item-value^="id">>!filename!
			echo                 item-text^="name">>!filename!
			echo                 label^="!fieldSpace!">>!filename!
			echo                 dense>>!filename!
			echo                 outlined>>!filename!
			echo             ^>^</v-autocomplete^>>>!filename!
			echo           ^</v-col^>>>!filename!
		)	
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)
)
echo           ^<v-col cols^="12" class^="py-0"^>>>!filename!
echo             ^<v-btn color^="blue" dark class^="mr-2" @click^="applyFilter()"^>>>!filename!
echo               ^<v-icon^>mdi-check^</v-icon^>Apply Filter>>!filename!
echo             ^</v-btn^>>>!filename!
echo             ^<v-btn @click^="resetFilter()"^>>>!filename!
echo               ^<v-icon^>mdi-close^</v-icon^>Reset>>!filename!
echo             ^</v-btn^>>>!filename!
echo           ^</v-col^>>>!filename!
echo         ^</v-row^>>>!filename!
echo       ^</v-card^>>>!filename!
echo.>>!filename!
echo       ^<v-card^>>>!filename!
echo         ^<v-data-table>>!filename!
echo             :headers^="headers">>!filename!
echo             :items^="datasource">>!filename!
echo             :search^="search">>!filename!
echo             :items-per-page^="10">>!filename!
echo             :loading^="loading">>!filename!
echo         ^>>>!filename!
echo           ^<template v-slot:item.action^="{ item }"^>>>!filename!
echo             ^<v-menu^>>>!filename!
echo               ^<template v-slot:activator^="{ attrs, on }"^>>>!filename!
echo                 ^<v-btn icon^>>>!filename!
echo                   ^<v-icon v-bind^="attrs" v-on^="on"^>mdi-dots-horizontal^</v-icon^>>>!filename!
echo                 ^</v-btn^>>>!filename!
echo               ^</template^>>>!filename!
echo               ^<v-list^>>>!filename!
echo                 ^<v-list-item>>!filename!
echo                     class^="grey--text text--darken-1 text-caption">>!filename!
echo                     dense>>!filename!
echo                     link>>!filename!
echo                     :to^="`/!tabelStrip!/update/${item.id}`">>!filename!
echo                 ^>>>!filename!
echo                   ^<v-icon class^="pr-2" small^>mdi-pencil^</v-icon^>UPDATE>>!filename!
echo                 ^</v-list-item^>>>!filename!
echo.>>!filename!
echo                 ^<v-list-item>>!filename!
echo                     class^="red--text text--darken-1 text-caption">>!filename!
echo                     dense>>!filename!
echo                     link>>!filename!
echo                     color^="grey">>!filename!
echo                     @click^="remove(item)">>!filename!
echo                 ^>>>!filename!
echo                   ^<v-icon class^="pr-2" small color^="red"^>mdi-delete^</v-icon^>DELETE>>!filename!
echo                 ^</v-list-item^>>>!filename!
echo               ^</v-list^>>>!filename!
echo             ^</v-menu^>>>!filename!
echo           ^</template^>>>!filename!
echo.>>!filename!
echo           ^<template v-slot:item.documentDate^="{ item }"^>{{ formatDate^(item.documentDate^) }}^</template^>>>!filename!
echo         ^</v-data-table^>>>!filename!
echo       ^</v-card^>>>!filename!
echo     ^</div^>>>!filename!
echo     ^<ConfirmationDialog ref^="confirmationDialog" /^>>>!filename!
echo     ^<DeleteDialog ref^="deleteDialog" /^>>>!filename!
echo     ^<InformationDialog ref^="informationDialog" /^>>>!filename!
echo     ^<LoadingDialog ref^="loadingDialog" /^>>>!filename!
echo     ^<Snackbar ref^="snackbar" /^>>>!filename!
echo   ^</div^>>>!filename!
echo ^</template^>>>!filename!
echo.>>!filename!
echo ^<script^>>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			set cleanfieldSnake=!field:Source=!
			set cleanfieldSnake=!cleanfieldSnake:Destination=!
			echo import !fieldSnake!Api from "@src/api/!cleanfieldSnake!Api"^;>>!filename!
		)	
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)
)
echo import !tabelSnake!Api from "@src/api/!tabelProper!Api"^;>>!filename!
echo.>>!filename!
echo export default {>>!filename!
echo   name: "!tabelProper!",>>!filename!
echo.>>!filename!
echo   data^(^) {>>!filename!
echo     return {>>!filename!
echo       breadcrumbs: [>>!filename!
echo         { text: "Home", disabled: false, href: "#/" },>>!filename!
echo         { text: "!tabelSpace!", disabled: false, href: "#/!tabelStrip!" },>>!filename!
echo         {>>!filename!
echo           text: "!tabelSpace!",>>!filename!
echo           disabled: true,>>!filename!
echo           href: "#/!tabelStrip!",>>!filename!
echo         },>>!filename!
echo       ],>>!filename!
echo       headers: [>>!filename!
echo         { text: "", value: "action", width: 75, sortable: false },>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			set fieldCode=!field:~-4!
			if NOT ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if NOT ["!fieldId!"]==["Id"] (
			if NOT ["!fieldCode!"]==["Code"] (
				if ["!fieldSnake!"]==["documentNumber"] (
					echo         { text: "Document No.", value: "documentNumber" },>>!filename!
				) else (
					echo         { text: "!fieldSpace!", value: "!fieldSnake!" },>>!filename!
				)
			)
		)	
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)
)
echo       ],>>!filename!
echo       datasource: [],>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			echo       !fieldSnake!DataSource: [],>>!filename!
		)	
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)
)
echo       filter: {>>!filename!
echo         startDate: null,>>!filename!
echo         endDate: null,>>!filename!
echo         documentNumber: null,>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			echo         !fieldSnake!Id: null,>>!filename!
		)	
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)
)
echo       },>>!filename!
echo       search: "",>>!filename!
echo       dialog: false,>>!filename!
echo       loading: false,>>!filename!
echo       showFilter: false,>>!filename!
echo     }^;>>!filename!
echo   },>>!filename!
echo.>>!filename!
echo   async mounted^(^) {>>!filename!
echo     this.loading ^= true^;>>!filename!
echo     document.title ^= "Inventory | !tabelSpace!"^;>>!filename!
echo.>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			echo     this.!fieldSnake!DataSource ^= await !fieldSnake!Api.getAll^(^)^;>>!filename!
		)	
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)
)
echo     this.datasource ^= await !tabelSnake!Api.getAll^(this.filter^)^;>>!filename!
echo.>>!filename!
echo     this.loading ^= false^;>>!filename!
echo   },>>!filename!
echo.>>!filename!
echo   methods: {>>!filename!
echo     download^(^) {>>!filename!
echo       const data ^= this.$xlsx.utils.json_to_sheet^(this.datasource^)^;>>!filename!
echo       const wb ^= this.$xlsx.utils.book_new^(^)^;>>!filename!
echo       this.$xlsx.utils.book_append_sheet^(wb, data, "data"^)^;>>!filename!
echo       this.$xlsx.writeFile^(wb, "!tabelProper!.xlsx"^)^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async applyFilter^(^) {>>!filename!
echo       try {>>!filename!
echo         this.loading ^= true^;>>!filename!
echo         this.datasource ^= await !tabelSnake!Api.getAll^(this.filter^)^;>>!filename!
echo       } catch ^(error^) {>>!filename!
echo         this.$refs.snackbar.showError^(error^)^;>>!filename!
echo       }>>!filename!
echo       this.loading ^= false^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async resetFilter^(^) {>>!filename!
echo       this.loading ^= true^;>>!filename!
echo       this.filter ^= {>>!filename!
echo         startDate: null,>>!filename!
echo         endDate: null,>>!filename!
echo         documentNumber: null,>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			echo         !fieldSnake!Id: null,>>!filename!
		)	
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)
)
echo       }^;>>!filename!
echo       this.datasource ^= await !tabelSnake!Api.getAll^(this.filter^)^;>>!filename!
echo       this.loading ^= false^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async remove^(item^) {>>!filename!
echo       const res ^= await this.$refs.deleteDialog.show^(>>!filename!
echo           `Delete !tabelSpcLow!: ${item.documentNumber}?`>>!filename!
echo       ^)^;>>!filename!
echo       if ^(res^) {>>!filename!
echo         this.loading ^= true^;>>!filename!
echo         try {>>!filename!
echo           await !tabelSnake!Api.delete^(item.id^)^;>>!filename!
echo           this.deleteRecord^(this.datasource, item.id^)^;>>!filename!
echo           this.$refs.snackbar.show^("Data deleted successfully.."^)^;>>!filename!
echo         } catch ^(error^) {>>!filename!
echo           this.$refs.snackbar.showError^(error^)^;>>!filename!
echo         }>>!filename!
echo         this.loading ^= false^;>>!filename!
echo       }>>!filename!
echo     },>>!filename!
echo   },>>!filename!
echo }^;>>!filename!
echo ^</script^>>>!filename!

SET folderpath=!basedir!\!projectName!.WebApp\src\router
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\index.js
if exist "!filename!" (
fart -C !filename! "import Role from \"@src/views/master-data/Role.vue\"^;" "import !tabelProper!Edit from \"@src/views/transactions/!tabelProper!Edit.vue\"^;\r\nimport Role from \"@src/views/master-data/Role.vue\"^;" >nul
fart -C !filename! "children: [" "children: [{\r\n        path: \"!tabelStrip!/:mode\",\r\n        component: !tabelProper!Edit,\r\n      },{\r\n        path: \"!tabelStrip!/:mode/:id\",\r\n        component: !tabelProper!Edit,\r\n      }," >nul
) else (
echo import Vue from "vue"^;>!filename!
echo import VueRouter from "vue-router"^;>>!filename!
echo import AppLayout from "@src/layouts/AppLayout.vue">>!filename!
echo import Login from "@src/views/Login.vue"^;>>!filename!
echo import Home from "@src/views/Home.vue"^;>>!filename!
echo import !tabelProper!Edit from "@src/views/master-data/!tabelProper!Edit.vue"^;>>!filename!
echo import Role from "@src/views/master-data/Role.vue"^;>>!filename!
echo.>>!filename!
echo Vue.use^(VueRouter^)^;>>!filename!
echo.>>!filename!
echo const routes ^= [>>!filename!
echo     {>>!filename!
echo         path: "/",>>!filename!
echo         component: AppLayout,>>!filename!
echo         children: [>>!filename!
echo             {>>!filename!
echo                 path: "",>>!filename!
echo                 component: Home>>!filename!
echo             },>>!filename!
echo             {>>!filename!
echo                 path: "!tabelSnake!/:mode",>>!filename!
echo                 component: !tabelProper!Edit>>!filename!
echo             },>>!filename!
echo             {>>!filename!
echo                 path: "!tabelSnake!/:mode/:id",>>!filename!
echo                 component: !tabelProper!Edit>>!filename!
echo             },>>!filename!
echo             {>>!filename!
echo                 path: "role",>>!filename!
echo                 component: Role>>!filename!
echo             },>>!filename!
echo         ]>>!filename!
echo     },>>!filename!
echo     {>>!filename!
echo         path: "/login",>>!filename!
echo         component: Login>>!filename!
echo     },>>!filename!
echo ]^;>>!filename!
echo.>>!filename!
echo const router ^= new VueRouter^({>>!filename!
echo     routes>>!filename!
echo }^)^;>>!filename!
echo.>>!filename!
echo export default router^;>>!filename!
)


SET folderpath=!basedir!\!projectName!.WebApp\src\views\transactions
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!Edit.vue
echo ^<template^>>!filename!
echo   ^<div^>>>!filename!
echo     ^<div class^="orange lighten-5 pt-3 pl-5"^>>>!filename!
echo       ^<v-row dense align^="center"^>>>!filename!
echo         ^<v-col cols^="12" md^="4"^>>>!filename!
echo           ^<h1 class^="text-h5"^>>>!filename!
echo             ^<v-icon class^="pr-2" color^="deep-orange" x-large^>mdi-truck-plus-outline^</v-icon^>>>!filename!
echo             {{ title }}>>!filename!
echo           ^</h1^>>>!filename!
echo         ^</v-col^>>>!filename!
echo         ^<v-col cols^="12" md^="8" class^="d-none d-md-flex pr-6"^>>>!filename!
echo           ^<v-spacer^>^</v-spacer^>>>!filename!
echo           ^<v-breadcrumbs :items^="breadcrumbs"^>>>!filename!
echo             ^<template v-slot:divider^>>>!filename!
echo               ^<v-icon^>mdi-chevron-right^</v-icon^>>>!filename!
echo             ^</template^>>>!filename!
echo           ^</v-breadcrumbs^>>>!filename!
echo         ^</v-col^>>>!filename!
echo       ^</v-row^>>>!filename!
echo     ^</div^>>>!filename!
echo.>>!filename!
echo     ^<v-card class^="ma-5"^>>>!filename!
echo       ^<v-row dense class^="pt-5 mx-5"^>>>!filename!
echo.>>!filename!
echo         ^<v-col cols^="12" sm^="3" md^="2" class^="py-0"^>>>!filename!
echo           ^<v-text-field v-model^="resource.documentNumber" label^="Document No" dense outlined disabled^>^</v-text-field^>>>!filename!
echo         ^</v-col^>>>!filename!
echo.>>!filename!
echo         ^<v-col cols^="12" sm^="3" md^="2" class^="py-0"^>>>!filename!
echo           ^<DateInput v-model^="resource.documentDate" label^="Document Date" dense outlined/^>>>!filename!
echo         ^</v-col^>>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			echo.>>!filename!
			echo         ^<v-col cols^="12" sm^="6" md^="4" class^="py-0"^>>>!filename!
			echo           ^<v-autocomplete>>!filename!
			echo               v-model^="resource.!fieldSnake!Id">>!filename!
			echo               :items^="!fieldSnake!DataSource">>!filename!
			echo               item-text^="name">>!filename!
			echo               item-value^="id">>!filename!
			echo               label^="!fieldSpace!">>!filename!
			echo               dense>>!filename!
			echo               outlined>>!filename!
			echo           ^>^</v-autocomplete^>>>!filename!
			echo         ^</v-col^>>>!filename!
		)	
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)
)
set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			set fieldCode=!field:~-4!
			if NOT ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if NOT ["!fieldId!"]==["Id"] if NOT ["!fieldCode!"]==["Code"] if NOT ["!fieldCode!"]==["Name"] if NOT ["!fieldSnake!"]==["documentNumber"] if NOT ["!fieldSnake!"]==["documentDate"] (
			if !tipeData!==DateTime (
				echo         ^<v-col cols^="12" sm^="3" md^="2" class^="py-0"^>>>!filename!
				echo           ^<DateInput v-model^="resource.!fieldSnake!" label^="!fieldSpace!" dense outlined/^>>>!filename!
				echo         ^</v-col^>>>!filename!
			) else if !tipeData!==DateTime? (
				echo         ^<v-col cols^="12" sm^="3" md^="2" class^="py-0"^>>>!filename!
				echo           ^<DateInput v-model^="resource.!fieldSnake!" label^="!fieldSpace!" dense outlined/^>>>!filename!
				echo         ^</v-col^>>>!filename!
			) else if !tipeData!==decimal (
				echo         ^<v-col cols^="12" sm^="3" md^="2" class^="py-0 text-right"^>>>!filename!
				echo             ^<NumberInput>>!filename!
				echo				 label^="!fieldSpace!">>!filename!
				echo                 v-model.number^="resource.!fieldSnake!">>!filename!
				echo                 dense>>!filename!
				echo                 outlined>>!filename!
				echo                 hide-details>>!filename!
				echo             /^>>>!filename!
				echo         ^</v-col^>>>!filename!
			) else if !tipeData!==decimal? (
				echo         ^<v-col cols^="12" sm^="3" md^="2" class^="py-0 text-right"^>>>!filename!
				echo             ^<NumberInput>>!filename!
				echo				 label^="!fieldSpace!">>!filename!
				echo                 v-model.number^="resource.!fieldSnake!">>!filename!
				echo                 dense>>!filename!
				echo                 outlined>>!filename!
				echo                 hide-details>>!filename!
				echo             /^>>>!filename!
				echo         ^</v-col^>>>!filename!
			) else (
				echo.>>!filename!
				echo         ^<v-col cols^="12" sm^="12" md^="4" class^="py-0"^>>>!filename!
				echo           ^<v-text-field v-model^="resource.!fieldSnake!" label^="!fieldSpace!" dense outlined^>^</v-text-field^>>>!filename!
				echo         ^</v-col^>>>!filename!
			)
		)
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)
)
echo       ^</v-row^>>>!filename!
echo.>>!filename!
echo       ^<v-divider class^="mt-0"^>^</v-divider^>>>!filename!
echo.>>!filename!
echo       ^<v-row align^="center" dense class^="ma-5"^>>>!filename!
echo         ^<v-col cols^="12" sm^="4" md^="3"^>>>!filename!
echo           ^<v-text-field>>!filename!
echo               v-model^="scanCode">>!filename!
echo               id^="scan-code">>!filename!
echo               dense>>!filename!
echo               solo>>!filename!
echo               color^="primary">>!filename!
echo               label^="Scan item code...">>!filename!
echo               hide-details>>!filename!
echo               @keyup.enter^="scanCodeKeyupEnter()">>!filename!
echo           ^>^</v-text-field^>>>!filename!
echo         ^</v-col^>>>!filename!
echo       ^</v-row^>>>!filename!
echo.>>!filename!
echo       ^<v-simple-table class^="mx-5"^>>>!filename!
echo         ^<thead^>>>!filename!
echo         ^<tr^>>>!filename!
echo           ^<th style^="width:50px; min-width:50px"^>#^</th^>>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabel!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			set fieldCode=!field:~-4!
			set intMark=
			if ["!tipeData!"]==["decimal"] set intMark=class^="text-right"
			if NOT ["!fieldId!"]==["Name"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if NOT ["!fieldCode!"]==["Code"] if NOT ["!fieldCode!"]==["Name"] if NOT ["!fieldSnake!"]==["documentNumber"] if NOT ["!fieldSnake!"]==["documentDate"] (
			echo           ^<th !intMark!^>!fieldSpace!^</th^>>>!filename!
		)
	)
	if ["!str!"]==["int Sequence"] (
		set startProperty=false
	)
)
echo           ^<th style^="width:50px; min-width:50px"^>^</th^>>>!filename!
echo         ^</tr^>>>!filename!
echo         ^</thead^>>>!filename!
echo         ^<tbody^>>>!filename!
echo         ^<tr v-for^="(item, key) in resource.details" v-bind:key^="key"^>>>!filename!
echo           ^<td class^="text-caption"^>{{ key + 1 }}^</td^>>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabel!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			echo.>>!filename!
			echo           ^<td^>>>!filename!
			echo             ^<v-autocomplete>>!filename!
			echo                 :id^="'!fieldSnake!-'+key">>!filename!
			echo                 v-model^="item.!fieldSnake!Id">>!filename!
			echo                 :items^="!fieldSnake!DataSource">>!filename!
			echo                 :item-text^="i => i.code + ' | ' + i.name">>!filename!
			echo                 item-value^="id">>!filename!
			echo                 dense>>!filename!
			echo                 outlined>>!filename!
			echo                 hide-details>>!filename!
			echo                 @change^="!fieldSnake!Change(item)">>!filename!
			echo             ^>>>!filename!
			echo               ^<template v-slot:item^="{item}"^>{{ item.code }} ^| {{ item.name }}^</template^>>>!filename!
			echo             ^</v-autocomplete^>>>!filename!
			echo           ^</td^>>>!filename!
		)	
	)
	if ["!str!"]==["int Sequence"] (
		set startProperty=false
	)
)
set startProperty=true
for /f "delims=" %%z in (responses/!tabel!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			set fieldCode=!field:~-4!
			if NOT ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if NOT ["!fieldId!"]==["Id"] if NOT ["!fieldCode!"]==["Code"] if NOT ["!fieldCode!"]==["Name"] if NOT ["!fieldSnake!"]==["documentNumber"] if NOT ["!fieldSnake!"]==["documentDate"] (
			if ["!fieldSnake!"]==["remarks"] (
				echo           ^<td^>>>!filename!
				echo             ^<v-text-field v-model^="item.!fieldSnake!" dense outlined hide-details>>!filename!
				echo                           @keyup.enter^="rowKeyUpEnter(key)"^>^</v-text-field^>>>!filename!
				echo           ^</td^>>>!filename!
			) else if ["!tipeData!"]==["decimal"] (
				echo           ^<td class^="text-right"^>>>!filename!
				echo             ^<NumberInput>>!filename!
				echo                 v-model.number^="item.!fieldSnake!">>!filename!
				echo                 dense>>!filename!
				echo                 outlined>>!filename!
				echo                 hide-details>>!filename!
				echo                 @change^="!fieldSnake!Change(item)">>!filename!
				echo                 @keyup.enter^="rowKeyUpEnter(key)">>!filename!
				echo             /^>>>!filename!
				echo           ^</td^>>>!filename!
			) else (
				echo           ^<td class^="text-body-1"^>{{ item.!fieldSnake! }}^</td^>>>!filename!
			)
		)
	)
	if ["!str!"]==["int Sequence"] (
		set startProperty=false
	)
)
echo           ^<td^>>>!filename!
echo             ^<v-btn icon @click^="deleteDetail(key)"^>>>!filename!
echo               ^<v-icon color^="red"^>mdi-delete^</v-icon^>>>!filename!
echo             ^</v-btn^>>>!filename!
echo           ^</td^>>>!filename!
echo         ^</tr^>>>!filename!
echo         ^</tbody^>>>!filename!
echo         ^<tfoot^>>>!filename!
echo         ^<tr^>>>!filename!
echo           ^<td colspan^="8"^>>>!filename!
echo             ^<v-btn outlined color^="primary" class^="my-3" @click^="createItem()"^>>>!filename!
echo               ^<v-icon^>mdi-plus^</v-icon^>>>!filename!
echo               Add Item>>!filename!
echo             ^</v-btn^>>>!filename!
echo           ^</td^>>>!filename!
echo         ^</tr^>>>!filename!
echo         ^</tfoot^>>>!filename!
echo       ^</v-simple-table^>>>!filename!
echo.>>!filename!
echo       ^<div id^="bottom"^>^</div^>>>!filename!
echo.>>!filename!
echo       ^<v-divider class^="mt-5"^>^</v-divider^>>>!filename!
echo.>>!filename!
echo       ^<v-row no-gutters class^="pa-3"^>>>!filename!
echo         ^<v-col cols^="2"^>>>!filename!
echo           ^<v-btn icon @click^="refreshDataSource()" :loading^="loadingRefresh"^>>>!filename!
echo             ^<v-icon^>mdi-refresh^</v-icon^>>>!filename!
echo           ^</v-btn^>>>!filename!
echo         ^</v-col^>>>!filename!
echo         ^<v-col cols^="10" class^="text-right"^>>>!filename!
echo           ^<v-btn text class^="mr-2" @click^="cancel()"^>>>!filename!
echo             ^<v-icon left^>mdi-close^</v-icon^>>>!filename!
echo             Cancel>>!filename!
echo           ^</v-btn^>>>!filename!
echo           ^<v-btn color^="primary" min-width^="110px" @click^="save()"^>>>!filename!
echo             ^<v-icon left^>mdi-check^</v-icon^>>>!filename!
echo             Save>>!filename!
echo           ^</v-btn^>>>!filename!
echo         ^</v-col^>>>!filename!
echo       ^</v-row^>>>!filename!
echo     ^</v-card^>>>!filename!
echo.>>!filename!
echo     ^<ConfirmationDialog ref^="confirmationDialog"/^>>>!filename!
echo     ^<DeleteDialog ref^="deleteDialog"/^>>>!filename!
echo     ^<InformationDialog ref^="informationDialog"/^>>>!filename!
echo     ^<LoadingDialog ref^="loadingDialog"/^>>>!filename!
echo     ^<Snackbar ref^="snackbar"/^>>>!filename!
echo   ^</div^>>>!filename!
echo ^</template^>>>!filename!
echo.>>!filename!
echo ^<script^>>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabel!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			set cleanfieldSnake=!field:Source=!
			set cleanfieldSnake=!cleanfieldSnake:Destination=!
			echo import !fieldSnake!Api from "@src/api/!cleanfieldSnake!Api"^;>>!filename!
		)	
	)
	if ["!str!"]==["int Sequence"] (
		set startProperty=false
	)
)
set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			set cleanfieldSnake=!field:Source=!
			set cleanfieldSnake=!cleanfieldSnake:Destination=!
			echo import !fieldSnake!Api from "@src/api/!cleanfieldSnake!Api"^;>>!filename!
		)	
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)
)
echo import !tabelSnake!Api from "@src/api/!tabelProper!Api"^;>>!filename!
echo.>>!filename!
echo export default {>>!filename!
echo   name: "!tabelProper!Edit",>>!filename!
echo   data^(^) {>>!filename!
echo     return {>>!filename!
echo       title: "",>>!filename!
echo       breadcrumbs: [>>!filename!
echo         {text: "Home", disabled: false, href: "#/"},>>!filename!
echo         {text: "!tabelSpace!", disabled: false, href: "#/!tabelStrip!"},>>!filename!
echo         {>>!filename!
echo           text: "!tabelSpace!",>>!filename!
echo           disabled: false,>>!filename!
echo           href: "#/!tabelStrip!",>>!filename!
echo         }>>!filename!
echo       ],>>!filename!
echo       mode: "",>>!filename!
echo       id: "",>>!filename!
echo       resource: {},>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			echo       !fieldSnake!DataSource: [],>>!filename!
		)	
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)
)
set startProperty=true
for /f "delims=" %%z in (responses/!tabel!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			echo       !fieldSnake!DataSource: [],>>!filename!
		)	
	)
	if ["!str!"]==["int Sequence"] (
		set startProperty=false
	)
)
echo       scanCode: "",>>!filename!
echo       loadingRefresh: false,>>!filename!
echo       identity: {},>>!filename!
echo     }^;>>!filename!
echo   },>>!filename!
echo.>>!filename!
echo   async mounted^(^) {>>!filename!
echo     try {>>!filename!
echo       this.$refs.loadingDialog.show^(^)^;>>!filename!
echo.>>!filename!
echo       this.mode ^= this.$route.params.mode^;>>!filename!
echo       this.identity ^= this.storageLoad^("identity"^)^;>>!filename!
echo.>>!filename!
echo       await this.refreshDataSource^(^)^;>>!filename!
echo.>>!filename!
echo       if ^(this.mode ^=^=^= "create"^) {>>!filename!
echo         document.title ^= "Inventory ^| Create !tabelSpace!"^;>>!filename!
echo         this.title ^= "Create !tabelSpace!"^;>>!filename!
echo         this.resource ^= this.storageLoad^("draft!tabelProper!"^)^;>>!filename!
echo         if ^(^^!this.resource^) {>>!filename!
echo           this.resource ^= {>>!filename!
echo             documentNumber: "*",>>!filename!
echo             documentDate: this.today^(^),>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			echo             !fieldSnake!Id: null,>>!filename!
		)	
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)
)
set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			set fieldCode=!field:~-4!
			if NOT ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if NOT ["!fieldId!"]==["Id"] if NOT ["!fieldCode!"]==["Code"] if NOT ["!fieldCode!"]==["Name"] if NOT ["!fieldSnake!"]==["documentNumber"] if NOT ["!fieldSnake!"]==["documentDate"] (
			if ["!fieldSnake!"]==["remarks"] (
				echo             remarks: "",>>!filename!
			) else (
				echo             !fieldSnake!: "",>>!filename!
			)
		)
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)
)
echo             details: [],>>!filename!
echo           }^;>>!filename!
echo         }>>!filename!
echo       } else if ^(this.mode ^=^=^= "update"^) {>>!filename!
echo         this.id ^= this.$route.params.id^;>>!filename!
echo         document.title ^= `Inventory ^| Update !tabelSpace! ^| ${this.id}`^;>>!filename!
echo         this.title ^= "Update !tabelSpace!"^;>>!filename!
echo         this.resource ^= await !tabelSnake!Api.get^(this.id^)^;>>!filename!
echo       } else await this.$router.push^("/!tabelStrip!"^)^;>>!filename!
echo.>>!filename!
echo       this.breadcrumbs.push^({>>!filename!
echo         text: this.title,>>!filename!
echo         disabled: true,>>!filename!
echo         href: `#/!tabelStrip!/${this.mode}`,>>!filename!
echo       }^)^;>>!filename!
echo     } catch ^(error^) {>>!filename!
echo       this.$refs.snackbar.showError^(error^)^;>>!filename!
echo     }>>!filename!
echo     this.$refs.loadingDialog.hide^(^)^;>>!filename!
echo   },>>!filename!
echo.>>!filename!
echo   watch: {>>!filename!
echo     resource: {>>!filename!
echo       handler^(value^) {>>!filename!
echo         if ^(this.mode ^=^=^= "create"^)>>!filename!
echo           this.storageSave^("draft!tabelProper!", value^)^;>>!filename!
echo       },>>!filename!
echo       deep: true,>>!filename!
echo     },>>!filename!
echo   },>>!filename!
echo.>>!filename!
echo   methods: {>>!filename!
echo     async refreshDataSource^(^) {>>!filename!
echo       this.loadingRefresh ^= true^;>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabel!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			echo       this.!fieldSnake!DataSource ^= await !fieldSnake!Api.getAll^(^)^;>>!filename!
		)	
	)
	if ["!str!"]==["int Sequence"] (
		set startProperty=false
	)
)
set startProperty=true
for /f "delims=" %%z in (responses/!tabelFileName!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			echo       this.!fieldSnake!DataSource ^= await !fieldSnake!Api.getAll^(^)^;>>!filename!
		)	
	)
	if ["!str!"]==["string Id"] (
		set startProperty=false
	)
)
echo       this.loadingRefresh ^= false^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     createDetail^(^) {>>!filename!
echo       const lastDetail ^=>>!filename!
echo           this.resource.details[this.resource.details.length - 1]^;>>!filename!
echo.>>!filename!
echo       if ^(lastDetail ^&^& ^^!lastDetail.itemId^) return^;>>!filename!
echo.>>!filename!
echo       this.resource.details.push^({>>!filename!
echo         sequence: this.resource.details.length + 1,>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabel!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			set fieldCode=!field:~-4!
			set intMark=""
			if ["!tipeData!"]==["decimal"] set intMark=0
			if NOT ["!fieldId!"]==["Name"] (
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if NOT ["!fieldCode!"]==["Code"] if NOT ["!fieldCode!"]==["Name"] if NOT ["!fieldSnake!"]==["documentNumber"] if NOT ["!fieldSnake!"]==["documentDate"] (
			echo         !fieldSnake!: !intMark!,>>!filename!
		)
	)
	if ["!str!"]==["int Sequence"] (
		set startProperty=false
	)
)
echo       }^)^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     focusToLastDetail^(^) {>>!filename!
echo       document.getElementById^("bottom"^).scrollIntoView^(^)^;>>!filename!
echo       setTimeout^(^(^) ^=^> {>>!filename!
echo         const id ^= "item-" + ^(this.resource.details.length - 1^)^;>>!filename!
echo         const element ^= document.getElementById^(id^)^;>>!filename!
echo         element.focus^(^)^;>>!filename!
echo       }, 0^)^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     deleteDetail^(key^) {>>!filename!
echo       this.resource.details.splice^(key, 1^)^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async scanCodeKeyupEnter^(^) {>>!filename!
echo       if ^(this.scanCode^) {>>!filename!
echo         const item ^= this.itemDataSource.filter^(>>!filename!
echo             ^(x^) ^=^>>>!filename!
echo                 x.code.toLowerCase^(^) ^=^=^= this.scanCode.toLowerCase^(^) ^|^|>>!filename!
echo                 x.name.toLowerCase^(^) ^=^=^= this.scanCode.toLowerCase^(^)>>!filename!
echo         ^)[0]^;>>!filename!
echo.>>!filename!
echo         if ^(item^) {>>!filename!
echo           let detail ^= this.resource.details.filter^(>>!filename!
echo               ^(x^) ^=^> x.itemId ^=^=^= item.id>>!filename!
echo           ^)[0]^;>>!filename!
echo.>>!filename!
echo           if ^(detail^) {>>!filename!
echo             detail.quantity ^= this.parseNumber^(detail.quantity^) + 1^;>>!filename!
echo           } else {>>!filename!
echo             detail ^= {>>!filename!
echo               sequence: this.resource.details.length + 1,>>!filename!
echo               itemId: item.id,>>!filename!
echo             }^;>>!filename!
echo             detail.quantity ^= 1^;>>!filename!
echo             await this.itemChange^(detail^)^;>>!filename!
echo             this.resource.details.push^(detail^)^;>>!filename!
echo           }>>!filename!
echo         } else {>>!filename!
echo           this.$refs.snackbar.show^(>>!filename!
echo               `Item ${this.scanCode} not found.`>>!filename!
echo           ^)^;>>!filename!
echo         }>>!filename!
echo       }>>!filename!
echo.>>!filename!
echo       this.scanCode ^= ""^;>>!filename!
echo       document.getElementById^("scan-code"^).focus^(^)^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabel!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			if ["!fieldId!"]==["Id"] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!fieldId!"]==["Id"] (
			echo     async !fieldSnake!Change^(item^) {>>!filename!
			echo       if ^(^^!item^) return^;>>!filename!
			echo.>>!filename!
			echo       const result ^= this.!fieldSnake!DataSource.filter^(x ^=^> x.id ^=^=^= item.!fieldSnake!Id^)[0]^;>>!filename!
			echo       if ^(!result^) return^;>>!filename!
			echo.>>!filename!
			echo       item.itemUnit ^= result.unit^;>>!filename!
			echo     },>>!filename!
		)	
	)
	if ["!str!"]==["int Sequence"] (
		set startProperty=false
	)
)
set startProperty=true
for /f "delims=" %%z in (responses/!tabel!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2 delims= " %%a in ("!str!") do (
			set tipeData=%%a
			set field=%%b
			
			set fieldId=!field:~-2!
			set fieldCode=!field:~-4!
			set intMark=""
			if ["!tipeData!"]==["decimal"] set intMark=0
			if NOT ["!fieldId!"]==["Name"] (
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
		if ["!tipeData!"]==["decimal"] (
			echo.>>!filename!
			echo     !fieldSnake!Change^(item^) {>>!filename!
			echo       console.log^(item^)^;>>!filename!
			echo     },>>!filename!
		)
	)
	if ["!str!"]==["int Sequence"] (
		set startProperty=false
	)
)
echo.>>!filename!
echo     rowKeyUpEnter^(key^) {>>!filename!
echo       if ^(key ^=^=^= this.resource.details.length - 1^) {>>!filename!
echo         this.createDetail^(^)^;>>!filename!
echo         this.focusToLastDetail^(^)^;>>!filename!
echo       }>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     createItem^(^) {>>!filename!
echo       this.createDetail^(^)^;>>!filename!
echo       this.focusToLastDetail^(^)^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     validate^(^) {>>!filename!
echo       if ^(^^!this.resource.documentDate^) throw "Document Date cannot be empty."^;>>!filename!
echo       if ^(^^!this.resource.details ^|^| this.resource.details.length ^=^=^= 0^)>>!filename!
echo         throw "Detail cannot be empty."^;>>!filename!
echo       if ^(this.resource.details.filter^(^(x^) ^=^> x.itemId^).length ^=^=^= 0^)>>!filename!
echo         throw "Detail cannot be empty."^;>>!filename!
echo       if ^(this.resource.details.filter^(^(x^) ^=^> this.parseNumber^(x.quantity^) ^=^=^= 0^).length ^> 0^)>>!filename!
echo         throw "Quantity cannot be empty."^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async save^(^) {>>!filename!
echo       try {>>!filename!
echo         this.validate^(^)^;>>!filename!
echo         this.$refs.loadingDialog.show^("Saving data..."^)^;>>!filename!
echo.>>!filename!
echo         if ^(this.mode ^=^=^= "create"^) {>>!filename!
echo           await !tabelSnake!Api.create^(this.resource^)^;>>!filename!
echo           this.storageRemove^("draft!tabelProper!"^)^;>>!filename!
echo         } else if ^(this.mode ^=^=^= "update"^)>>!filename!
echo           await !tabelSnake!Api.update^(this.resource^)^;>>!filename!
echo.>>!filename!
echo         this.$refs.loadingDialog.hide^(^)^;>>!filename!
echo         await this.$refs.informationDialog.show^(>>!filename!
echo             "Data saved successfully.",>>!filename!
echo             "!tabelSpace!">>!filename!
echo         ^)^;>>!filename!
echo         await this.$router.push^("/!tabelStrip!"^)^;>>!filename!
echo       } catch ^(error^) {>>!filename!
echo         this.$refs.loadingDialog.hide^(^)^;>>!filename!
echo         this.$refs.snackbar.showError^(error^)^;>>!filename!
echo       }>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async cancel^(^) {>>!filename!
echo       const res ^= await this.$refs.confirmationDialog.show^(>>!filename!
echo           "Cancel this transaction?",>>!filename!
echo           `!tabelSpace!`>>!filename!
echo       ^)^;>>!filename!
echo       if ^(res^) {>>!filename!
echo         if ^(this.mode ^=^=^= "create"^)>>!filename!
echo           this.storageRemove^("draft!tabelProper!"^)^;>>!filename!
echo         await this.$router.push^("/!tabelStrip!"^)^;>>!filename!
echo       }>>!filename!
echo     },>>!filename!
echo   },>>!filename!
echo }^;>>!filename!
echo ^</script^>>>!filename!


echo !tabelProper!
REM tutup istransaction
) 



REM tutup pilihan 3
) 

if %pilihan% EQU 4 (

SET folderpath=!basedir!\!projectName!.WebApp\src\api
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!Api.js
echo import http from "./http"^;>!filename!
echo.>>!filename!
echo const !tabelProper!Api ^= {>>!filename!
echo     endPoint: "api/laporan/!tabelTanpaLaporanStrip!",>>!filename!
echo.>>!filename!
echo     async generate^(>>!filename!
echo         filter ^= {>>!filename!
echo             startDate: null,>>!filename!
echo             endDate: null>>!filename!
echo         }^) {>>!filename!
echo         const response ^= await http.post^(this.endPoint, filter^)^;>>!filename!
echo         return response.data^;>>!filename!
echo     }>>!filename!
echo }^;>>!filename!
echo.>>!filename!
echo export default !tabelProper!Api^;>>!filename!

SET folderpath=!basedir!\!projectName!.WebApp\src\views\reports
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\!tabelProper!.vue
echo ^<template^>>!filename!
echo   ^<div^>>>!filename!
echo     ^<div class^="orange lighten-5 pt-3 pl-5"^>>>!filename!
echo       ^<v-row dense align^="center"^>>>!filename!
echo         ^<v-col cols^="12" md^="4"^>>>!filename!
echo           ^<h1 class^="text-h5"^>>>!filename!
echo             ^<v-icon class^="pr-2" color^="deep-orange" x-large^>mdi-file-document-outline^</v-icon^>!tabelSpace!>>!filename!
echo           ^</h1^>>>!filename!
echo         ^</v-col^>>>!filename!
echo         ^<v-col cols^="12" md^="8" class^="d-none d-md-flex pr-6"^>>>!filename!
echo           ^<v-spacer^>^</v-spacer^>>>!filename!
echo           ^<v-breadcrumbs :items^="breadcrumbs"^>>>!filename!
echo             ^<template v-slot:divider^>>>!filename!
echo               ^<v-icon^>mdi-chevron-right^</v-icon^>>>!filename!
echo             ^</template^>>>!filename!
echo           ^</v-breadcrumbs^>>>!filename!
echo         ^</v-col^>>>!filename!
echo       ^</v-row^>>>!filename!
echo     ^</div^>>>!filename!
echo.>>!filename!
echo     ^<div class^="ma-7"^>>>!filename!
echo       ^<v-row^>>>!filename!
echo         ^<v-col cols^="12" md^="8" lg^="9"^>>>!filename!
echo           ^<v-slide-group^>>>!filename!
echo             ^<div class^="mb-5"^>>>!filename!
echo               ^<v-slide-item class^="mr-2"^>>>!filename!
echo                 ^<v-btn @click^="download()"^>>>!filename!
echo                   ^<v-icon left^>mdi-download^</v-icon^>Download>>!filename!
echo                 ^</v-btn^>>>!filename!
echo               ^</v-slide-item^>>>!filename!
echo             ^</div^>>>!filename!
echo           ^</v-slide-group^>>>!filename!
echo         ^</v-col^>>>!filename!
echo         ^<v-col cols^="12" md^="4" lg^="3"^>>>!filename!
echo           ^<v-text-field>>!filename!
echo               dense>>!filename!
echo               outlined>>!filename!
echo               v-model^="search">>!filename!
echo               append-icon^="mdi-magnify">>!filename!
echo               label^="Search">>!filename!
echo               single-line>>!filename!
echo               hide-details>>!filename!
echo               class^="pb-3">>!filename!
echo           ^>^</v-text-field^>>>!filename!
echo         ^</v-col^>>>!filename!
echo       ^</v-row^>>>!filename!
echo.>>!filename!
echo       ^<v-card :disabled^="loading" class^="mb-5"^>>>!filename!
echo         ^<div class^="pt-1 pl-5 pb-1"^>>>!filename!
echo           ^<span>>!filename!
echo               class^="text-button">>!filename!
echo               style^="cursor: pointer;">>!filename!
echo               :ripple^="false">>!filename!
echo               text>>!filename!
echo               @click^="showFilter ^= ^!showFilter">>!filename!
echo           ^>>>!filename!
echo             FILTER>>!filename!
echo             ^<v-icon v-if^="^!showFilter"^>mdi-chevron-down^</v-icon^>>>!filename!
echo             ^<v-icon v-else^>mdi-chevron-up^</v-icon^>>>!filename!
echo           ^</span^>>>!filename!
echo         ^</div^>>>!filename!
echo.>>!filename!
echo         ^<v-row dense class^="pa-5" v-if^="showFilter"^>>>!filename!
echo           ^<v-col cols^="12" sm^="6" md^="2" class^="py-0"^>>>!filename!
echo             ^<DateInput v-model^="filter.startDate" label^="Start Date" dense outlined /^>>>!filename!
echo           ^</v-col^>>>!filename!
echo           ^<v-col cols^="12" sm^="6" md^="2" class^="py-0"^>>>!filename!
echo             ^<DateInput v-model^="filter.endDate" label^="End Date" dense outlined /^>>>!filename!
echo           ^</v-col^>>>!filename!
echo           ^<v-col cols^="12" class^="py-0"^>>>!filename!
echo             ^<v-btn color^="blue" dark class^="mr-2" @click^="applyFilter()"^>>>!filename!
echo               ^<v-icon^>mdi-check^</v-icon^>Apply Filter>>!filename!
echo             ^</v-btn^>>>!filename!
echo             ^<v-btn @click^="resetFilter()"^>>>!filename!
echo               ^<v-icon^>mdi-close^</v-icon^>Reset>>!filename!
echo             ^</v-btn^>>>!filename!
echo           ^</v-col^>>>!filename!
echo         ^</v-row^>>>!filename!
echo       ^</v-card^>>>!filename!
echo.>>!filename!
echo       ^<v-card^>>>!filename!
echo         ^<v-data-table>>!filename!
echo             :headers^="headers">>!filename!
echo             :items^="datasource">>!filename!
echo             :search^="search">>!filename!
echo             :items-per-page^="10">>!filename!
echo             :loading^="loading">>!filename!
echo         ^>>>!filename!
echo           ^<template v-slot:item.documentDate^="{ item }"^>{{ formatDate^(item.documentDate^) }}^</template^>>>!filename!
echo         ^</v-data-table^>>>!filename!
echo       ^</v-card^>>>!filename!
echo     ^</div^>>>!filename!
echo     ^<ConfirmationDialog ref^="confirmationDialog" /^>>>!filename!
echo     ^<DeleteDialog ref^="deleteDialog" /^>>>!filename!
echo     ^<InformationDialog ref^="informationDialog" /^>>>!filename!
echo     ^<LoadingDialog ref^="loadingDialog" /^>>>!filename!
echo     ^<Snackbar ref^="snackbar" /^>>>!filename!
echo   ^</div^>>>!filename!
echo ^</template^>>>!filename!
echo.>>!filename!
echo ^<script^>>>!filename!
echo import !tabelSnake!Api from "@src/api/!tabelProper!Api"^;>>!filename!
echo.>>!filename!
echo export default {>>!filename!
echo   name: "!tabelProper!",>>!filename!
echo.>>!filename!
echo   data^(^) {>>!filename!
echo     return {>>!filename!
echo       breadcrumbs: [>>!filename!
echo         { text: "Home", disabled: false, href: "#/" },>>!filename!
echo         { text: "Reports", disabled: false, href: "#/reports" },>>!filename!
echo         { text: "!tabelSpace!", disabled: false, href: "#/!tabelStrip!" },>>!filename!
echo       ],>>!filename!
echo       headers: [>>!filename!
set startProperty=true
for /f "delims=" %%z in (responses/!tabel!Response.cs) do (
	set str=%%z
	set str=!str:    =!
	set str=!str:,=!
	set str=!str:^)^;=!

	if !startProperty!==false (
		for /f "tokens=1,2,3,4 delims= " %%a in ("!str!") do (
			set tipeData=%%b
			set field=%%c
			
			set fieldId=!field:~-2!
			set fieldCode=!field:~-4!
			if NOT ["!fieldId!"]==["Id"] if NOT ["!field!"]==[""] (
				set field=!field:Id=!
				set fieldSnake=!field!
				CALL :SnakeCamel fieldSnake
				set fieldLow=!field!
				CALL :LoCase fieldLow

				CALL :FirstDown result !fieldSnake!
				set fieldSnake=!result!

				call :spaceTitleResult !field!
				set fieldSpace=!result!

				call :stripTitleResult !field!
				set fieldStrip=!result!
			)
		)
		if NOT ["!field!"]==[""] (
			REM			echo !tabelSnake! !tabelSpace! !field! !fieldLow! !fieldSnake! !tipeData!
echo         { text: "!fieldSpace!", value: "!fieldSnake!" },>>!filename!

		)
	)
	
	for /f "tokens=1,2,3,4 delims= " %%a in ("!str!") do (
		set responseName=%%c
		if ["!responseName!"]==["!tabel!Response"] (
			set startProperty=false
		)
	)
)
echo       ],>>!filename!
echo       datasource: [],>>!filename!
echo       filter: {>>!filename!
echo         startDate: null,>>!filename!
echo         endDate: null,>>!filename!
echo       },>>!filename!
echo       search: "",>>!filename!
echo       dialog: false,>>!filename!
echo       loading: false,>>!filename!
echo       showFilter: false,>>!filename!
echo     }^;>>!filename!
echo   },>>!filename!
echo.>>!filename!
echo   async mounted^(^) {>>!filename!
echo     document.title ^= "Inventory | !tabelSpace!"^;>>!filename!
echo   },>>!filename!
echo.>>!filename!
echo   methods: {>>!filename!
echo     download^(^) {>>!filename!
echo       const data ^= this.$xlsx.utils.json_to_sheet^(this.datasource^)^;>>!filename!
echo       const wb ^= this.$xlsx.utils.book_new^(^)^;>>!filename!
echo       this.$xlsx.utils.book_append_sheet^(wb, data, "data"^)^;>>!filename!
echo       this.$xlsx.writeFile^(wb, `!tabelProper!_${this.filter.startDate}_${this.filter.endDate}.xlsx`^)^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async applyFilter^(^) {>>!filename!
echo       try {>>!filename!
echo         this.loading ^= true^;>>!filename!
echo         const response ^= await !tabelSnake!Api.generate^(this.filter^)^;>>!filename!
echo         this.datasource ^= response.data^;>>!filename!
echo       } catch ^(error^) {>>!filename!
echo         this.$refs.snackbar.showError^(error^)^;>>!filename!
echo       }>>!filename!
echo       this.loading ^= false^;>>!filename!
echo     },>>!filename!
echo.>>!filename!
echo     async resetFilter^(^) {>>!filename!
echo       this.loading ^= true^;>>!filename!
echo       this.filter ^= {>>!filename!
echo         startDate: null,>>!filename!
echo         endDate: null>>!filename!
echo       }^;>>!filename!
echo       this.datasource ^= []^;>>!filename!
echo       this.loading ^= false^;>>!filename!
echo     },>>!filename!
echo   },>>!filename!
echo }^;>>!filename!
echo ^</script^>>>!filename!

SET folderpath=!basedir!\!projectName!.WebApp\src\router
if not exist "!folderpath!" mkdir "!folderpath!"
SET filename=!folderpath!\index.js
if exist "!filename!" (
fart -C !filename! "import Role from \"@src/views/master-data/Role.vue\"^;" "import !tabelProper! from \"@src/views/reports/!tabelProper!.vue\"^;\r\nimport Role from \"@src/views/master-data/Role.vue\"^;" >nul
fart -C !filename! "children: [" "children: [{\r\n        path: \"!tabelStrip!\",\r\n        component: !tabelProper!,\r\n      }," >nul
) else (
echo import Vue from "vue"^;>!filename!
echo import VueRouter from "vue-router"^;>>!filename!
echo import AppLayout from "@src/layouts/AppLayout.vue">>!filename!
echo import Login from "@src/views/Login.vue"^;>>!filename!
echo import Home from "@src/views/Home.vue"^;>>!filename!
echo import !tabelProper! from "@src/views/master-data/!tabelProper!.vue"^;>>!filename!
echo import Role from "@src/views/master-data/Role.vue"^;>>!filename!
echo.>>!filename!
echo Vue.use^(VueRouter^)^;>>!filename!
echo.>>!filename!
echo const routes ^= [>>!filename!
echo     {>>!filename!
echo         path: "/",>>!filename!
echo         component: AppLayout,>>!filename!
echo         children: [>>!filename!
echo             {>>!filename!
echo                 path: "",>>!filename!
echo                 component: Home>>!filename!
echo             },>>!filename!
echo             {>>!filename!
echo                 path: "!tabelSnake!",>>!filename!
echo                 component: !tabelProper!>>!filename!
echo             },>>!filename!
echo             {>>!filename!
echo                 path: "role",>>!filename!
echo                 component: Role>>!filename!
echo             },>>!filename!
echo         ]>>!filename!
echo     },>>!filename!
echo     {>>!filename!
echo         path: "/login",>>!filename!
echo         component: Login>>!filename!
echo     },>>!filename!
echo ]^;>>!filename!
echo.>>!filename!
echo const router ^= new VueRouter^({>>!filename!
echo     routes>>!filename!
echo }^)^;>>!filename!
echo.>>!filename!
echo export default router^;>>!filename!
)


)





REM tutup pilihan 4
) 

REM tutup vuetify
) 



REM tutup foreach model
) 
del fileList.log>nul
del modelList.log
goto :akhir

REM !tabelSpcLow! !tabelProper! !tabelSnake! !tabelFileName! !tabelSpace! !tabelStrip!