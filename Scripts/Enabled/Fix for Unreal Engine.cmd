@echo off
echo Fix for games that uses Unreal Engine and have issues with intel graphics cards
setx OPENSSL_ia32cap :~0x20000000
setx OPENSSL_ia32cap :~0x20000000 /M