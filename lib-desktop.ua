# Experimental!
# Uiua 0.13.0-dev.2
L ~ "lib.ua"
  ~ AM Cnv Dwn FM HP HPE HPP HPS HPW Hwf LP LPE LPP LPS LPW Phr RM TCmb TCmf TCtm TCtp TMax
  ~ Amp Avg Bit Clp Cls Crs Ctm Ctp Fad Fld Fuz Inv Max Mir Phs Rct Rev Sat Shf Slc Spd Spl Str Sum Wrp Zer
  ~ DoRandom‼ DoRandom‼! DoRandom‼‼ Repeat!
  ~ Export Graph GraphImpulse GraphSpectrum GraphSpectrumFull Image ImageToTable
  ~ NL Print PrintL TableAverage TableIndex Test
  ~ Nst Nsw Pul Saw Sil Sin Sqr Tri
  ~ Rnd RndI
  ~ Val ValPI ValPO
  ~ IId IPhs ILPS IHPS ILPW IHPW ILPP IHPP ILPE IHPE
S ~ "settings.ua"

# ---- Utility

# Read image from file [Filename]
ImportImage ← L~RI L~O≡L~RI L~S⍜⍉≡(÷3/+↙3)◌°img&frab⊂L~DS S~InDirImage
# Read wave from file [Filename]
ImportWave ← L~R₁ L~RI L~S◌◌°audio&frab⊂L~DS S~InDirAudio
# Read 256-wave table from file [Filename]
ImportTable ← ↯L~O_L~S L~RI L~T◌◌°audio&frab⊂L~DS S~InDirAudio
# Exit (use at end of script)
Exit ← &exit0
# Save wave or table to file [Filename, Wave/Table]
WriteAudio ← &fwa⊂L~DS&fmd.S~OutDirAudio⊂⊙(".wav"audio"wav"&asrL~C♭)
# Save image to file [Filename, Wave/Table]
WriteImage ← (
  ⊂⊙(⊂S~OutSuffixImage".png"img"png"∵[..:1]↯L~O_L~S L~SU L~R L~C♭)
  &fwa⊂L~DS&fmd.S~OutDirImage)
# Save graph to file [Filename, Wave/Table]
WriteGraph ← (
  ⊂L~DS&fmd.S~OutDirGraph⊂:S~OutSuffixGraph⊙(>3⧻△.∵[..:1]L~CG)
  &fwa⨬(⊂:".png"⊙(img"png")|⊂:".gif"⊙(gif16)):
)
# Save spectrum graph to file [Filename, Wave/Table]
WriteSpectrum ← (
  ⊙L~SP
  ⊂L~DS&fmd.S~OutDirSpectrum⊂:S~OutSuffixSpectrum⊙(>3⧻△.∵[..:1])
  &fwa⨬(⊂:".png"⊙(img"png")|⊂:".gif"⊙(gif16)):
)
# Save full spectrum graph to file [Filename, Wave/Table]
WriteSpectrumFull ← (
  ⊙L~SF
  ⊂L~DS&fmd.S~OutDirSpectrum⊂:S~OutSuffixSpectrum⊙(>3⧻△.∵[..:1])
  &fwa⨬(⊂:".png"⊙(img"png")|⊂:".gif"⊙(gif16)):
)
# Generates unused name for output
NewName ← (
  ({S~OutDirAudio S~OutDirImage.S~OutDirGraph.S~OutDirSpectrum}
    ⍚(⍚↘⧻:⍥(▽∵&fif.)>1⧻.&fld.⊂"./"L~DS&fmd.)
  )
  ⍢(+1
  | {⊂:".wav"⟜(⊂⊂:S~OutSuffixImage:".png")
     ⟜(⊂⊂:S~OutSuffixGraph:".gif")⟜(⊂⊂:S~OutSuffixGraph:".png")
     ⟜(⊂⊂:S~OutSuffixSpectrum:".gif")⟜(⊂⊂:S~OutSuffixSpectrum:".png")}L~ST5,,
    /↥≡(∈°□:)

  ) 0
  L~ST5⊙◌
)
# Gets name of random .wav file [Subfolder]
RandomAudioFile ← (
  (⍚↘⧻:▽∵&fif.&fld.⊂"./"L~DS&fmd.⊂S~InDirAudio)
  ▽≡(L~CE".wav"°□).
  ⨬(""◌|°□⊏⌊×⚂⧻.)>0⧻.
)
# Gets name of random .png file [Subfolder]
RandomImageFile ← (
  (⍚↘⧻:▽∵&fif.&fld.⊂"./"L~DS&fmd.⊂S~InDirImage)
  ▽≡(L~CE".png"°□).
  ⨬(""◌|°□⊏⌊×⚂⧻.)>0⧻.
)