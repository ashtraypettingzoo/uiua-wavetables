# Experimental!
# Uiua 0.13.0-dev.2

# TODO: IR importing
# TODO: fix Str (stretch) buzzing
# TODO: Sid (side by side)
# TODO: Error handling
# TODO: Fix NewName

S ← 2048                                       # Samples per oscillator
O ← 256                                        # Oscillators per table
T ← ×S O                                       # Samples per table
SU ← ÷2+1                                      # Signed to unsigned
US ← -1×2                                      # Unsigned to signed
OU ← ÷⟜⇡S                                      # Oscillator base, unsigned 0-1
OT ← ×τOU                                      # Oscillator base, trigonometric 0-2π
R ← ↯¤T                                        # Oscillator to table (repeat)
U ← ⍥(⊢⍉↯⊟:⟜÷2⊸⧻)                              # Octave up (for playback only)
GH ← 200                                       # Graph height
C ← ↥¯1↧1                                      # Clamp
SW ← ⊏◿⧻,                                      # Select (wrapped)
SI ← +⊙×⟜-⊃⊃(SW⌊)(SW⌈)(-⊸⌊)                    # Select (interpolated)
RI ← SI×⇡:÷,⧻,                                 # Resize (interpolated)
CS ← ∿+η                                       # Cosine
NR ← ↧⊸↥                                       # NaN replace
SC ← NR1÷⟜∿                                    # Sinc
VB ← ÷-1⟜⇡O                                    # Value base
VR ← +⊙×:-⟜:                                   # Value range [min, max, values]
GL ← 16                                        # GIF length (frames)
SH ← 200                                       # Spectrum graph height
FV ← ÷2√S                                      # Fourier max value
SV ← +1⌊×÷2Sⁿ2÷⟜⇡÷4S                           # Spectrum index values
SP ← ⍢⊢(=1⧻)≡(⇌⊞≥÷SH⇡SH⊏SV÷FV↙÷2S⌵fft)▽=0⇡⌊÷GL O # Spectrum graph
SF ← ⍢⊢(=1⧻)≡(⇌⊞≥÷SH⇡SH÷FV⌵fft)▽=0⇡⌊÷GL O # Spectrum graph (full)
IS ← ⨬(&gifs15|&ims)=2⧻△.                      # Show image or gif
SM ← ⇌∧(⊂+⊸⊃⋅∘(×⊙⋅⊢))⊙(:¤°⊂)                   # Scan add + multiply
MB ← ÷:1ⁿ16 2                                  # Minimum 16-bit value
FT ← ⊃(∠°ℂ)(÷FV⌵)↙+1÷2S fft                    # Fourier transform [phase, amp ← wave]
FU ← ◌°ℂ°fft⊂:⍜°ℂ¯↘1⇌↘1.ℂ⊃(×∿)(×CS)⊙(×FV)      # Fourier untransform [wave ← phase, amp]
DS ← |1 ⍥(⊂:"/")>0⧻.                           # Add slash to directory name
CG ← ⍢⊢(=1⧻)≡(⇌⬚1⊞≠⇡GH⁅×-1GH SU U2C)▽=0⇡⌊÷GL O # Create graph
ST ← ⊂↯:@0↥0-:⊙(⧻.$"_")                        # Num to string w/ trailing zeroes
CE ← ≍⬚@ ↯⊙:¤⧻.⊙⇌⇌                             # Check extension [ext, name]
True ← 1                                       # True constant
False ← 0                                      # False constant
R₀ ← ☇0                                        # Rerank zero
R₁ ← ☇1                                        # Rerank one
V! ← R₁≡^!R₀
VV! ← R₁≡^!R₀⊙R₀
VVA! ← R₁≡^!R₀⊙R₀⊙⊙R₁
VA! ← R₁≡^!R₀⊙R₁
VAA! ← R₁≡^!R₀⊙R₁⊙⊙R₁
A! ← R₁≡^!R₁
AA! ← R₁≡^!R₁⊙R₁

# ---- Impulses

# Identity (delta) impulse
IId ← ¤¤1
# Phase shifted delta impulse [Phase (0-1)]
IPhs ← V!(↻:⬚0↯¤S IId⁅×S)
# Low-pass (sinc) impulse [Harmonic]
ILPS ← V!(÷/+.SC×-πOT)
# High-pass (sinc) impulse [Harmonic]
IHPS ← V!(-:IPhs0.5ILPS)
# Low-pass (windowed) impulse [Harmonic, Window]
ILPW ← VV!(
  >0,OT:SC×-πOT
  ⨬(+1×0|××⊃(>0|<τ)⟜(++0.42⊓(×¯0.5|×0.08)∩CS⟜(×2))+π×-π)
  ÷/+.×)
