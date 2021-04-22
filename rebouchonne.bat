@echo off

:: |---------------------------------------------------------------------------|
:: | Script permettant de renommer des fichiers bouchons bypassed vers         |
:: | l'extension d'origine, remettant en fonction ces bouchons.                |
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
  :: Mode renommage batch : on renomme tous les fichiers bypassed du répertoire
  :: vers l'extension d'origine pour remettre en fonction les bouchons.
  Ren *%originaleExt%%bypassExt% *.
) else (
  :: Mode renommage fichier : on vérifie que l'on traite bien un fichier
  :: bypassed avant d'annuler ce bypass.
  if "%fileExtension%" == "%bypassExt%" (
    Ren %fileName%%fileExtension% %fileName%.
  )
)

endlocal
