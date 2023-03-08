subject: Capture-mark-recapture data of juvenile Atlantic cod (Gadus morhua) in subarctic coastal Newfoundland during their first winter
funding agencies: This research is sponsored by the NSERC Canadian Healthy Oceans Network and its Partners: Department of Fisheries and Oceans Canada and INREST (representing the Port of Sept-Îles and City of Sept-Îles). Additional funding support came from Memorial University School of Graduate Studies.
background: We evaluated size-structured overwinter mortality and movement using mark-recapture and condition metrics by marking 226 cod in two batches one week apart, in October 2016. We estimated fall and overwinter mortality, and documented movement of fish recaptured in May 2017 using Cormack-Jolly-Seber models. We applied fluorochrome markers – calcein (Sigma-Aldrich: C0875-25G) or alizarin red S (Sigma-Aldrich: A5533-25G) – to batch mark otoliths (Schmitt, 1982; Vigliola, 1997). A subsample of 60 otoliths from May 2017 recaptures was used for trace element analysis using secondary ion mass spectrometry (SIMS).
Variables that are not measured (blank cells) are specified by either a blank entry or NA.
Format: all file formats are comma separated (.csv).
All R code is available at https://github.com/eageissinger/CHONe-1.2.1


Data files:


Title: Juvenile cod field recaptures in May 2017
File name: CHONE121_codrecaptures_20170524.csv
Date of data collection: 2017-05-24
Method of data collection: See above methods.
Information on variables:
- year: year of marking
- month: month of marking
- day: day of marking
- site: location of mark (in October) or recapture (in May)
- animal_id: unique identifier for each individual fish
- sl: Standard Length (mm)
- age: age of fish
- mark: presence (1) or absence (0) of fluorochrome mark

Title: Pulse ranges
File name: CHONE121_CMRpulses_20209010.csv
Date of data collection: 2020-09-10
Method of data collection: We assigned sampled fish into recruitment pulses (see Ings et al., 2008) using size-frequency distributions and finite mixture distribution models (Macdonald and Du, 2018) in the R programming language (R Core Team, 2019).
Information on variables:
- trip: trip number
- pulse: size class (1 indicates early settlement, 4 is late settlement)
- min: minimum standard length (mm) for pulse
- max: maximum standard length (mm) for pulse
- age: age of fish
- year: year sampled