# High-pass (windowed) impulse [Harmonic, Window]
IHPW ← VV!(-:IPhs0.5ILPW)
# Low-pass (pulse) impulse [Harmonic]
ILPP ← V!(↻⁅÷2+S:⬚0↯¤S↯¤,÷:1.⁅↧S÷:S↥1×2)
# High-pass (pulse) impulse [Harmonic]
IHPP ← V!(-:IPhs0.5ILPP)
# Low-pass (exponential) impulse [Harmonic]
ILPE ← V!(÷/+.ⁿ:e¯×OU×ₙeⁿ3 10)
# High-pass (exponential) impulse [Harmonic]
IHPE ← V!(-:IPhs0ILPE)

# ---- Table values

# Values (linear) [Min, Max]
Val ← VR⊙⊙(VB)
# Values (power in) [Min, Max, Base]
ValPI ← VR⊙⊙(ⁿ:VB)
# Values (power out) [Min, Max, Base]
ValPO ← ⇌ValPI:

# ---- Helpers

# Random (min-max) [Min, Max]
Rnd ← +×⚂:⟜-
# Random (min-max) [Min, Max]
RndI ← ⌊Rnd:+1:⍥:<,,

# ---- Wave Operations

# Sum [{Waves/Tables}]
Sum ← °□/+⍚R₁
# Average [{Waves/Tables}]
Avg ← Sum÷⊸⧻
# Amplify [Amount, Wave/Table]
Amp ← VA!×
# Maximize [Wave/Table]
Max ← A!(◌⍥⟜÷≠0.↥∩/↥⟜¯.)
# Center (by peaks) [Wave/Table]
Ctp ← A!(-÷2+/↧⟜/↥.)
# Center (by mean) [Wave/Table]
Ctm ← A!(-÷S/+.)
# Phase shift [Amount, Wave/Table]
Phs ← VA!(↻⁅×⧻,)
# Phase shift to zero point [Wave/Table]
Zer ← A!(↻⊗/↧⌵..)
# Bitcrush [Amount (0-1), Wave/Table]
Bit ← VA!(US↧1÷-1:⌊×,SU:⁅ⁿ:2+1×15-:1√↧1↥0)
# Reverse [Wave/Table]
Rev ← A!⇌
# Invert [Wave/Table]
Inv ← A!¯
# Mirror 1st half [Wave/Table]
Mir ← A!(⊂:⇌.↙÷2S)
# Fade start & end [Amount (0-1), Wave/Table]
Fad ← VA!(⇌⬚1×⇌:⬚1⟜×÷⧻.⇡⌊÷2×S↥0)
# Crossfade [Amount (0-1), Start Wave/Table, End Wave/Table]
Crs ← VAA!(+⊙(×-:1):⟜×⊙:)
# Stretch [To (0-1), From (0-1), Wave/Table]
Str ← VVA!(⊂⊙RI:-:S⟜RI⊙⊃↙↘∩(↧-1S↥1⁅×S↧1↥0))
# Shift up/down [Amount (¯1-1), Wave/Table]
Shf ← VA!(+)
# Slice [Amount (0-1), Wave/Table]
Slc ← VA!(RI S↯♭⁅↥1×S)
# Speed up/down [Octaves, Wave/Table]
Spd ← VA!(Slcⁿ:2)
# Splice [Amount (0-1), Wave/Table 1, Wave/Table 2]
Spl ← VAA!(⊂⊓↙↘⟜:⁅×S↧1↥0)
# Clip (hard) [Wave/Table]
Clp ← A!(C)
# Wrap [Wave/Table]
Wrp ← A!(US◿+MB1SU)
# Fold [Wave/Table]
Fld ← A!(-1⌵-2◿4-1)
# Clip (soft) [Exponent (≥2), Wave/Table]
Cls ← VA!(⍜⌵(÷-1⊙-⟜⊃ⁿ×:)C:↥2)
# Saturate (tanh) [Gain, Wave/Table]
Sat ← VA!(÷⊃+-1ⁿ:e×2×)
# Fuzz (tanh) [Gain, Shift (¯1-1), Wave/Table]
Fuz ← Sat⊙Shf
# Rectify [Wave/Table]
Rct ← A!(⌵)
# Amplutude modulation [Amplitude, Modulator, Carrier]
AM ← VAA!(×+1÷2×-1:)
# Ring modulation [Modulator, Carrier]
RM ← AA!×
# Frequency modulation [Amplitude, Modulator, Carrier]
FM ← VAA!(SI×S+OU×)
# Convolve [Impulse, Wave/Table]
Cnv ← AA!(◌°ℂ°fft×∩fft×√S⬚0↯¤S)
# Phase randomize [Amount (0-1), Wave/Table]
Phr ← ≡(FU:⊙+:FT):≡×R₁-π×τ⍥(⊂⚂)+1÷2S[]R₀⊙R₁
# Harmonic wave filter [Amount (0-1), Filter Wave/Table, Source Wave/Table]
Hwf ← VAA!(FU⊙×:+1×⊙(-1◌∩FT))
# Downsample [Amount (0-1), Wave/Table]
Dwn ← VA!(
  ⌈÷:S.⁅↥1ⁿ:2+1×-1ₙ2S-:1
  ↯¤S⍉↯⟜÷⟜(≡/+↯⊂:)
)
# Low-pass (sinc) [Harmonic, Wave/Table]
LPS ← Phs0.5Cnv ILPS
# High-pass (sinc) [Harmonic, Wave/Table]
HPS ← Phs0.5Cnv IHPS
# Low-pass (windowed) [Harmonic, Window, Wave/Table]
LPW ← Phs0.5Cnv ILPW
# High-pass (windowed) [Harmonic, Window, Wave/Table]
HPW ← Phs0.5Cnv IHPW
# Low-pass (pulse) [Harmonic, Wave/Table]
LPP ← Phs0.5Cnv ILPP
# High-pass (pulse) [Harmonic, Wave/Table]
HPP ← Phs0.5Cnv IHPP
# Low-pass (exponential) [Harmonic, Wave/Table]
LPE ← Cnv ILPE
# High-pass (exponential) [Harmonic, Wave/Table]
HPE ← Cnv IHPE
# Low-pass (default) [Harmonic, Wave/Table]
LP ← LPW.
# Low-pass (default) [Harmonic, Wave/Table]
HP ← HPW.

