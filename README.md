# Uiua Wavetable Editor

### [Try online in Uiua pad](https://uiua.org/pad?src=0_13_0-dev_2__IyBFeHBlcmltZW50YWwhCiMgVWl1YSAwLjEzLjAtZGV2LjIKfiAiZ2l0OiBnaXRodWIuY29tL2FzaHRyYXlwZXR0aW5nem9vL3VpdWEtd2F2ZXRhYmxlcyIKICB-IEFNIENudiBEd24gRk0gSFAgSFBFIEhQUCBIUFMgSFBXIEh3ZiBMUCBMUEUgTFBQIExQUyBMUFcgUGhyIFJNIFRDbWIgVENtZiBUQ3RtIFRDdHAgVE1heAogIH4gQW1wIEF2ZyBCaXQgQ2xwIENscyBDcnMgQ3RtIEN0cCBGYWQgRmxkIEZ1eiBJbnYgTWF4IE1pciBQaHMgUmN0IFJldiBTYXQgU2hmIFNsYyBTcGQgU3BsIFN0ciBTdW0gV3JwIFplcgogIH4gRG9SYW5kb23igLwgRG9SYW5kb23igLwhIERvUmFuZG9t4oC84oC8IFJlcGVhdCEKICB-IEV4cG9ydCBHcmFwaCBHcmFwaEltcHVsc2UgR3JhcGhTcGVjdHJ1bSBHcmFwaFNwZWN0cnVtRnVsbCBJbWFnZSBJbWFnZVRvVGFibGUKICB-IElIUEUgSUhQUCBJSFBTIElIUFcgSUlkIElMUEUgSUxQUCBJTFBTIElMUFcgSVBocwogIH4gSW1wb3J0SW1hZ2UgSW1wb3J0VGFibGUgSW1wb3J0V2F2ZSBOTCBQcmludCBQcmludEwgVGFibGVBdmVyYWdlIFRhYmxlSW5kZXggVGVzdAogIH4gTnN0IE5zdyBQdWwgU2F3IFNpbCBTaW4gU3FyIFRyaQogIH4gVmFsIFZhbFBJIFZhbFBPCgojIEV4YW1wbGUgY29kZQpUZXN0IFNpbjEK)

Utilities for generating & editing single-cycle waveforms & wavetables in Uiua. 

- Runs on version 0.13.0-dev.2 of Uiua
- Imports 16-bit audio files as waveforms or 256-waveform tables
- Imports image files (converted to greyscale & stretched to 2048x256)
- Exports waveforms as 2048-sample, 44100hz, 16-bit .wav files
- Exports 256-waveform tables as 524288-sample, 44100hz, 16-bit .wav files
- Exports wavetable images as 2048x256 .png files (compatible with Serum)
- Exports waveform/table graphs & spectrum graphs as .png or .gif files

### Running online

1. Click the above link to open the Uiua pad.
2. Replace the code starting at the `# Example code` line.
3. Press **Run** in the bottom right or Ctrl+Enter.

*Notes:*

- Some functionality may exceed the default execution limit. This can be raised by clicking the **Show settings** gear in the top right (below the toolbar) and changing the **Exec limit** field.
- Some file-reading functionality (**ImportImage**, **ImportWave**, **ImportTable**) can be used in the online pad by dragging files into the web browser, e.g. dragging "my_wave.wav" into the web browser and running `Graph ImportWave "my_wave.wav"`.
- Some functions, such as writing files, do not work in the online editor. However, audio or images displayed in the editor via **Export**, **Graph**, **Image**, etc. can be saved by right clicking -> "Save As".

### Running on desktop

