@echo off

if not exist %delphiooLib%\ooBatch\ (
  @echo "Clonning ooBatch..."
  git clone https://github.com/VencejoSoftware/ooBatch.git %delphiooLib%\ooBatch\
  call %delphiooLib%\ooBatch\code\get_dependencies.bat
)

if not exist %delphiooLib%\ooCipher\ (
  @echo "Clonning ooCipher..."
  git clone https://github.com/VencejoSoftware/ooCipher.git %delphiooLib%\ooCipher\
  call %delphiooLib%\ooCipher\code\get_dependencies.bat
)

if not exist %delphiooLib%\ooVersion\ (
  @echo "Clonning ooVersion..."
  git clone https://github.com/VencejoSoftware/ooVersion.git %delphiooLib%\ooVersion\
  call %delphiooLib%\ooVersion\code\get_dependencies.bat
)

if not exist %delphiooLib%\ooLibrarySearch\ (
  @echo "Clonning ooLibrarySearch..."
  git clone https://github.com/VencejoSoftware/ooLibrarySearch.git %delphiooLib%\ooLibrarySearch\
  call %delphiooLib%\ooLibrarySearch\code\get_dependencies.bat
)