# ---- Table operations

# Comb filter (feedback) [Amplitude, Harmonic, Wave/Table]
TCmb ← ↯O_S SM⊙(⬚0↯⊂⌈÷:T.⁅÷:S⊙R)
# Comb filter (feedforward) [Amplitude, Harmonic, Wave/Table]
TCmf ← ↯O_S+×⊙(⊂↯:[0]¤⟜↘⌊÷:¯S⊙(.R))
# Maximize table [Wave/Table]
TMax ← ↯O_S◌⍥⟜÷≠0.↥∩/↥⟜¯.R
# Center table (by peaks) [Wave/Table]
TCtp ← ↯O_S-÷2+/↧⟜/↥.R
# Center table (by mean) [Wave/Table]
TCtm ← ↯O_S-÷T/+.R

# ---- Waveforms

# Sine wave [Harmonic]
Sin ← V!(∿×:OT)
# Saw wave [Harmonic]
Saw ← V!(US◿1×:OU)
# Triangle wave [Harmonic]
Tri ← V!(US⌵US◿1+0.25¯×:OU)
# Pulse wave [Harmonic, Duty]
Pul ← VV!(US≤US:Saw)
# Square wave [Harmonic]
Sqr ← V!(Pul:0.5)
# Noise wave []
Nsw ← (☇1US⍥(⊂⚂)S[])
# Silent (empty) wave
Sil ← R₁⬚0↯¤S[]

# ---- Tables

# Noise table []
Nst ← (⍥(⊂Nsw)O[])

# ---- Utility

# Print string [String]
Print ← &pf
# Print string with newline [String]
PrintL ← &p
# Print newline []
NL ← &p""
# Play wave or table [Wave/Table]
Export ← &ap C♭
# Play test tone of wave or table [Wave/Table]
Test ← &ap U3R C♭
# Display graph [Wave/Table]
Graph ← IS CG
# Display image [Wave/Table]
Image ← &ims↯O_S SU R C♭
# Read image from file [Filename]
ImportImage ← RI O≡RI S⍜⍉≡(÷3/+↙3)◌°img&frab
# Read wave from file [Filename]
ImportWave ← R₁ RI S◌◌°audio&frab
# Read 256-wave table from file [Filename]
ImportTable ← ↯O_S RI T◌◌°audio&frab
# Table to wave [Table]
TableAverage ← R₁÷O/+↯O_S
# Table to wave [Index (0-255), Table]
TableIndex ← R₁⊡↧-1O↥0⁅:↯O_S:
# Convert image to table [Image]
ImageToTable ← US
# Display graph of impulse [Wave/Table]
GraphImpulse ← Graph A!(⬚0×↯S1)
# Display spectrum graph [Wave/Table]
GraphSpectrum ← IS SP
# Display full spectrum graph [Wave/Table]
GraphSpectrumFull ← IS SF
# Repeat function [Function, Num]
Repeat! ← ⍥^!
# Call random function (2 choices)
DoRandom‼ ← ⨬^!^!⌊×2⚂
# Call random function (3 choices)
DoRandom‼! ← ⨬(^!|^!|^!)⌊×3⚂
# Call random function (4 choices)
DoRandom‼‼ ← ⨬(^!|^!|^!|^!)⌊×4⚂