1. Install [Rust](https://www.rust-lang.org/tools/install) (>=1.78).
2. Run `cargo install --git https://github.com/uiua-lang/uiua uiua -F audio` in your command prompt/terminal.
3. [Download & extract this repository](https://github.com/ashtraypettingzoo/uiua-wavetables/archive/refs/heads/main.zip)
4. Modify **main.ua**, replacing the code starting at the `# Example code` line, making sure to leave the `Exit` call at the bottom.
5. Open the folder in your command prompt/terminal and run `uiua`
6. Press Ctrl+C to stop execution

[Full details on Uiua installation here](https://www.uiua.org/install)

### Uiua basics

Uiua is an array-oriented, stack-based programming language. You should be able to use this library without worrying much about how it works beyond a few basic points, but [the Uiua documentation, tour, & tutorial](https://www.uiua.org/docs) cover anything not mentioned here.

- With few exceptions, Uiua executes top-to-bottom, right-to-left. Functions take the results of the code to the right as inputs; for example, if `Sin 1` generates a sine wave, `Graph Sin 1` graphs that sine wave.
- Unlike many other languages, there is no special syntax for function calls. This means something like `Pul(1, 0.5)` in another langague looks like `Pul 1 0.5`
  - The documentation below lists arguments (inputs) left-to-right. For example, **Pul [Harmonic, Duty]** can be called with `Pul 1 0.5`, where 1 is the Harmonic and 0.5 is the Duty.
- Parentheses can be added for clarity, but are usually optional. `Graph (Sin 1)` is the same as `Graph Sin 1`.
- Spaces are optional, except when seperating names or numbers. `Sin1` is the same as `Sin 1`, but `Pul10.5` is different from `Pul1 0.5` and `InvSin1` is different from `Inv Sin1`.
- You can assign identifiers (names) with `←`. For example, `MySineWave ← Sin1` on one line, and `Graph MySineWave` on the next line.
  - Identifiers can contain upper/lowercase letters, but no numbers, spaces, dashes, or underscores. However, they can contain subscript numbers, which can be added by typing `__` before them. For example, typing `MySineWave__01 ← Sin1` and then running the Uiua interpreter will convert this to `MySineWave₀₁ ← Sin1`, which is valid.
- Adding `;;` to the middle of a line and running the interpreter will split the line at that point.

# Documentation

Input/output types:

- **Number**: An integer or decimal number, e.g. `1` or `0.5`.
- **Range**: A range of numbers, e.g. `(Val 1 2)`.
- **Value**: Either a **Number** or **Range**.
- **Wave**: A single-cycle waveform, e.g. `(Sin 1)`.
- **Table**: A 256-waveform table, e.g. `(Nst)` or `(Sin (Val 1 2))`
- **Wave/Table**: Either a **Wave** or **Table**.
- **Impulse(s)**: An impulse response or table of impulse responses.
- **Image**: Image data, e.g. `(ImportImage "my_image.png")`
- **String**: Text enclosed in quotes, e.g. `"Hello!"` or `"my_file.png"`

## Basic Waveforms

Generators for basic waveforms. If all the arguments are numbers (e.g. `Pul 1 0.5`), the output is a single waveform. If any of the arguments are a range (e.g. `Pul 1 (Val 0 1)`), the output is a table of waveforms.

### Sin [Harmonic]

<small>Example: `Graph Amp 0.8 Sin 1`</small>

![](doc-img/example-sin.png)

Generates a sine wave.

*Arguments:*

- *Harmonic* (**Value**): Wave frequency

*Output*: **Wave/Table**

### Saw [Harmonic]

<small>Example: `Graph Amp 0.8 Saw 1`</small>

![](doc-img/example-saw.png)

Generates a saw wave.

*Arguments:*

- *Harmonic* (**Value**): Wave frequency

*Output*: **Wave/Table**

### Tri [Harmonic]

<small>Example: `Graph Amp 0.8 Tri 1`</small>

![](doc-img/example-tri.png)

Generates a triangle wave.

*Arguments:*

- *Harmonic* (**Value**): Wave frequency

*Output*: **Wave/Table**

### Pul [Harmonic, Duty]

<small>Example: `Graph Amp 0.8 Pul 1 0.25`</small>

![](doc-img/example-pul.png)

Generates a pulse wave.

*Arguments:*

- *Harmonic* (**Value**): Wave frequency
- *Duty* (**Value**): Duty cycle, 0-1

*Output*: **Wave/Table**

### Sqr [Harmonic]

<small>Example: `Graph Amp 0.8 Sqr 1`</small>

![](doc-img/example-sqr.png)

Generates a square wave (pulse wave with 50% duty cycle).

*Arguments:*

- *Harmonic* (**Value**): Wave frequency

*Output*: **Wave/Table**

### Nsw []

<small>Example: `Graph Amp 0.8 Nsw`</small>

![](doc-img/example-nsw.png)

Generates a white noise wave.

*Arguments*: None

*Output*: **Wave/Table**

### Sil []

<small>Example: `Graph Sil`</small>

![](doc-img/example-sil.png)

Generates a silent wave.

*Arguments*: None

*Output*: **Wave/Table**

## Basic Tables

Generators for basic wavetables. Unlike the **Basic Waveforms** listed above, the output is always a table.

### Nst []

<small>Example: `Graph Amp 0.8 Nst`</small>

![](doc-img/example-nst.gif)

Generates a white noise table. Unlike **Nsw**, each wave in the table will be unique. 

*Arguments:* None

*Output*: **Table**

## Wave operations

Operations (effects/transformations) on waveforms & tables. If all **Value** arguments are **Number**s and all **Wave/Table** arguments are **Wave**s, the output is a single waveform. If any of the arguments are a **Range** or **Table**, the output is a table of waveforms.

### Sum [{Waves/Tables}]

<small>Example: `Graph Sum {Amp0.2 Saw1 Amp0.4 Sqr3}`</small>

![](doc-img/example-sum.png)

Sum a list of waves/tables.

*Output*: **Wave/Table**

### Avg [{Waves/Tables}]

<small>Example: `Graph Avg {Sin1 Sin3}`</small>

![](doc-img/example-avg.png)

Average a list of waves/tables.

*Output*: **Wave/Table**

### Amp [Amount, Wave/Table]

<small>Example: `Graph Amp0.3 Sin2`</small>

![](doc-img/example-amp.png)

Amplify a wave/table.

*Output*: **Wave/Table**

### Max [Wave/Table]

<small>Example: `Graph Max Amp0.3 Sin2`</small>

![](doc-img/example-max.png)

Maximize a wave/table by peaks. Each wave in a table is maximized independently.

*Output*: **Wave/Table**

### Ctp [Wave/Table]

<small>Example: `Graph Ctp Rct Sin1`</small>

![](doc-img/example-ctp.png)

Center a wave/table by peaks. Each wave in a table is centered independently.

*Output*: **Wave/Table**

### Ctm [Wave/Table]

<small>Example: `Graph Ctm Amp0.4 Pul 2 (Val 0 1)`</small>

![](doc-img/example-ctm.gif)

Center a wave/table by mean. Each wave in a table is centered independently.

*Output*: **Wave/Table**

### Phs [Amount, Wave/Table]

<small>Example: `Graph Phs0.25 Sin1`</small>

![](doc-img/example-phs.png)

Phase-shift a wave/table.

*Output*: **Wave/Table**

### Zer [Wave/Table]

<small>Example: `Graph Zer Saw1`</small>

![](doc-img/example-zer.png)

Phase-shift a wave/table to its rightmost zero point.

*Output*: **Wave/Table**

### Bit [Amount, Wave/Table]

<small>Example: `Graph Bit(Val 0 1) Sin1`</small>

![](doc-img/example-bit.gif)

Bitcrush a wave/table.

*Output*: **Wave/Table**

### Rev [Wave/Table]

<small>Example: `Graph Rev Pul 1 0.2`</small>

![](doc-img/example-rev.png)

Reverse a wave/table left-to-right.

*Output*: **Wave/Table**

### Inv [Wave/Table]

<small>Example: `Graph Inv Pul 1 0.2`</small>

![](doc-img/example-inv.png)

Invert a wave/table top-to-bottom.

*Output*: **Wave/Table**

### Mir [Wave/Table]

<small>Example: `Graph Mir Saw3`</small>

![](doc-img/example-mir.png)

Mirror the left half of a wave/table into the right half.

*Output*: **Wave/Table**

### Fad [Amount, Wave/Table]

<small>Example: `Graph Fad0.2 Saw1`</small>

![](doc-img/example-fad.png)

Fade the start & end of a wave/table from zero.

*Output*: **Wave/Table**

### Crs [Amount, Start Wave/Table, End Wave/Table]

<small>Example: `Graph Crs(Val 0 1) Saw2 Sin3`</small>

![](doc-img/example-crs.gif)

Crossfade between two waves/tables.

*Output*: **Wave/Table**

### Str [To, From, Wave/Table]

<small>Example: `Graph Str(Val 0.25 1) 0.25 Tri1`</small>

![](doc-img/example-str.gif)

Stretch a wave/table from one point to another.

*Output*: **Wave/Table**

### Shf [Amount, Wave/Table]

<small>Example: `Graph Shf(Val ¯0.5 0.5) Amp0.5 Sin2`</small>

![](doc-img/example-shf.gif)

Shift a wave/table vertically.

*Output*: **Wave/Table**

### Slc [Amount, Wave/Table]

<small>Example: `Graph Slc(Val 1 0.25) Sin1`</small>

![](doc-img/example-slc.gif)

Slice a wave/table from the beginning to a given point.

*Output*: **Wave/Table**

### Spd [Octaves, Wave/Table]

<small>Example: `Graph Spd(Val 1 3) Sin1`</small>

![](doc-img/example-spd.gif)

Speed a wave/table up or down in octaves.

*Output*: **Wave/Table**

### Spl [Amount, Wave/Table 1, Wave/Table 2]

<small>Example: `Graph Spl(Val 0 1) Sin1 Tri1`</small>

![](doc-img/example-spl.gif)

Splice the beginning of one wave with the end of another wave.

*Output*: **Wave/Table**

### Clp [Wave/Table]

<small>Example: `Graph Amp0.8 Clp Amp(Val 1 2) Sin1`</small>

![](doc-img/example-clp.gif)

Hard-clip a wave/table.

*Output*: **Wave/Table**

### Cls [Exponent, Wave/Table]

<small>Example: `Graph Amp0.8 Cls3 Amp(Val 1 2) Sin1`</small>

![](doc-img/example-cls.gif)

Soft-clip a wave/table.

*Output*: **Wave/Table**

### Wrp [Wave/Table]

<small>Example: `Graph Amp0.8 Wrp Amp(Val 1 2) Sin1`</small>

![](doc-img/example-wrp.gif)

Wrap the clipping parts of a wave/table to the other side.

*Output*: **Wave/Table**

### Fld [Wave/Table]

<small>Example: `Graph Amp0.8 Fld Amp(Val 1 2) Sin1`</small>

![](doc-img/example-fld.gif)

Fold the clipping parts of a wave/table backwards.

*Output*: **Wave/Table**

### Sat [Gain, Wave/Table]

<small>Example: `Graph Amp0.8 Sat(Val 1 2) Sin1`</small>

![](doc-img/example-sat.gif)

Apply tanh saturation to a wave/table.

*Output*: **Wave/Table**

### Fuz [Gain, Shift, Wave/Table]

<small>Example: `Graph Amp0.8 Fuz (Val 1 2) 0.5 Sin1`</small>

![](doc-img/example-fuz.gif)

Apply tanh fuzz to a wave/table.

*Output*: **Wave/Table**

### Rct [Wave/Table]

<small>Example: `Graph Rct Sin1`</small>

![](doc-img/example-rct.png)

Rectify a wave/table (invert negative values).

*Output*: **Wave/Table**

### AM [Amplitude, Modulator, Carrier]

<small>Example: `Graph Amp0.8 AM(Val 0 1) Sin4 Sin1`</small>

![](doc-img/example-am.gif)

Amplitude-modulate a wave/table with another wave/table.

*Output*: **Wave/Table**

### RM [Modulator, Carrier]

<small>Example: `Graph RM Sin2 Sin7`</small>

![](doc-img/example-rm.png)

Ring-modulate a wave/table with another wave/table.

*Output*: **Wave/Table**

### FM [Amplitude, Modulator, Carrier]

<small>Example: `Graph FM(Val 0 1) Sin3 Sin1`</small>

![](doc-img/example-fm.gif)

Frequency-modulate a wave/table with another wave/table.

*Output*: **Wave/Table**

### Cnv [Impulse(s), Wave/Table]

<small>Example: `Graph Cnv (ILPS 3) Sqr1`</small>

![](doc-img/example-cnv.png)

Convolve a wave/table with an impulse response.

*Output*: **Wave/Table**

### Phr [Amount, Wave/Table]

<small>Example: `Graph Phr0.2 Saw1`</small>

![](doc-img/example-phr.gif)

Randomize the phases of a wave/table's harmonics.

*Output*: **Wave/Table**

### Hwf [Amount, Filter Wave/Table, Source Wave/Table]

<small>Example: `Graph Hwf(Val 0 1) Saw3 Sqr1`</small>

![](doc-img/example-hwf.gif)

Filter a wave/table using another wave/table's harmonics.

*Output*: **Wave/Table**

### Dwn [Amount, Wave/Table]

<small>Example: `Graph Dwn(Val 0 1) Sin1`</small>

![](doc-img/example-dwn.gif)

Downsample a wave/table.

*Output*: **Wave/Table**

### LP [Harmonic, Wave/Table]

<small>Example: `Graph LP(Val 0 10) Amp0.8 Sqr1`</small>

![](doc-img/example-lp.gif)

Apply a window-adjusted sinc low-pass filter to a wave/table.

*Output*: **Wave/Table**

### HP [Harmonic, Wave/Table]

<small>Example: `Graph HP(Val 0 10) Amp0.8 Sqr1`</small>

![](doc-img/example-hp.gif)

Apply a window-adjusted sinc high-pass filter to a wave/table.

*Output*: **Wave/Table**

### LPS [Harmonic, Wave/Table]

<small>Example: `Graph LPS(Val 0 10) Amp0.8 Sqr1`</small>

![](doc-img/example-lps.gif)

Apply a sinc low-pass filter to a wave/table.

*Output*: **Wave/Table**

### HPS [Harmonic, Wave/Table]

<small>Example: `Graph HPS(Val 0 10) Amp0.8 Sqr1`</small>

![](doc-img/example-hps.gif)

Apply a sinc high-pass filter to a wave/table.

*Output*: **Wave/Table**

### LPW [Harmonic, Window, Wave/Table]

<small>Example: `Graph LPW(Val 0 10) 2 Amp0.8 Sqr1`</small>

![](doc-img/example-lpw.gif)

Apply a windowed-sinc low-pass filter to a wave/table.

*Output*: **Wave/Table**

### HPW [Harmonic, Window, Wave/Table]

<small>Example: `Graph HPW(Val 0 10) 2 Amp0.8 Sqr1`</small>

![](doc-img/example-hpw.gif)

Apply a windowed-sinc high-pass filter to a wave/table.

*Output*: **Wave/Table**

### LPP [Harmonic, Wave/Table]

<small>Example: `Graph LPP(Val 0 10) Amp0.8 Sqr1`</small>

![](doc-img/example-lpp.gif)

Apply a pulse low-pass filter to a wave/table.

*Output*: **Wave/Table**

### HPP [Harmonic, Wave/Table]

<small>Example: `Graph HPP(Val 0 10) Amp0.8 Sqr1`</small>

![](doc-img/example-hpp.gif)

Apply a pulse high-pass filter to a wave/table.

*Output*: **Wave/Table**

### LPE [Harmonic, Wave/Table]

<small>Example: `Graph LPE(Val 0 10) Amp0.8 Sqr1`</small>

![](doc-img/example-lpe.gif)

Apply an exponential low-pass filter to a wave/table.

*Output*: **Wave/Table**

### HPE [Harmonic, Wave/Table]

<small>Example: `Graph HPE(Val 0 10) Amp0.8 Sqr1`</small>

![](doc-img/example-hpe.gif)

Apply an exponential high-pass filter to a wave/table.

*Output*: **Wave/Table**

## Table operations

Operations (effects/transformations) on entire tables. Unlike the *wave operations*, these only take **Number**s as arguments (not **Range**s), and always output **Table**s (not **Waveform**s).

### TMax [Wave/Table]

<small>Example: `Graph TMax Amp(Val 0.7 0.2) Sin1`</small>

![](doc-img/example-tmax.gif)

Maximize a table by peaks. Each wave in a table is maximized depending on the peaks of the rest of the table.

*Output*: **Table**

### TCtp [Wave/Table]

<small>Example: `Graph TCtp Shf(Val 0.5 0) Amp0.5 Sin1`</small>

![](doc-img/example-tctp.gif)

Center a table by peaks. Each wave in a table is centered depending on the peaks of the rest of the table.

*Output*: **Table**

### TCtm [Wave/Table]

<small>Example: `Graph TCtm Amp0.4 Pul 2 (Val 0 0.5)`</small>

![](doc-img/example-tctm.gif)

Center a table by mean. Each wave in a table is centered depending on the mean of the rest of the table.

*Output*: **Table**

### TCmb [Amplitude, Harmonic, Wave/Table]

<small>Example: `Graph TCmb 0.5 7 Amp0.7 Saw1`</small>

![](doc-img/example-tcmb.gif)

Apply a feed-back comb filter to a table.

*Output*: **Table**

### TCmf [Amplitude, Harmonic, Wave/Table]

<small>Example: `Graph TCmf 0.5 7 Amp0.7 Saw1`</small>

![](doc-img/example-tcmf.gif)

Apply a feed-forward comb filter to a table.

*Output*: **Table**