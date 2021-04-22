@echo off

:: |---------------------------------------------------------------------------|
:: | Script permettant de renommer des fichiers bouchons vers une extension    |
:: | différente de celle d'origine, réalisant un bypass de ces bouchons.       |
:: |---------------------------------------------------------------------------|

:: Exécution sans argument : renommage de tous les fichiers du répertoire.
:: Exécution en glissant un fichier sur le script : renommage du fichier en
:: particulier.

setlocal EnableExtensions EnableDelayedExpansion

:: Extension des fichiers bypassed.
set bypassExt=.bypassed
:: Extension des fichiers originaux.
set originaleExt=.xml

:: On considère que par défaut, le batch est exécuté sans argument : on cherche
:: à tout renommer.
set estModeFichier=0

:: Récupération du nom de fichier glissé sur le batch, si c'est le cas.
:: Pour cela, on boucle simplement sur les arguments passés. S'il n'y en a
:: aucun, nous somme en mode "renommage batch" et non fichier !
for %%x in (%*) do (
  set estModeFichier=1
  set fileName=%~n1
  set fileExtension=%~x1
)

if "%estModeFichier%"=="0" (
  :: Mode renommage batch : on renomme tous les fichiers bouchons du répertoire
  :: pour les bypass.
  Ren *%originaleExt% *%originaleExt%%bypassExt%
) else (
  :: Mode renommage fichier : on vérifie que l'on traite bien un fichier
  :: bouchon avant de le bypass.
  if "%fileExtension%" == "%originaleExt%" (
    Ren %filename%%fileExtension% %filename%%originaleExt%%bypassExt%
  )
)

endlocal
