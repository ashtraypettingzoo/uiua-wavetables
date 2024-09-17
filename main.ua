# Experimental!
# Uiua 0.13.0-dev.2
~ "lib-desktop.ua"
  ~ AM Cnv Dwn FM HP HPE HPP HPS HPW Hwf LP LPE LPP LPS LPW Phr RM TCmb TCmf TCtm TCtp TMax
  ~ Amp Avg Bit Clp Cls Crs Ctm Ctp Fad Fld Fuz Inv Max Mir Phs Rct Rev Sat Shf Slc Spd Spl Str Sum Wrp Zer
  ~ DoRandom‼ DoRandom‼! DoRandom‼‼ Exit Repeat!
  ~ Export Graph GraphImpulse GraphSpectrum GraphSpectrumFull Image ImageToTable
  ~ IHPE IHPP IHPS IHPW IId ILPE ILPP ILPS ILPW IPhs
  ~ ImportImage ImportTable ImportWave NL Print PrintL TableAverage TableIndex Test
  ~ NewName RandomAudioFile RandomImageFile WriteAudio WriteGraph WriteImage WriteSpectrum WriteSpectrumFull
  ~ Nst Nsw Pul Saw Sil Sin Sqr Tri
  ~ Rnd RndI
  ~ Val ValPI ValPO

# Example code
Wave₁ ← Avg{Sin3 Amp0.7Sin2 Sin1}
Wave₂ ← AM0.4Sin7 AM0.5Sin2 Sin1
Wave₂ ← Avg{Saw1 (Pul 2 0.2)}
Wave₄ ← Bit0.7 FM0.1Sin7 Sin1
Tbl₁ ← FM(Val 0 1) Sin2 Sin1
Tbl₂ ← Max Avg{Amp(Val 0 1)Sin2 Sin1}
Tbl₃ ← Bit(Val 0 1) Crs(ValPI 0 1 2) Sin1 Sin3

Tst ← Tbl₃
Test Tst

# Leave this exit call
Exit
