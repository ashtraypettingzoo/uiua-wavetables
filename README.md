# Uiua Wavetable Editor
[Try online in Uiua pad](https://uiua.org/pad?src=0_13_0-dev_2__IyBFeHBlcmltZW50YWwhCiMgVWl1YSAwLjEzLjAtZGV2LjIKfiAiZ2l0OiBnaXRodWIuY29tL2FzaHRyYXlwZXR0aW5nem9vL3VpdWEtd2F2ZXRhYmxlcyIKICB-IEFNIENudiBEd24gRk0gSFAgSFBFIEhQUCBIUFMgSFBXIEh3ZiBMUCBMUEUgTFBQIExQUyBMUFcgUGhyIFJNIFRDbWIgVENtZiBUQ3RtIFRDdHAgVE1heAogIH4gQW1wIEF2ZyBCaXQgQ2xwIENscyBDcnMgQ3RtIEN0cCBGYWQgRmxkIEZ1eiBJbnYgTWF4IE1pciBQaHMgUmN0IFJldiBTYXQgU2hmIFNsYyBTcGQgU3BsIFN0ciBTdW0gV3JwIFplcgogIH4gRG9SYW5kb23igLwgRG9SYW5kb23igLwhIERvUmFuZG9t4oC84oC8IEV4aXQgUmVwZWF0IQogIH4gRXhwb3J0IEdyYXBoIEdyYXBoSW1wdWxzZSBHcmFwaFNwZWN0cnVtIEdyYXBoU3BlY3RydW1GdWxsIEltYWdlIEltYWdlVG9UYWJsZQogIH4gSUhQRSBJSFBQIElIUFMgSUhQVyBJSWQgSUxQRSBJTFBQIElMUFMgSUxQVyBJUGhzCiAgfiBJbXBvcnRJbWFnZSBJbXBvcnRUYWJsZSBJbXBvcnRXYXZlIE5MIFByaW50IFByaW50TCBUYWJsZUF2ZXJhZ2UgVGFibGVJbmRleCBUZXN0CiAgfiBOc3QgTnN3IFB1bCBTYXcgU2lsIFNpbiBTcXIgVHJpCiAgfiBWYWwgVmFsUEkgVmFsUE8KClRlc3QgU2luMQo=)

## Basic Waveforms

### Sin [Harmonic]

<small>Example: `Graph Amp 0.8 Sin 1`</small>

![](doc-img/example-sin.png)

Generates a sine wave.

*Arguments:*

 - *Harmonic (Value)*: Wave frequency

### Saw [Harmonic]

<small>Example: `Graph Amp 0.8 Saw 1`</small>

![](doc-img/example-saw.png)

Generates a saw wave.

*Arguments:*

 - *Harmonic (Value)*: Wave frequency

### Tri [Harmonic]

<small>Example: `Graph Amp 0.8 Tri 1`</small>

![](doc-img/example-tri.png)

Generates a triangle wave.

*Arguments:*

 - *Harmonic (Value)*: Wave frequency

### Pul [Harmonic, Duty]

<small>Example: `Graph Amp 0.8 Pul 1 0.25`</small>

![](doc-img/example-pul.png)

Generates a pulse wave.

*Arguments:*

 - *Harmonic (Value)*: Wave frequency
 - *Duty (Value)*: Duty cycle, 0-1

### Sqr [Harmonic]

<small>Example: `Graph Amp 0.8 Sqr 1`</small>

![](doc-img/example-sqr.png)

Generates a square wave (pulse wave with 50% duty cycle).

*Arguments:*

 - *Harmonic (Value)*: Wave frequency

### Nsw []

<small>Example: `Graph Amp 0.8 Nsw`</small>

![](doc-img/example-nsw.png)

Generates a white noise wave.

*Arguments:* None


### Sil []

<small>Example: `Graph Sil`</small>

![](doc-img/example-sil.png)

Generates a silent wave.

*Arguments:* None

## Basic Tables

### Nst []

<small>Example: `Graph Amp 0.8 Nst`</small>

![](doc-img/example-nst.gif)

Generates a white noise table. Unlike **Nsw**, each wave in the table will be unique. 

*Arguments:* None

