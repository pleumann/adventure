#!/bin/bash
OUT="bin/pasta binaries"
mkdir -p "$OUT"
rm "$OUT"/*
echo ""
echo "================================================"
echo "=== Building for Agon =========================="
echo "================================================"
echo ""
pasta80 --agon adventure
zip "$OUT/agon.zip" adventure.bin ADV.DAT
echo ""
echo "================================================"
echo "=== Building for CP/M =========================="
echo "================================================"
echo ""
pasta80 --cpm adventure
pasta80 --cpm advconf
zip "$OUT/cpm.zip" adventur.com ADV.DAT advconf.com ADVCONF.DAT
echo ""
echo "================================================"
echo "=== Building for Next =========================="
echo "================================================"
echo ""
pasta80 --zxnext --run --ovr --start 24576 --loader loader.bas adventure
cp adv.dat adventure.run
zip -r "$OUT/next.zip" adventure.run
